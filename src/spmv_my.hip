
#include "../include/spmv_my/parboil.h"
#include "../include/spmv_my/convert_dataset.h"
#include "../include/spmv_my/file.h"
#include "../include/spmv_my/gpu_info.h"
#include "../include/spmv_my/spmv_jds.h"
#include "../include/spmv_my/jds_kernels.cu"


#include <stdio.h>
#include <stdlib.h>
#include <chrono>

/*
static int generate_vector(float *x_vector, int dim) 
{	
	srand(54321);	
	for(int i=0;i<dim;i++)
	{
		x_vector[i] = (rand() / (float) RAND_MAX);
	}
	return 0;
}
*/

int main(int argc, char** argv) {
	struct pb_TimerSet timers;
	struct pb_Parameters *parameters;
	
	const int repeat = 200;
	
	
	
	// printf("CUDA accelerated sparse matrix vector multiplication****\n");
	// printf("Original version by Li-Wen Chang <lchang20@illinois.edu> and Shengzhao Wu<wu14@illinois.edu>\n");
	// printf("This version maintained by Chris Rodrigues  ***********\n");
	parameters = pb_ReadParameters(&argc, argv);
	// if ((parameters->inpFiles[0] == NULL) || (parameters->inpFiles[1] == NULL))
    // {
    //   fprintf(stderr, "Expecting two input filenames\n");
    //   exit(-1);
    // }

	
	pb_InitializeTimerSet(&timers);
	pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	
	//parameters declaration
	int len;
	int depth;
	int dim;
	int pad=32;
	int nzcnt_len;
	
	//host memory allocation
	//matrix
	float *h_data;
	int *h_indices;
	int *h_ptr;
	int *h_perm;
	int *h_nzcnt;
	//vector
	float *h_Ax_vector;
    float *h_x_vector;
	
	//device memory allocation
	//matrix
	float *d_data;
	int *d_indices;
	int *d_ptr;
	int *d_perm;
	int *d_nzcnt;
	//vector
	float *d_Ax_vector;
    float *d_x_vector;
	
    //load matrix from files
	pb_SwitchToTimer(&timers, pb_TimerID_IO);
	// inputData(parameters->inpFiles[0], &len, &depth, &dim,&nzcnt_len,&pad,
	//    &h_data, &h_indices, &h_ptr,
	//    &h_perm, &h_nzcnt);
	int col_count;
	coo_to_jds(
		// parameters->inpFiles[0], // bcsstk32.mtx, fidapm05.mtx, jgl009.mtx
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

	// printf("h_data:\n");
	// for(int i=0; i<len; i++) {
    //     printf("%f ", h_data[i]);
	// 	if (i%32==31)  printf("\n");
    // }
	// printf("\n");

	// printf("h_indices:\n");
	// for(int i=0; i<len; i++) {
    //     printf("%d ", h_indices[i]);
	// 	if (i%32==31)  printf("\n");
    // }
	// printf("\n");



	// printf("h_ptr:\n");
	// for(int i=0; i<col_count; i++) {
    //     printf("%d ", h_ptr[i]);
    // }
	// printf("\n");

	// printf("h_perm:\n");
	// for(int i=0; i<col_count; i++) {
    //     printf("%d ", h_perm[i]);
    // }
	// printf("\n");

	// printf("h_nzcnt:\n");
	// for(int i=0; i<col_count; i++) {
    //     printf("%d ", h_nzcnt[i]);
    // }
	// printf("\n");

	printf("len: %d\n", len);
	printf("col_count: %d\n", col_count);
	printf("depth: %d\n", depth);
	printf("dim: %d\n", dim);
	printf("nzcnt_len:%d\n", nzcnt_len);
	

	h_Ax_vector=(float*)malloc(sizeof(float)*dim); 
	h_x_vector=(float*)malloc(sizeof(float)*dim);
	// input_vec( parameters->inpFiles[1],h_x_vector,dim);
	input_vec("/workspace/Inst-level-cache-management/include/spmv_my/dataset/demo_vector.mtx", h_x_vector, dim);

	pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	
	hipDeviceProp_t deviceProp;
    hipGetDeviceProperties(&deviceProp, 0);
	
	
	pb_SwitchToTimer(&timers, pb_TimerID_COPY);
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
	pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	unsigned int grid;
	unsigned int block;
    compute_active_thread(&block, &grid, nzcnt_len, pad, deviceProp.major,deviceProp.minor,
					deviceProp.warpSize, deviceProp.multiProcessorCount);
	printf("grid: %d, block:%d \n", grid, block);
	// printf("grid.x:%d, grid.y:%d, grid.z:%d\n", grid.x, grid.y, grid.z);
    // printf("block.x:%d, block.y:%d, block.z:%d\n", block.x, block.y, block.z);
	// grid = 32;
	// block = 2;
	// printf("after, grid: %d, block:%d \n", (grid, block));
	// printf("after, grid: %d, block:%d \n", grid, block);
	// printf("deviceProp.major:%d,deviceProp.minor:%d\n",(deviceProp.major, deviceProp.minor));
	
  	// hipFuncSetCacheConfig(spmv_jds, hipFuncCachePreferL1);

	//main execution
	pb_SwitchToTimer(&timers, pb_TimerID_KERNEL);

	// auto start = std::chrono::steady_clock::now();
	hipEvent_t start, stop;
	hipEventCreate(&start);
	hipEventCreate(&stop);
	float eventMs =1.0f;
	hipEventRecord(start, NULL);

	for (int i= 0; i<repeat; i++)           // 迭代50次？
		spmv_jds<<<grid, block>>>(d_Ax_vector,
					d_data,d_indices,d_perm,
					d_x_vector,d_nzcnt,dim);
		// hipLaunchKernelGGL(spmv_jds, 
        //            dim3(grid), 
        //            dim3(block), 
        //            0, // 要动态分配的共享内存大小，此处为0，也就是不使用
        //            0, // 这是HIP流，用于并行控制，0表示默认流
        //            d_Ax_vector,
        //            d_data, 
        //            d_indices, 
        //            d_perm,
        //            d_x_vector, 
        //            d_nzcnt,
        //            dim); 
	// hipDeviceSynchronize();
	// auto end = std::chrono::steady_clock::now();
    // auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    // CUERR // check and clear any existing errors
	// printf("%f ms\n", (time * 1e-6f));
	hipEventRecord(stop, NULL);
	hipEventSynchronize(stop);
	hipEventElapsedTime(&eventMs, start, stop);
	printf("kernel time (hipEventElapsedTime)=%6.3fms\n", eventMs);
	
	pb_SwitchToTimer(&timers, pb_TimerID_COPY);
	//HtoD memory copy
	hipMemcpy(h_Ax_vector, d_Ax_vector,dim*sizeof(float), hipMemcpyDeviceToHost);	

	hipDeviceSynchronize();

	hipFree(d_data);
    hipFree(d_indices);
    hipFree(d_ptr);
	hipFree(d_perm);
    hipFree(d_nzcnt);
    hipFree(d_x_vector);
	hipFree(d_Ax_vector);
 
	// if (parameters->outFile) {
	// 	pb_SwitchToTimer(&timers, pb_TimerID_IO);
	// 	outputData(parameters->outFile,h_Ax_vector,dim);
		
	// }
	
	if (true) {
		pb_SwitchToTimer(&timers, pb_TimerID_IO);
		outputData("/workspace/Inst-level-cache-management/include/spmv_my/dataset/output.mtx", h_Ax_vector, dim);
		
	}

	pb_SwitchToTimer(&timers, pb_TimerID_COMPUTE);
	
	free (h_data);
	free (h_indices);
	free (h_ptr);
	free (h_perm);
	free (h_nzcnt);
	free (h_Ax_vector);
	free (h_x_vector);
	pb_SwitchToTimer(&timers, pb_TimerID_NONE);

	pb_PrintTimerSet(&timers);
	pb_FreeParameters(parameters);
	// printf("%f ms\n", (time * 1e-6f));	
	printf("%6.3f ms\n", eventMs);
	return 0;

}
