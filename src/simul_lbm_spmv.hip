/***************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ***************************************************************************/

/*############################################################################*/

#include "../include/simul_lbm_spmv/main.h"
#include "../include/simul_lbm_spmv/lbm.h"
#include "../include/simul_lbm_spmv/lbm.cu"
#include "../include/simul_lbm_spmv/lbm_kernel.cu"
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

#include "../include/simul_lbm_spmv/parboil.h"
#include "../include/simul_lbm_spmv/convert_dataset.h"
#include "../include/simul_lbm_spmv/file.h"
#include "../include/simul_lbm_spmv/gpu_info.h"
#include "../include/simul_lbm_spmv/spmv_jds.h"
#include "../include/simul_lbm_spmv/jds_kernels.cu"
#include <chrono>



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
	

	int len;int depth;int dim;int pad=32;int nzcnt_len;
	float *h_data;int *h_indices;int *h_ptr;int *h_perm;int *h_nzcnt;
	float *h_Ax_vector;float *h_x_vector;
	float *d_data;int *d_indices;int *d_ptr;int *d_perm;int *d_nzcnt;
	float *d_Ax_vector;float *d_x_vector;
    int col_count;
	coo_to_jds(
		"/workspace/Inst-level-cache-management/include/spmv_my/dataset/demo_matrix.mtx",
		1, // row padding
		pad, // warp size, IMPORTANT: change in kernel as well
		1, // pack size
		1, // is mirrored? // 为什么mirrored之后bypass就会很有效果？
		0, // binary matrix
		0, // debug level [0:2]
		&h_data, &h_ptr, &h_nzcnt, &h_indices, &h_perm,
		&col_count, &dim, &len, &nzcnt_len, &depth
	);
    
    h_Ax_vector=(float*)malloc(sizeof(float)*dim); 
	h_x_vector=(float*)malloc(sizeof(float)*dim);
	input_vec("/workspace/Inst-level-cache-management/include/spmv_my/dataset/demo_vector.mtx", h_x_vector, dim);
	hipDeviceProp_t deviceProp;
    hipGetDeviceProperties(&deviceProp, 0);
	//memory allocation
	hipMalloc((void **)&d_data, len*sizeof(float));
	hipMalloc((void **)&d_indices, len*sizeof(int));
	hipMalloc((void **)&d_ptr, depth*sizeof(int));
	hipMalloc((void **)&d_perm, dim*sizeof(int));
	hipMalloc((void **)&d_nzcnt, nzcnt_len*sizeof(int));
	hipMalloc((void **)&d_x_vector, dim*sizeof(float));
	hipMalloc((void **)&d_Ax_vector,dim*sizeof(float));
	hipMemset( (void *) d_Ax_vector, 0, dim*sizeof(float));
	//memory copy
	hipMemcpy(d_data, h_data, len*sizeof(float), hipMemcpyHostToDevice);
	hipMemcpy(d_indices, h_indices, len*sizeof(int), hipMemcpyHostToDevice);
	hipMemcpy(d_perm, h_perm, dim*sizeof(int), hipMemcpyHostToDevice);
	hipMemcpy(d_x_vector, h_x_vector, dim*sizeof(int), hipMemcpyHostToDevice); // 为什么不是float，改为float会一直卡住？
	hipMemcpyToSymbol(HIP_SYMBOL(jds_ptr_int), h_ptr, depth*sizeof(int));
	hipMemcpyToSymbol(HIP_SYMBOL(sh_zcnt_int), h_nzcnt,nzcnt_len*sizeof(int));
    hipDeviceSynchronize();
	unsigned int grid; unsigned int block;
    compute_active_thread(&block, &grid, nzcnt_len, pad, deviceProp.major,deviceProp.minor,
					deviceProp.warpSize, deviceProp.multiProcessorCount);
    printf("grid: %d, block:%d \n", grid, block);


    hipStream_t stream1, stream2;
    hipStreamCreate(&stream1);
    hipStreamCreate(&stream2);
    
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
        
        spmv_jds<<<grid, block, 0, stream2>>>(d_Ax_vector,
					d_data,d_indices,d_perm,
					d_x_vector,d_nzcnt,dim);
        

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

	MAIN_finalize( &param );
	LBM_freeGrid( (float**) &TEMP_srcGrid );
    pb_FreeParameters(params);

    hipMemcpy(h_Ax_vector, d_Ax_vector,dim*sizeof(float), hipMemcpyDeviceToHost);	
	hipDeviceSynchronize();
	hipFree(d_data);hipFree(d_indices);hipFree(d_ptr);
    hipFree(d_perm);hipFree(d_nzcnt);hipFree(d_x_vector);
	hipFree(d_Ax_vector);
    free (h_data);free (h_indices);free (h_ptr);
	free (h_perm);free (h_nzcnt);free (h_Ax_vector);
	free (h_x_vector);

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

