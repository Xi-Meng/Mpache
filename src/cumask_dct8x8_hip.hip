#include <chrono>
#include <hip/hip_runtime.h>
#include "../include/simu_dct8x8_hip/DCT8x8.h"
#include "../include/simu_dct8x8_hip/DCT8x8_gold.cu"
#include "../include/simu_dct8x8_hip/kernels.cu"

void DCT8x8(
    float* d_Dst,
    const float* d_Src,
    unsigned int dct_stride,
    unsigned int dct_imageH,
    unsigned int dct_imageW,
    int dct_dir,
    hipStream_t& stream
);

int main( int nArgs, char* arg[] ) {
    const unsigned int dct_imageW = 16384;
    const unsigned int dct_imageH = 1300;
    const int dct_numIterations = 100;
    const unsigned int dct_stride = dct_imageW;
    float *dct_h_Input, *dct_h_OutputCPU, *dct_h_OutputGPU;
    dct_h_Input     = (float *)malloc(dct_imageH * dct_stride * sizeof(float));
    dct_h_OutputCPU = (float *)malloc(dct_imageH * dct_stride * sizeof(float));
    dct_h_OutputGPU = (float *)malloc(dct_imageH * dct_stride * sizeof(float));
    srand(2009);
    for(unsigned int i = 0; i < dct_imageH; i++)
        for(unsigned int j = 0; j < dct_imageW; j++)
        dct_h_Input[i * dct_stride + j] = (float)rand() / (float)RAND_MAX;
    float* dct_d_Input;
    hipMalloc((void**)&dct_d_Input, sizeof(float) * dct_imageH * dct_stride);
    hipMemcpy(dct_d_Input, dct_h_Input, sizeof(float) * dct_imageH * dct_stride, hipMemcpyHostToDevice);
    float* dct_d_Output;
    hipMalloc((void**)&dct_d_Output, sizeof(float) * dct_imageH * dct_stride);
    printf("Performing Forward DCT8x8 of %u x %u image on the device\n\n", dct_imageH, dct_imageW);
    int dct_dir = DCT_FORWARD;

	const unsigned int imageW = dct_imageW;
    const unsigned int imageH = dct_imageH;
    const int numIterations = dct_numIterations;
    const unsigned int stride = imageW;
    float *h_Input, *h_OutputCPU, *h_OutputGPU;
    h_Input     = (float *)malloc(imageH * stride * sizeof(float));
    h_OutputCPU = (float *)malloc(imageH * stride * sizeof(float));
    h_OutputGPU = (float *)malloc(imageH * stride * sizeof(float));
    srand(2009);
    for(unsigned int i = 0; i < imageH; i++)
        for(unsigned int j = 0; j < imageW; j++)
        h_Input[i * stride + j] = (float)rand() / (float)RAND_MAX;
    float* d_Input;
    hipMalloc((void**)&d_Input, sizeof(float) * imageH * stride);
    hipMemcpy(d_Input, h_Input, sizeof(float) * imageH * stride, hipMemcpyHostToDevice);
    float* d_Output;
    hipMalloc((void**)&d_Output, sizeof(float) * imageH * stride);
    printf("Performing Forward DCT8x8 of %u x %u image on the device\n\n", imageH, imageW);
    int dir = DCT_INVERSE;

    hipDeviceSynchronize();


	hipDeviceSynchronize();

    hipStream_t stream1, stream2;
    // hipStreamCreate(&stream1);
    // hipStreamCreate(&stream2);
    uint32_t cuMask1[2] = {0xFFFFF000, 0x00000000}; 
    hipError_t status1 = hipExtStreamCreateWithCUMask(&stream1, 2, cuMask1);
    if (status1 != hipSuccess) {
        printf("cuMask1 error!\n");
    }
    uint32_t cuMask2[2] = {0x00000FFF, 0x000000FF}; 
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

    for(int t = 1; t <= dct_numIterations; t++ ) {

		hipEventRecord(start1, stream1);
		hipEventRecord(start2, stream2);
		hipEventRecord(start, NULL);

        
		DCT8x8(
			dct_d_Output,
			dct_d_Input,
			dct_stride,
			dct_imageH,
			dct_imageW,
			dct_dir,
			stream1 );

		DCT8x8(
            d_Output,
            d_Input,
            stride,
            imageH,
            imageW,
            dir,
            stream2 );
        
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


	hipMemcpy(dct_h_OutputGPU, dct_d_Output, sizeof(float) * dct_imageH * dct_stride, hipMemcpyDeviceToHost);
	hipFree(dct_d_Input);
	hipFree(dct_d_Output);
	free(dct_h_OutputGPU);
	free(dct_h_OutputCPU);
	free(dct_h_Input);

	hipMemcpy(h_OutputGPU, d_Output, sizeof(float) * imageH * stride, hipMemcpyDeviceToHost);
	hipFree(d_Input);
	hipFree(d_Output);
	free(h_OutputGPU);
	free(h_OutputCPU);
	free(h_Input);

	return 0;
}