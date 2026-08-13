/***************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ***************************************************************************/

/*############################################################################*/

#include "../include/simul_lbm_dct/main.h"
#include "../include/simul_lbm_dct/lbm.h"
#include "../include/simul_lbm_dct/lbm.cu"
#include "../include/simul_lbm_dct/lbm_kernel.cu"
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

#include <chrono>
#include <hip/hip_runtime.h>
#include "../include/simul_lbm_dct/DCT8x8.h"
#include "../include/simul_lbm_dct/DCT8x8_gold.cu"
#include "../include/simul_lbm_dct/kernels.cu"


void DCT8x8(
    float* d_Dst,
    const float* d_Src,
    unsigned int stride,
    unsigned int dct_imageH,
    unsigned int dct_imageW,
    int dir,
    hipStream_t& stream
);
void CUDA_LBM_performStreamCollide( LBM_Grid srcGrid, LBM_Grid dstGrid, hipStream_t& stream );
/*############################################################################*/
static LBM_Grid CUDA_srcGrid, CUDA_dstGrid;


/*############################################################################*/

struct pb_TimerSet timers;
int main( int nArgs, char* arg[] ) {
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
	
    const unsigned int dct_imageW = 16384;
    const unsigned int dct_imageH = 1300;
    const int dct_numIterations = 100;
    const unsigned int stride = dct_imageW;
    float *dct_h_Input, *dct_h_OutputCPU, *dct_h_OutputGPU;
    dct_h_Input     = (float *)malloc(dct_imageH * stride * sizeof(float));
    dct_h_OutputCPU = (float *)malloc(dct_imageH * stride * sizeof(float));
    dct_h_OutputGPU = (float *)malloc(dct_imageH * stride * sizeof(float));
    srand(2009);
    for(unsigned int i = 0; i < dct_imageH; i++)
        for(unsigned int j = 0; j < dct_imageW; j++)
        dct_h_Input[i * stride + j] = (float)rand() / (float)RAND_MAX;
    float* dct_d_Input;
    hipMalloc((void**)&dct_d_Input, sizeof(float) * dct_imageH * stride);
    hipMemcpy(dct_d_Input, dct_h_Input, sizeof(float) * dct_imageH * stride, hipMemcpyHostToDevice);
    float* dct_d_Output;
    hipMalloc((void**)&dct_d_Output, sizeof(float) * dct_imageH * stride);
    printf("Performing Forward DCT8x8 of %u x %u image on the device\n\n", dct_imageH, dct_imageW);


    hipStream_t stream1, stream2;
    hipStreamCreate(&stream1);
    hipStreamCreate(&stream2);
    

    int dir = DCT_FORWARD;
    hipDeviceSynchronize();
    
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
    


	for( t = 1; t <= param.nTimeSteps; t++ ) {

		hipEventRecord(start1, stream1);
        hipEventRecord(start2, stream2);
        hipEventRecord(start, NULL);

		CUDA_LBM_performStreamCollide( CUDA_srcGrid, CUDA_dstGrid, stream1 );
        
        DCT8x8(
            dct_d_Output,
            dct_d_Input,
            stride,
            dct_imageH,
            dct_imageW,
            dir,
            stream2 );

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

    // for(int iter = 0; iter < dct_numIterations; iter++)
    //     DCT8x8(
    //         dct_d_Output,
    //         dct_d_Input,
    //         stride,
    //         dct_imageH,
    //         dct_imageW,
    //         dir );
    

  hipMemcpy(dct_h_OutputGPU, dct_d_Output, sizeof(float) * dct_imageH * stride, hipMemcpyDeviceToHost);

  hipFree(dct_d_Input);
  hipFree(dct_d_Output);
  free(dct_h_OutputGPU);
  free(dct_h_OutputCPU);
  free(dct_h_Input);


  	printf("%6.3f ms\n", ttime1);
    printf("%6.3f ms\n", ttime2);
    printf("%6.3f ms\n", ttime);

	MAIN_finalize( &param );
	LBM_freeGrid( (float**) &TEMP_srcGrid );
    pb_FreeParameters(params);

    hipStreamDestroy(stream1);
    hipStreamDestroy(stream2);
	return 0;
}

/*############################################################################*/

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

