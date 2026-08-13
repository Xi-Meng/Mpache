/*
 * Copyright (c) 2016 University of Cordoba and University of Illinois
 * All rights reserved.
 *
 * Developed by:    IMPACT Research Group
 *                  University of Cordoba and University of Illinois
 *                  http://impact.crhc.illinois.edu/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * with the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 *      > Redistributions of source code must retain the above copyright notice,
 *        this list of conditions and the following disclaimers.
 *      > Redistributions in binary form must reproduce the above copyright
 *        notice, this list of conditions and the following disclaimers in the
 *        documentation and/or other materials provided with the distribution.
 *      > Neither the names of IMPACT Research Group, University of Cordoba,
 *        University of Illinois nor the names of its contributors may be used
 *        to endorse or promote products derived from this Software without
 *        specific prior written permission.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH
 * THE SOFTWARE.
 *
 */

#include <math.h>
#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <chrono>
#include <iostream>
#include <random>
#include <hip/hip_runtime.h>
#include <example_utils.hpp>

#if DOUBLE_PRECISION
#define FLOAT double
#else
#define FLOAT float
#endif

typedef struct {
  FLOAT x;
  FLOAT y;
  FLOAT z;
} XYZ;

#define divceil(n, m) (((n)-1) / (m) + 1)

inline int compare_output(XYZ *outp, XYZ *outpCPU, int NI, int NJ, int RESOLUTIONI, int RESOLUTIONJ) {
  double sum_delta2, sum_ref2, L1norm2;
  sum_delta2 = 0;
  sum_ref2 = 0;
  L1norm2 = 0;
  for (int i = 0; i < RESOLUTIONI; i++) {
    for (int j = 0; j < RESOLUTIONJ; j++) {
      sum_delta2 += fabs(outp[i * RESOLUTIONJ + j].x - outpCPU[i * RESOLUTIONJ + j].x);
      sum_ref2 += fabs(outpCPU[i * RESOLUTIONJ + j].x);
      sum_delta2 += fabs(outp[i * RESOLUTIONJ + j].y - outpCPU[i * RESOLUTIONJ + j].y);
      sum_ref2 += fabs(outpCPU[i * RESOLUTIONJ + j].y);
      sum_delta2 += fabs(outp[i * RESOLUTIONJ + j].z - outpCPU[i * RESOLUTIONJ + j].z);
      sum_ref2 += fabs(outpCPU[i * RESOLUTIONJ + j].z);
    }
  }
  L1norm2 = (double)(sum_delta2 / sum_ref2);
  if (L1norm2 >= 1e-6) {
    printf("Test failed\n");
    return 1;
  }
  return 0;
}

// BezierBlend (http://paulbourke.net/geometry/bezier/)
__host__ __device__ inline FLOAT BezierBlend(int k, FLOAT mu, int n) {
  int nn, kn, nkn;
  FLOAT blend = 1;
  nn = n;
  kn = k;
  nkn = n - k;
  while (nn >= 1) {
    blend *= nn;
    nn--;
    if (kn > 1) {
      blend /= (FLOAT)kn;
      kn--;
    }
    if (nkn > 1) {
      blend /= (FLOAT)nkn;
      nkn--;
    }
  }
  if (k > 0)
    blend *= pow(mu, (FLOAT)k);
  if (n - k > 0)
    blend *= pow(1 - mu, (FLOAT)(n - k));
  return (blend);
}

// Sequential implementation for comparison purposes
void BezierCPU(const XYZ *inp, XYZ *outp, const int NI, const int NJ, const int RESOLUTIONI, const int RESOLUTIONJ) {
  int i, j, ki, kj;
  FLOAT mui, muj, bi, bj;
  for (i = 0; i < RESOLUTIONI; i++) {
    mui = i / (FLOAT)(RESOLUTIONI - 1);
    for (j = 0; j < RESOLUTIONJ; j++) {
      muj = j / (FLOAT)(RESOLUTIONJ - 1);
      XYZ out = {0, 0, 0};
      for (ki = 0; ki <= NI; ki++) {
        bi = BezierBlend(ki, mui, NI);
        for (kj = 0; kj <= NJ; kj++) {
          bj = BezierBlend(kj, muj, NJ);
          out.x += (inp[ki * (NJ + 1) + kj].x * bi * bj);
          out.y += (inp[ki * (NJ + 1) + kj].y * bi * bj);
          out.z += (inp[ki * (NJ + 1) + kj].z * bi * bj);
        }
      }
      outp[i * RESOLUTIONJ + j] = out;
    }
  }
}

