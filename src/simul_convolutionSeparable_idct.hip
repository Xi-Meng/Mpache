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
#include "../include/simul_convolutionSeparable_dct/conv.h"
#include "../include/simul_convolutionSeparable_dct/conv.cu"
#include "../include/simul_convolutionSeparable_dct/conv_gold.cu"

#include "../include/simul_convolutionSeparable_dct/DCT8x8.h"
#include "../include/simul_convolutionSeparable_dct/DCT8x8_gold.cu"
#include "../include/simul_convolutionSeparable_dct/kernels.cu"

void DCT8x8(
    float* d_Dst,
    const float* d_Src,
    unsigned int stride,
    unsigned int dct_imageH,
    unsigned int dct_imageW,
    int dir,
    hipStream_t& stream
);

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

    const unsigned int dct_imageW = 16384;
    const unsigned int dct_imageH = 2000;
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
    // int dir = DCT_FORWARD;
    int dir = DCT_INVERSE;
    hipDeviceSynchronize();

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
	
    hipMemcpy(dct_h_OutputGPU, dct_d_Output, sizeof(float) * dct_imageH * stride, hipMemcpyDeviceToHost);
    hipFree(dct_d_Input);
    hipFree(dct_d_Output);
    free(dct_h_OutputGPU);
    free(dct_h_OutputCPU);
    free(dct_h_Input);
    

	return 0;
}

