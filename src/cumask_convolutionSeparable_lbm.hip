/***************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ***************************************************************************/

/*############################################################################*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>
#include <hip/hip_runtime.h>
#include "../include/cumask_convolutionSeparable_lbm/conv.h"
#include "../include/cumask_convolutionSeparable_lbm/conv.cu"
#include "../include/cumask_convolutionSeparable_lbm/conv_gold.cu"

#include "../include/cumask_convolutionSeparable_lbm/main.h"
#include "../include/cumask_convolutionSeparable_lbm/lbm.h"
#include "../include/cumask_convolutionSeparable_lbm/lbm.cu"
#include "../include/cumask_convolutionSeparable_lbm/lbm_kernel.cu"
#include <sys/stat.h>

void CUDA_LBM_performStreamCollide( LBM_Grid srcGrid, LBM_Grid dstGrid, hipStream_t& stream );
static LBM_Grid CUDA_srcGrid, CUDA_dstGrid;
struct pb_TimerSet timers;

int main( int nArgs, char* arg[] ) {
    const unsigned int imageW = 29000;
    const unsigned int imageH = 29000;
    const int numIterations = 100;
    float* h_Kernel    = (float*)malloc(KERNEL_LENGTH * sizeof(float));
    float* h_Input     = (float*)malloc(imageW * imageH * sizeof(float));
    float* h_Buffer    = (float*)malloc(imageW * imageH * sizeof(float));
    float* h_OutputCPU = (float*)malloc(imageW * imageH * sizeof(float));
    float* h_OutputGPU = (float*)malloc(imageW * imageH * sizeof(float));
    srand(2009);
    for(unsigned int i = 0; i < KERNEL_LENGTH; i++) h_Kernel[i] = (float)(rand() % 16);
    for(unsigned int i = 0; i < imageW * imageH; i++) h_Input[i] = (float)(rand() % 16);
    float* d_Kernel;
    hipMalloc((void**)&d_Kernel, sizeof(float)*KERNEL_LENGTH);
    hipMemcpy(d_Kernel, h_Kernel, sizeof(float)*KERNEL_LENGTH, hipMemcpyHostToDevice);
    float* d_Input;
    hipMalloc((void**)&d_Input, sizeof(float)*imageW*imageH);
    hipMemcpy(d_Input, h_Input, sizeof(float)*imageW*imageH, hipMemcpyHostToDevice);
    float* d_Buffer;
    hipMalloc((void**)&d_Buffer, sizeof(float)*imageW*imageH);
    float* d_Output;
    hipMalloc((void**)&d_Output, sizeof(float)*imageW*imageH);
    // hipStream_t stream;
    // hipStreamCreate(&stream);  
    // convolutionRows(
    //     d_Buffer,
    //     d_Input,
    //     d_Kernel,
    //     imageW,
    //     imageH,
    //     imageW,
    //     stream);
    // convolutionColumns(
    //     d_Output,
    //     d_Buffer,
    //     d_Kernel,
    //     imageW,
    //     imageH,
    //     imageW,
    //     stream);
    // hipDeviceSynchronize();
    // hipStreamDestroy(stream);

    MAIN_Param param;
	int t;
    struct pb_Parameters* params;
    params = pb_ReadParameters(&nArgs, arg);
	static LBM_GridPtr TEMP_srcGrid;
	//Setup TEMP datastructures
	LBM_allocateGrid( (float**) &TEMP_srcGrid );
	MAIN_parseCommandLine( nArgs, arg, &param, params );
	MAIN_printInfo( &param );
	MAIN_initialize( &param );
	printf("param.nTimeSteps: %d\n", param.nTimeSteps);


    hipStream_t stream1, stream2;
    // hipStreamCreate(&stream1);
    // hipStreamCreate(&stream2);
    uint32_t cuMask1[2] = {0xFFFFFFF0, 0x00000000}; 
    hipError_t status1 = hipExtStreamCreateWithCUMask(&stream1, 2, cuMask1);
    if (status1 != hipSuccess) {
        printf("cuMask1 error!\n");
    }
    uint32_t cuMask2[2] = {0x0000000F, 0x000000FF}; 
    hipError_t status2 = hipExtStreamCreateWithCUMask(&stream2, 2, cuMask2);
    if (status2 != hipSuccess) {
        printf("cuMask2 error!\n");
    }
    
    hipEvent_t start1, start2, stop1, stop2;
    hipEvent_t start, stop;
	hipEventCreate(&start1);
    hipEventCreate(&start2);
	hipEventCreate(&stop1);
    hipEventCreate(&stop2);
    hipEventCreate(&start);
    hipEventCreate(&stop);
	float eventMs1 = 0.0f;
    float eventMs2 = 0.0f;
    float eventMs = 0.0f;
	float ttime1 = 0.0f;
    float ttime2 = 0.0f;
    float ttime = 0.0f;
	// hipEventRecord(start, NULL);
    


	for(int t = 1; t <= numIterations; t++ ) {

		hipEventRecord(start1, stream1);
        hipEventRecord(start2, stream2);
        hipEventRecord(start, NULL);

        // convolutionRows(
        //     d_Buffer,
        //     d_Input,
        //     d_Kernel,
        //     imageW,
        //     imageH,
        //     imageW,
        //     stream1);
		convolutionColumns(
            d_Output,
            d_Buffer,
            d_Kernel,
            imageW,
            imageH,
            imageW,
            stream1);
        
        CUDA_LBM_performStreamCollide( CUDA_srcGrid, CUDA_dstGrid, stream2 );

        // hipDeviceSynchronize(); // 记录的两者同步的时间
        // hipEventRecord(stop, NULL);
        // hipEventSynchronize(stop);
        // hipEventElapsedTime(&eventMs, start, stop);
        // ttime += eventMs;
        
		hipEventRecord(stop1, stream1);
        hipEventRecord(stop2, stream2);

		
        hipStreamSynchronize(stream1);
        hipStreamSynchronize(stream2);

		hipEventElapsedTime(&eventMs1, start1, stop1);
        hipEventElapsedTime(&eventMs2, start2, stop2);
		ttime1 += eventMs1;
        ttime2 += eventMs2;
		
        hipEventRecord(stop, NULL);
        hipEventSynchronize(stop);
        hipEventElapsedTime(&eventMs, start, stop);
        ttime += eventMs;

		LBM_swapGrids( &CUDA_srcGrid, &CUDA_dstGrid );

	}

  	printf("%6.3f ms\n", ttime1);
    printf("%6.3f ms\n", ttime2);
    printf("%6.3f ms\n", ttime);

    hipStreamDestroy(stream1);
    hipStreamDestroy(stream2);

	hipMemcpy(h_OutputGPU, d_Output, sizeof(float)*imageW * imageH, hipMemcpyDeviceToHost);
    free(h_OutputGPU);free(h_OutputCPU);free(h_Buffer);
    free(h_Input);free(h_Kernel);
    hipFree(d_Kernel);hipFree(d_Input);
    hipFree(d_Buffer);hipFree(d_Output);
	
    MAIN_finalize( &param );
	LBM_freeGrid( (float**) &TEMP_srcGrid );
    pb_FreeParameters(params);

	return 0;
}

void MAIN_parseCommandLine( int nArgs, char* arg[], MAIN_Param* param, struct pb_Parameters * params ) {
	struct stat fileStat;

	// if( nArgs < 2 ) {
	// 	printf( "syntax: lbm <time steps>\n" );
	// 	exit( 1 );
	// }

	// param->nTimeSteps = atoi( arg[1] );
    param->nTimeSteps = 100;

	// if( params->inpFiles[0] != NULL ) {
    if( TRUE ) {
		// param->obstacleFilename = params->inpFiles[0];
        param->obstacleFilename = "/workspace/Inst-level-cache-management/include/lbm_main/data/short/input/120_120_150_ldc.of";

		if( stat( param->obstacleFilename, &fileStat ) != 0 ) {
			printf( "MAIN_parseCommandLine: cannot stat obstacle file '%s'\n",
					param->obstacleFilename );
			exit( 1 );
		}
		if( fileStat.st_size != SIZE_X*SIZE_Y*SIZE_Z+(SIZE_Y+1)*SIZE_Z ) {
			printf( "MAIN_parseCommandLine:\n"
					"\tsize of file '%s' is %i bytes\n"
					"\texpected size is %i bytes\n",
					param->obstacleFilename, (int) fileStat.st_size,
					SIZE_X*SIZE_Y*SIZE_Z+(SIZE_Y+1)*SIZE_Z );
			exit( 1 );
		}
	}
	else param->obstacleFilename = NULL;

    // param->resultFilename = params->outFile;
    param->resultFilename = "/workspace/Inst-level-cache-management/include/lbm_main/data/temp.txt";
}

/*############################################################################*/

