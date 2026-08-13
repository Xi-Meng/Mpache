#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <iterator>
#include <limits>
#include <list>
#include <vector>
#include <hip/hip_runtime.h>
// #include <hipblas.h>
// #include <hipblas/hipblas.h>

// 定义加法内核
__global__ void add_matrices(float* A, float* B, float* C, float* D, float *E, int size) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if (idx < size) {
        C[idx] = A[idx] + B[idx];
        E[idx] = D[idx];
    // if (threadIdx.x % 32 == 0)
    //   shared_D[threadIdx.x/32] = D[idx];
    }
    C[idx] = A[idx] + B[idx];
    // for (int i=0; i<1000; i++){
    //   C[idx] = A[idx] + B[idx];
    // }
    
}

// // 定义减法内核
// __global__ void subtract_matrices(float* A, float* B, float* C, int size) {
//     int idx = threadIdx.x + blockIdx.x * blockDim.x;
//     if (idx < size) {
//         C[idx] = A[idx] - B[idx];
//     }
// }

// 主函数
int main() {
  // 一些用来初始化和配置的代码...
  int repeat = 1000;
  // Matrix data sizes
  int m = 10000;
  int n = 10000;

  float* a = new float[m * n];
  float* b = new float[m * n];
  float* c = new float[m * n]; 
  float* d = new float[m * n];
  float* e = new float[m * n];  

  // 设备矩阵
  float* da;
  float* db;
  float* dc;
  float* dd;
  float* de;

  // 给主机矩阵赋值（这只是一个例子, 你可以使用你自己的数据）
  for (int i = 0; i < m * n; i++) {
      a[i] = i;
      b[i] = i+i;
      d[i] = i+1;
  }

  // 在设备上分配内存
  hipMalloc((void**)&da, m*n*sizeof(float));
  hipMalloc((void**)&db, m*n*sizeof(float));
  hipMalloc((void**)&dc, m*n*sizeof(float));
  hipMalloc((void**)&dd, m*n*sizeof(float));
  hipMalloc((void**)&de, m*n*sizeof(float));

  // 从主机复制数据到设备内存
  hipMemcpy(da, a, m*n*sizeof(float), hipMemcpyHostToDevice);
  hipMemcpy(db, b, m*n*sizeof(float), hipMemcpyHostToDevice);
  hipMemcpy(dd, b, m*n*sizeof(float), hipMemcpyHostToDevice);
  hipMemcpy(de, b, m*n*sizeof(float), hipMemcpyHostToDevice);


  int size = m * n;
  dim3 block(256);  // 配置每个块中的线程数
  dim3 grid((size + block.x - 1) / block.x);  // 配置块格

  // 执行我们的内核，完成矩阵加法和减法
  auto start = std::chrono::steady_clock::now();

  for (int i = 0; i < repeat; i++){
    hipLaunchKernelGGL(add_matrices, dim3(grid), dim3(block), 0, 0, da, db, dc, dd, de, size);
  }

  // hipLaunchKernelGGL(subtract_matrices, dim3(grid), dim3(block), 0, 0, d_A, d_B, d_C, size);
  auto end = std::chrono::steady_clock::now();
  auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
  printf("%f ms\n", (time * 1e-6f) / repeat);

  // 确保计算完成并获取结果...
  // 将结果复制回主机内存
  hipMemcpy(c, dc, m*n*sizeof(float), hipMemcpyDeviceToHost);
  hipMemcpy(e, de, m*n*sizeof(float), hipMemcpyDeviceToHost);

  // 清理设备和主机内存
  hipFree(da);
  hipFree(db);
  hipFree(dc);
  hipFree(dd);
  hipFree(de);
  delete[] a;
  delete[] b;
  delete[] c;
  delete[] d;
  delete[] e;

  return 0;
}