__global__ void BezierGPU(const XYZ *inp, XYZ *outp, const int NI, const int NJ, const int RESOLUTIONI,
                          const int RESOLUTIONJ) {
  int i, j, ki, kj;
  FLOAT mui, muj, bi, bj;

  i = blockDim.x * blockIdx.x + threadIdx.x;
  if (i > RESOLUTIONI)
    return;

  mui = i / (FLOAT)(RESOLUTIONI - 1);
  for (j = 0; j < RESOLUTIONJ; j++) {
    muj = j / (FLOAT)(RESOLUTIONJ - 1);
    XYZ out = {0, 0, 0};
    // #pragma unroll
    for (ki = 0; ki <= NI; ki++) {
      bi = BezierBlend(ki, mui, NI);
      // #pragma unroll
      for (kj = 0; kj <= NJ; kj++) {
        bj = BezierBlend(kj, muj, NJ);
        out.x += (inp[ki * (NJ + 1) + kj].x * bi * bj);
        out.y += (inp[ki * (NJ + 1) + kj].y * bi * bj);
        out.z += (inp[ki * (NJ + 1) + kj].z * bi * bj);
      }
    }
    outp[i * RESOLUTIONJ + j] = out;
  }
}

void run(XYZ *in, int in_size_i, int in_size_j, int out_size_i, int out_size_j, int work_group_size) {

  // XYZ *cpu_out = (XYZ *)malloc(out_size_i * out_size_j * sizeof(XYZ));
  XYZ *gpu_out = (XYZ *)malloc(out_size_i * out_size_j * sizeof(XYZ));

  // CPU run
  // auto start = std::chrono::steady_clock::now();
  // BezierCPU(in, cpu_out, in_size_i, in_size_j, out_size_i, out_size_j);
  // auto end = std::chrono::steady_clock::now();
  // auto time = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
  // std::cout << "host execution time: " << time << " ms" << std::endl;

  // Device run

  XYZ *d_in;
  XYZ *d_out;
  int in_size = (in_size_i + 1) * (in_size_j + 1) * sizeof(XYZ);
  int out_size = out_size_i * out_size_j * sizeof(XYZ);

  HIP_CHECK(hipMalloc((void **)&d_in, in_size));
  HIP_CHECK(hipMalloc((void **)&d_out, out_size));

  HIP_CHECK(hipMemcpy(d_in, in, in_size, hipMemcpyHostToDevice));

  dim3 block(work_group_size);
  dim3 grid((out_size_i + work_group_size - 1) / work_group_size);

  HIP_CHECK(hipDeviceSynchronize());
  auto kstart = std::chrono::steady_clock::now();

  hipLaunchKernelGGL(BezierGPU, grid, block, 0, 0, d_in, d_out, in_size_i, in_size_j, out_size_i, out_size_j);

  HIP_CHECK(hipDeviceSynchronize());
  auto kend = std::chrono::steady_clock::now();
  auto ktime = std::chrono::duration_cast<std::chrono::milliseconds>(kend - kstart).count();
  std::cout << ktime << " ms" << std::endl;

  HIP_CHECK(hipMemcpy(gpu_out, d_out, out_size, hipMemcpyDeviceToHost));

  // Verify
  // int status = compare_output(gpu_out, cpu_out, in_size_i, in_size_j, out_size_i, out_size_j);
  // printf("%s\n", (status == 0) ? "PASS" : "FAIL");

  // free(cpu_out);
  // free(gpu_out);
  HIP_CHECK(hipFree(d_in));
  HIP_CHECK(hipFree(d_out));
}

int main(int argc, char **argv) {

  static constexpr int in_size_ij = 8;
  static constexpr int out_size_ij = 8192;
  static constexpr int work_group_size = 256;

  int in_size = in_size_ij * in_size_ij * sizeof(XYZ);
  int out_size = out_size_ij * out_size_ij * sizeof(XYZ);

  // load data into h_in
  XYZ *h_in = (XYZ *)malloc(in_size);
  std::uniform_real_distribution<double> u(-1, 1);
  std::default_random_engine e(0);
  for (int i = 0; i < in_size; i++) {
    h_in->x = u(e);
    h_in->y = u(e);
    h_in->z = u(e);
  }

  // run the app on the cpu and gpu
  run(h_in, in_size_ij, in_size_ij, out_size_ij, out_size_ij, work_group_size);

  free(h_in);
  return 0;
}
