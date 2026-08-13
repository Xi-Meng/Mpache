#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <chrono>
#include <hip/hip_runtime.h>
#include "../include/example_utils.hpp"

__host__ __device__
inline float hd (const float2 ap, const float2 bp)
{
  return (ap.x - bp.x) * (ap.x - bp.x)
       + (ap.y - bp.y) * (ap.y - bp.y);
}

__device__ __forceinline__
void atomic_max(float *address, float val)
{
  unsigned int ret = __float_as_uint(*address);
  while(val > __uint_as_float(ret))
  {
    unsigned int old = ret;
    if((ret = atomicCAS((unsigned int *)address, old, __float_as_uint(val))) == old)
      break;
  }
}

__global__
void computeDistance(const float2* __restrict__ Apoints,
                     const float2* __restrict__ Bpoints,
                           float*  __restrict__ distance,
                     const int numA, const int numB)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i >= numA) return;

  float d = std::numeric_limits<float>::max();
  float2 p = Apoints[i];
  for (int j = 0; j < numB; j++)
  {
    float t = hd(p, Bpoints[j]);
    d = std::min(t, d);
  }
  
  atomic_max(distance, d);
}

int main(int argc, char* argv[]) {
  const int num_Apoints = 500000;
  const int num_Bpoints = 500000;
  const int repeat = 1;

  const size_t num_Apoints_bytes = sizeof(float2) * num_Apoints;
  const size_t num_Bpoints_bytes = sizeof(float2) * num_Bpoints;

  float2 *h_Apoints = (float2*) malloc (num_Apoints_bytes);
  float2 *h_Bpoints = (float2*) malloc (num_Bpoints_bytes);
  
  srand(123);
  for (int i = 0; i < num_Apoints; i++) {
    h_Apoints[i].x = (float)rand() / (float)RAND_MAX;
    h_Apoints[i].y = (float)rand() / (float)RAND_MAX;
  }
  
  for (int i = 0; i < num_Bpoints; i++) {
    h_Bpoints[i].x = (float)rand() / (float)RAND_MAX;
    h_Bpoints[i].y = (float)rand() / (float)RAND_MAX;
  }

  float2 *d_Apoints, *d_Bpoints;
  float *d_distance;
  HIP_CHECK(hipMalloc((void**)&d_Apoints, num_Apoints_bytes));
  HIP_CHECK(hipMalloc((void**)&d_Bpoints, num_Bpoints_bytes));
  HIP_CHECK(hipMalloc((void**)&d_distance, 2 * sizeof(float)));

  HIP_CHECK(hipMemcpy(d_Apoints, h_Apoints, num_Apoints_bytes, hipMemcpyHostToDevice));
  HIP_CHECK(hipMemcpy(d_Bpoints, h_Bpoints, num_Bpoints_bytes, hipMemcpyHostToDevice));

  dim3 gridsA ((num_Apoints + 255) / 256);
  dim3 gridsB ((num_Bpoints + 255) / 256);
  dim3 blocks (256);

  float h_distance[2] = {-1.f, -1.f}; 

  double time = 0.0;

  for (int i = 0; i < repeat; i++) {
    HIP_CHECK(hipMemcpy(d_distance, h_distance, 2 * sizeof(float), hipMemcpyHostToDevice));

    HIP_CHECK(hipDeviceSynchronize());
    auto start = std::chrono::steady_clock::now();

    hipLaunchKernelGGL(computeDistance, gridsA, blocks, 0, 0, 
      d_Apoints, d_Bpoints, d_distance, num_Apoints, num_Bpoints);

    hipLaunchKernelGGL(computeDistance, gridsB, blocks, 0, 0, 
      d_Bpoints, d_Apoints, d_distance+1, num_Bpoints, num_Apoints);

    HIP_CHECK(hipDeviceSynchronize());
    auto end = std::chrono::steady_clock::now();
    time += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
  }
  printf("%f ms\n", (time * 1e-6f) / repeat);

  HIP_CHECK(hipMemcpy(h_distance, d_distance, 2 * sizeof(float), hipMemcpyDeviceToHost));

  // printf("Verifying the result may take a while..\n");
  // float r_distance = hausdorff_distance(h_Apoints, h_Bpoints, num_Apoints, num_Bpoints);
  // float t_distance = std::max(h_distance[0], h_distance[1]);

  // bool error = (fabsf(t_distance - r_distance)) > 1e-3f;
  // printf("%s\n", error ? "FAIL" : "PASS");

  free(h_Apoints);
  free(h_Bpoints);
  HIP_CHECK(hipFree(d_distance));
  HIP_CHECK(hipFree(d_Apoints));
  HIP_CHECK(hipFree(d_Bpoints));
  return 0;
}
