#include "hip/hip_runtime.h"
#include <numeric>
#include <chrono>
#define WARP_BITS 5
#define WARP_SIZE 32
#define ARRAY_SIZE 5000

__constant__ int jds_ptr_int[5000];
__constant__ int sh_zcnt_int[5000];


__global__ void spmv_jds(float *dst_vector,
						const float *d_data,const int *d_index, const int *d_perm,
						const float *x_vec,const int *d_nzcnt,const int dim)
{
	int ix=blockIdx.x*blockDim.x+threadIdx.x;
	int warp_id=ix>>WARP_BITS;
	if(ix<dim)
	{
		float sum=0.0f;
		int	bound=sh_zcnt_int[warp_id];
        // printf("bound: %d\n", (bound));
		//prefetch 0
		int j=jds_ptr_int[0]+ix;  
		float d = d_data[j]; 
		int i = d_index[j];  
		float t = x_vec[i];
		
		if (bound>1)  //bound >=2
		{
			//prefetch 1
			j=jds_ptr_int[1]+ix;    
			i =  d_index[j];  
			int in;
			float dn;
			float tn;
			for(int k=2;k<bound;k++ )
			{	
				//prefetch k-1
				dn = d_data[j]; 
				//prefetch k
				j=jds_ptr_int[k]+ix;    
				in = d_index[j]; 
				//prefetch k-1
				tn = x_vec[i];
				
				//compute k-2
				sum += d*t; 
				//sweep to k
				i = in;  
				//sweep to k-1
				d = dn;
				t =tn; 
			}	
		
			//fetch last
			dn = d_data[j];
			tn = x_vec[i];
	
			//compute last-1
			sum += d*t; 
			//sweep to last
			d=dn;
			t=tn;
		}
		//compute last
		sum += d*t;  // 3 3
		
		//write out data
		dst_vector[d_perm[ix]]=sum; 
	}

}

void initializeConstants() {
    int* h_jds_ptr_int = new int[ARRAY_SIZE];
    int* h_sh_zcnt_int = new int[ARRAY_SIZE];

    // Here fill your h_jds_ptr_int and h_sh_zcnt_int using your logic.
    for (int i=0;i<ARRAY_SIZE;i++){
        h_jds_ptr_int[i] = i;
        h_sh_zcnt_int[i] = i;
    }
    
    // Then copy the initialized values from host to device.
    hipMemcpyToSymbol(HIP_SYMBOL(jds_ptr_int), h_jds_ptr_int, sizeof(int)*ARRAY_SIZE);
    hipMemcpyToSymbol(HIP_SYMBOL(sh_zcnt_int), h_sh_zcnt_int, sizeof(int)*ARRAY_SIZE);

    delete[] h_jds_ptr_int;
    delete[] h_sh_zcnt_int;
}

// int main() {
//     const int dim = 1024; // 你可以根据需要更改这个值

//     // 首先定义你的主机端数据
//     float h_dst_vector[dim];   // 你的目标向量
//     float h_d_data[dim];       // 输入的数据
//     int h_d_index[dim];        // 输入的索引
//     int h_d_perm[dim];         // 输入的排列
//     float h_x_vec[dim];        // 输入的X向量
//     int h_d_nzcnt[dim];        // 输入的非零数

//     // 然后分配设备端内存
//     float *d_dst_vector, *d_d_data, *d_x_vec;
//     int *d_d_index, *d_d_perm, *d_d_nzcnt;

//     hipMalloc(&d_dst_vector, sizeof(float) * dim);
//     hipMalloc(&d_d_data, sizeof(float) * dim);
//     hipMalloc(&d_x_vec, sizeof(float) * dim);
//     hipMalloc(&d_d_index, sizeof(int) * dim);
//     hipMalloc(&d_d_perm, sizeof(int) * dim);
//     hipMalloc(&d_d_nzcnt, sizeof(int) * dim);

//     // 将你的主机端数据复制到设备内存中
//     hipMemcpy(d_dst_vector, h_dst_vector, sizeof(float) * dim, hipMemcpyHostToDevice);
//     hipMemcpy(d_d_data, h_d_data, sizeof(float) * dim, hipMemcpyHostToDevice);
//     hipMemcpy(d_x_vec, h_x_vec, sizeof(float) * dim, hipMemcpyHostToDevice);
//     hipMemcpy(d_d_index, h_d_index, sizeof(int) * dim, hipMemcpyHostToDevice);
//     hipMemcpy(d_d_perm, h_d_perm, sizeof(int) * dim, hipMemcpyHostToDevice);
//     hipMemcpy(d_d_nzcnt, h_d_nzcnt, sizeof(int) * dim, hipMemcpyHostToDevice);

//     // CUDA block和grid的尺寸，用于启动你的kernel。这些可以根据你的算法进行优化
//     dim3 blockSize(256);
//     dim3 gridSize((dim + blockSize.x - 1) / blockSize.x);