void MAIN_printInfo( const MAIN_Param* param ) {
	printf( "MAIN_printInfo:\n"
			"\tgrid size      : %i x %i x %i = %.2f * 10^6 Cells\n"
			"\tnTimeSteps     : %i\n"
			"\tresult file    : %s\n"
			"\taction         : %s\n"
			"\tsimulation type: %s\n"
			"\tobstacle file  : %s\n\n",
			SIZE_X, SIZE_Y, SIZE_Z, 1e-6*SIZE_X*SIZE_Y*SIZE_Z,
			param->nTimeSteps, param->resultFilename, 
			"store", "lid-driven cavity",
			(param->obstacleFilename == NULL) ? "<none>" :
			param->obstacleFilename );
}

/*############################################################################*/

void MAIN_initialize( const MAIN_Param* param ) {
	static LBM_Grid TEMP_srcGrid, TEMP_dstGrid;

        pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	//Setup TEMP datastructures
	LBM_allocateGrid( (float**) &TEMP_srcGrid );
	LBM_allocateGrid( (float**) &TEMP_dstGrid );
	LBM_initializeGrid( TEMP_srcGrid );
	LBM_initializeGrid( TEMP_dstGrid );

        pb_SwitchToTimer(&timers, pb_TimerID_IO);
	if( param->obstacleFilename != NULL ) {
		LBM_loadObstacleFile( TEMP_srcGrid, param->obstacleFilename );
		LBM_loadObstacleFile( TEMP_dstGrid, param->obstacleFilename );
	}

        pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	LBM_initializeSpecialCellsForLDC( TEMP_srcGrid );
	LBM_initializeSpecialCellsForLDC( TEMP_dstGrid );

        pb_SwitchToTimer(&timers, pb_TimerID_COPY);
	//Setup DEVICE datastructures
	CUDA_LBM_allocateGrid( (float**) &CUDA_srcGrid );
	CUDA_LBM_allocateGrid( (float**) &CUDA_dstGrid );

	//Initialize DEVICE datastructures
	CUDA_LBM_initializeGrid( (float**)&CUDA_srcGrid, (float**)&TEMP_srcGrid );
	CUDA_LBM_initializeGrid( (float**)&CUDA_dstGrid, (float**)&TEMP_dstGrid );

        pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	LBM_showGridStatistics( TEMP_srcGrid );

	LBM_freeGrid( (float**) &TEMP_srcGrid );
	LBM_freeGrid( (float**) &TEMP_dstGrid );
}

/*############################################################################*/

void MAIN_finalize( const MAIN_Param* param ) {
	LBM_Grid TEMP_srcGrid;

	//Setup TEMP datastructures
	LBM_allocateGrid( (float**) &TEMP_srcGrid );

        pb_SwitchToTimer(&timers, pb_TimerID_COPY);
	CUDA_LBM_getDeviceGrid((float**)&CUDA_srcGrid, (float**)&TEMP_srcGrid);

        pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	LBM_showGridStatistics( TEMP_srcGrid );

	LBM_storeVelocityField( TEMP_srcGrid, param->resultFilename, TRUE );

	LBM_freeGrid( (float**) &TEMP_srcGrid );
	CUDA_LBM_freeGrid( (float**) &CUDA_srcGrid );
	CUDA_LBM_freeGrid( (float**) &CUDA_dstGrid );
}
