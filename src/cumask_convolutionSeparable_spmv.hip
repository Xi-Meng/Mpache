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
#include "../include/cumask_convolutionSeparable_spmv/conv.h"
#include "../include/cumask_convolutionSeparable_spmv/conv.cu"
#include "../include/cumask_convolutionSeparable_spmv/conv_gold.cu"

#include "../include/cumask_convolutionSeparable_spmv/parboil.h"
#include "../include/cumask_convolutionSeparable_spmv/convert_dataset.h"
#include "../include/cumask_convolutionSeparable_spmv/file.h"
#include "../include/cumask_convolutionSeparable_spmv/gpu_info.h"
#include "../include/cumask_convolutionSeparable_spmv/spmv_jds.h"
#include "../include/cumask_convolutionSeparable_spmv/jds_kernels.cu"





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
    // hipStreamCreate(&stream1);
    // hipStreamCreate(&stream2);
    uint32_t cuMask1[2] = {0xFFFFFFFF, 0x000000FF}; 
    hipError_t status1 = hipExtStreamCreateWithCUMask(&stream1, 2, cuMask1);
    if (status1 != hipSuccess) {
        printf("cuMask1 error!\n");
    }
    uint32_t cuMask2[2] = {0xFFFFFFFF, 0x000000FF}; 
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