//     // 启动你的kernel
//     for (int i= 0; i<50; i++)
//         hipLaunchKernelGGL(spmv_jds, gridSize, blockSize, 0, 0, 
//                         d_dst_vector, d_d_data, d_d_index, d_d_perm,
//                         d_x_vec, d_d_nzcnt, dim);

//     // 将结果从设备端复制到主机端
//     hipMemcpy(h_dst_vector, d_dst_vector, sizeof(float) * dim, hipMemcpyDeviceToHost);

//     // 释放设备端内存
//     hipFree(d_dst_vector);
//     hipFree(d_d_data);
//     hipFree(d_x_vec);
//     hipFree(d_d_index);
//     hipFree(d_d_perm);
//     hipFree(d_d_nzcnt);

//     return 0;
// }

int main() {
    // //parameters declaration
	// int len;
	// int depth;
	// int dim;
	// int pad=32;
	// int nzcnt_len;
	
	// //host memory allocation
	// //matrix
	// float *h_data;
	// int *h_indices;
	// int *h_ptr;
	// int *h_perm;
	// int *h_nzcnt;
	// //vector
	// float *h_Ax_vector;
    // float *h_x_vector;
	
	// //device memory allocation
	// //matrix
	// float *d_data;
	// int *d_indices;
	// int *d_ptr;
	// int *d_perm;
	// int *d_nzcnt;
	// //vector
	// float *d_Ax_vector;
    // float *d_x_vector;

    // hipDeviceProp_t deviceProp;
    // hipGetDeviceProperties(&deviceProp, 0);
    // unsigned int grid;
	// unsigned int block;
    // compute_active_thread(&block, &grid,nzcnt_len,pad, deviceProp.major,deviceProp.minor,
	// 				deviceProp.warpSize,deviceProp.multiProcessorCount);

    // printf("grid: %d, block: %d\n", (grid, block));

    // before
    const int dim = 1024;
    const int repeat = 100;
    // 初始化主机端数据
    float h_dst_vector[dim] = {0.0f};
    float h_d_data[dim];
    int h_d_index[dim];
    int h_d_perm[dim];
    float h_x_vec[dim];
    int h_d_nzcnt[dim];
    
    // 填充数据
    std::fill(h_d_data, h_d_data+dim, 1.0f);
    std::iota(h_d_index, h_d_index+dim, 0);
    std::iota(h_d_perm, h_d_perm+dim, 0);
    std::fill(h_x_vec, h_x_vec+dim, 1.0f);
    std::fill(h_d_nzcnt, h_d_nzcnt+dim, dim);

    // 分配设备端内存
    float *d_dst_vector, *d_d_data, *d_x_vec;
    int *d_d_index, *d_d_perm, *d_d_nzcnt;

    hipMalloc(&d_dst_vector, sizeof(float) * dim);
    hipMalloc(&d_d_data, sizeof(float) * dim);
    hipMalloc(&d_x_vec, sizeof(float) * dim);
    hipMalloc(&d_d_index, sizeof(int) * dim);
    hipMalloc(&d_d_perm, sizeof(int) * dim);
    hipMalloc(&d_d_nzcnt, sizeof(int) * dim);

    // 复制主机数据到设备端
    hipMemcpy(d_dst_vector, h_dst_vector, sizeof(float) * dim, hipMemcpyHostToDevice);
    hipMemcpy(d_d_data, h_d_data, sizeof(float) * dim, hipMemcpyHostToDevice);
    hipMemcpy(d_x_vec, h_x_vec, sizeof(float) * dim, hipMemcpyHostToDevice);
    hipMemcpy(d_d_index, h_d_index, sizeof(int) * dim, hipMemcpyHostToDevice);
    hipMemcpy(d_d_perm, h_d_perm, sizeof(int) * dim, hipMemcpyHostToDevice);
    hipMemcpy(d_d_nzcnt, h_d_nzcnt, sizeof(int) * dim, hipMemcpyHostToDevice);

	initializeConstants();

    // 定义 CUDA block和grid的尺寸
    dim3 blockSize(256);
    dim3 gridSize((dim + blockSize.x - 1) / blockSize.x);

	// printf("gridSize: %d, blockSize: %d\n", (gridSize, blockSize));

    // 启动你的kernel
    auto start = std::chrono::steady_clock::now();
    for (int i= 0; i<repeat; i++)
        hipLaunchKernelGGL(spmv_jds, gridSize, blockSize, 0, 0, 
                        d_dst_vector, d_d_data, d_d_index, d_d_perm,
                        d_x_vec, d_d_nzcnt, dim);
    auto end = std::chrono::steady_clock::now();
    auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    printf("%f ms\n", (time * 1e-6f));

    // 将结果从设备端复制到主机端
    hipMemcpy(h_dst_vector, d_dst_vector, sizeof(float) * dim, hipMemcpyDeviceToHost);

    // 释放设备端内存
    hipFree(d_dst_vector);
    hipFree(d_d_data);
    hipFree(d_x_vec);
    hipFree(d_d_index);
    hipFree(d_d_perm);
    hipFree(d_d_nzcnt);

    return 0;
}
