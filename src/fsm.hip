/*
   FSM_GA is a GPU-accelerated implementation of a genetic algorithm
   (GA) for finding well-performing finite-state machines (FSM) for predicting
   binary sequences.

   Copyright (c) 2013, Texas State University. All rights reserved.

   Redistribution and use in source and binary forms, with or without modification,
   are permitted for academic, research, experimental, or personal use provided
   that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice,
 this list of conditions, and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions, and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 * Neither the name of Texas State University nor the names of its
 contributors may be used to endorse or promote products derived from this
 software without specific prior written permission.

 For all other uses, please contact the Office for Commercialization and Industry
 Relations at Texas State University <http://www.txstate.edu/ocir/>.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Authors: Martin Burtscher
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <sys/time.h>
#include <hip/hip_runtime.h>
#include <example_utils.hpp>

// repeat the kernel exeuction
#define REPEAT 10

// inital seed for random state
#define SEED 1234

// the size of the FSM
#define FSMSIZE 8

// the number of entries per state array
#define TABSIZE 32768

// the population count, which determines the number of blocks
#define POPCNT 1024

// the population size, which determines the number of threads per block,
#define POPSIZE 256

//
#define CUTOFF 1

__device__ unsigned int LCG_random(unsigned int *seed) {
  const unsigned int m = 2147483648;
  const unsigned int a = 26757677;
  const unsigned int c = 1;
  *seed = (a * (*seed) + c) % m;
  return *seed;
}

__device__ void LCG_random_init(unsigned int *seed) {
  const unsigned int m = 2147483648;
  const unsigned int a = 26757677;
  const unsigned int c = 1;
  *seed = (a * (*seed) + c) % m;
}

__global__ void FSMKernel(const int length, const unsigned short *__restrict__ data, int *__restrict__ best,
                          unsigned int *__restrict__ rndstate, unsigned char *__restrict__ bfsm,
                          unsigned char *__restrict__ same, int *__restrict__ smax, int *__restrict__ sbest,
                          int *__restrict__ oldmax) {
  int i, d, pc, s, bit, id, misses, rnd;
  unsigned long long myresult, current;
  unsigned char *fsm, state[TABSIZE];
  __shared__ unsigned char next[FSMSIZE * 2 * POPSIZE];

  fsm = &next[threadIdx.x * (FSMSIZE * 2)];

  if (threadIdx.x == 0) {
    oldmax[blockIdx.x] = 0;
    same[blockIdx.x] = 0;
  }
  __syncthreads();

  id = threadIdx.x + blockIdx.x * blockDim.x;
  rndstate[id] = SEED ^ id;
  LCG_random_init(&rndstate[id]);

  // initial population
  for (i = 0; i < FSMSIZE * 2; i++) {
    fsm[i] = LCG_random(rndstate + id) & (FSMSIZE - 1);
  }

  // run generations until cutoff times no improvement
  do {
    // reset miss counter and initial state
    memset(state, 0, TABSIZE);
    misses = 0;

    // evaluate FSM
#pragma unroll
    for (i = 0; i < length; i++) {
      d = (int)data[i];
      pc = (d >> 1) & (TABSIZE - 1);
      bit = d & 1;
      s = (int)state[pc];
      misses += bit ^ (s & 1);
      state[pc] = fsm[s + s + bit];
    }
    for (; i < length; i++) {
      d = (int)data[i];
      pc = (d >> 1) & (TABSIZE - 1);
      bit = d & 1;
      s = (int)state[pc];
      misses += bit ^ (s & 1);
      state[pc] = fsm[s + s + bit];
    }

    // determine best FSM
    if (threadIdx.x == 0) {
      atomicAdd(&best[2], 1); // increment generation count
      smax[blockIdx.x] = 0;
      sbest[blockIdx.x] = 0;
    }
    __syncthreads();
    atomicMax(&smax[blockIdx.x], length - misses);
    __syncthreads();
    if (length - misses == smax[blockIdx.x])
      atomicMax(&sbest[blockIdx.x], threadIdx.x);
    __syncthreads();
    bit = 0;
    if (sbest[blockIdx.x] == threadIdx.x) {
      // check if there was an improvement
      same[blockIdx.x]++;
      if (oldmax[blockIdx.x] < smax[blockIdx.x]) {
        oldmax[blockIdx.x] = smax[blockIdx.x];
        same[blockIdx.x] = 0;
      }
    } else {
      // select 1/8 of threads for mutation (best FSM does crossover)
      if ((LCG_random(rndstate + id) & 7) == 0)
        bit = 1;
    }
    __syncthreads();

    if (bit) {
      // mutate best FSM by flipping random bits with 1/4th probability
      for (i = 0; i < FSMSIZE * 2; i++) {
        rnd = LCG_random(rndstate + id) & LCG_random(rndstate + id);
        fsm[i] = (next[i + sbest[blockIdx.x] * FSMSIZE * 2] ^ rnd) & (FSMSIZE - 1);
      }
    } else {
      // crossover best FSM with random FSMs using 3/4 of bits from best FSM
      for (i = 0; i < FSMSIZE * 2; i++) {
        rnd = LCG_random(rndstate + id) & LCG_random(rndstate + id);
        fsm[i] = (fsm[i] & rnd) | (next[i + sbest[blockIdx.x] * FSMSIZE * 2] & ~rnd);
      }
    }
  } while (same[blockIdx.x] < CUTOFF); // end of loop over generations

  // record best result of this block
  if (sbest[blockIdx.x] == threadIdx.x) {
    id = blockIdx.x;
    myresult = length - misses;
    myresult = (myresult << 32) + id;
    current = *((unsigned long long *)best);
    while (myresult > current) {
      atomicCAS((unsigned long long *)best, current, myresult);
      current = *((unsigned long long *)best);
    }
    for (i = 0; i < FSMSIZE * 2; i++) {
      bfsm[id * (FSMSIZE * 2) + i] = fsm[i];
    }
  }
}

__global__ void MaxKernel(int *__restrict__ best, const unsigned char *__restrict__ bfsm) {
  // copy best FSM state assignment over
  int id = best[0];
  for (int i = 0; i < FSMSIZE * 2; i++) {
    best[i + 3] = bfsm[id * (FSMSIZE * 2) + i];
  }
}

int main(int argc, char *argv[]) {
  int length = 32768;

  assert(sizeof(unsigned short) == 2);
  assert(0 < length);
  assert((FSMSIZE & (FSMSIZE - 1)) == 0);
  assert((TABSIZE & (TABSIZE - 1)) == 0);
  assert((0 < FSMSIZE) && (FSMSIZE <= 256));
  assert((0 < TABSIZE) && (TABSIZE <= 32768));
  assert(0 < POPCNT);
  assert((0 < POPSIZE) && (POPSIZE <= 1024));
  assert(0 < CUTOFF);

  int i, j, d, s, bit, pc, misses, besthits, generations;
  unsigned short *data, *d_data;
  unsigned char state[TABSIZE], fsm[FSMSIZE * 2];
  int *d_best, best[FSMSIZE * 2 + 3], trans[FSMSIZE][2];
  unsigned int *d_state;
  unsigned char *d_bfsm, *d_same;
  int *d_smax, *d_sbest, *d_oldmax;
  double runtime;
  struct timeval starttime, endtime;

  data = (unsigned short *)malloc(sizeof(unsigned short) * length);

  srand(123);
  for (int i = 0; i < length; i++)
    data[i] = rand();

  // printf("%d\t#kernel execution times\n", REPEAT);
  // printf("%d\t#fsm size\n", FSMSIZE);
  // printf("%d\t#entries\n", length);
  // printf("%d\t#tab size\n", TABSIZE);
  // printf("%d\t#blocks\n", POPCNT);
  // printf("%d\t#threads\n", POPSIZE);
  // printf("%d\t#cutoff\n", CUTOFF);

  HIP_CHECK(hipMalloc((void **)&d_data, sizeof(unsigned short) * length));
  HIP_CHECK(hipMemcpy(d_data, data, sizeof(unsigned short) * length, hipMemcpyHostToDevice));

  HIP_CHECK(hipMalloc((void **)&d_best, sizeof(int) * (FSMSIZE * 2 + 3)));
  HIP_CHECK(hipMalloc((void **)&d_state, POPCNT * POPSIZE * sizeof(unsigned int)));
  HIP_CHECK(hipMalloc((void **)&d_bfsm, POPCNT * FSMSIZE * 2 * sizeof(unsigned char)));
  HIP_CHECK(hipMalloc((void **)&d_same, POPCNT * sizeof(unsigned char)));
  HIP_CHECK(hipMalloc((void **)&d_smax, POPCNT * sizeof(int)));
  HIP_CHECK(hipMalloc((void **)&d_sbest, POPCNT * sizeof(int)));
  HIP_CHECK(hipMalloc((void **)&d_oldmax, POPCNT * sizeof(int)));

  HIP_CHECK(hipDeviceSynchronize());
  gettimeofday(&starttime, NULL);

  for (int i = 0; i < REPEAT; i++) {
    HIP_CHECK(hipMemset(d_best, 0, sizeof(int) * (FSMSIZE * 2 + 3)));
    hipLaunchKernelGGL(FSMKernel, POPCNT, POPSIZE, 0, 0, length, d_data, d_best, d_state, d_bfsm, d_same, d_smax,
                       d_sbest, d_oldmax);
    hipLaunchKernelGGL(MaxKernel, 1, 1, 0, 0, d_best, d_bfsm);
  }
  HIP_CHECK(hipDeviceSynchronize());
  gettimeofday(&endtime, NULL);

  runtime = endtime.tv_sec + endtime.tv_usec / 1000000.0 - starttime.tv_sec - starttime.tv_usec / 1000000.0;
  printf("%.6lf ms\n", runtime * 1000 / REPEAT);

  HIP_CHECK(hipMemcpy(best, d_best, sizeof(int) * (FSMSIZE * 2 + 3), hipMemcpyDeviceToHost));
  besthits = best[1];
  generations = best[2];
  // printf("%.6lf\t#throughput [Gtr/s]\n", 0.000000001 * POPSIZE * generations * length / (runtime / REPEAT));

  // evaluate saturating up/down counter
  // for (i = 0; i < FSMSIZE; i++) {
  //   fsm[i * 2 + 0] = i - 1;
  //   fsm[i * 2 + 1] = i + 1;
  // }
  // fsm[0] = 0;
  // fsm[(FSMSIZE - 1) * 2 + 1] = FSMSIZE - 1;
  // memset(state, 0, TABSIZE);
  // misses = 0;
  // for (i = 0; i < length; i++) {
  //   d = (int)data[i];
  //   pc = (d >> 1) & (TABSIZE - 1);
  //   bit = d & 1;
  //   s = (int)state[pc];
  //   misses += bit ^ (((s + s) / FSMSIZE) & 1);
  //   state[pc] = fsm[s + s + bit];
  // }
  // printf("%d\t#sudcnt hits\n", length - misses);
  // printf("%d\t#GAfsm hits\n", besthits);

  // printf("%.3lf%%\t#sudcnt hits\n", 100.0 * (length - misses) / length);
  // printf("%.3lf%%\t#GAfsm hits\n\n", 100.0 * besthits / length);

  // verify result and count transitions
  // for (i = 0; i < FSMSIZE; i++) {
  //   for (j = 0; j < 2; j++) {
  //     trans[i][j] = 0;
  //   }
  // }
  // for (i = 0; i < FSMSIZE * 2; i++) {
  //   fsm[i] = best[i + 3];
  // }
  // memset(state, 0, TABSIZE);
  // misses = 0;
  // for (i = 0; i < length; i++) {
  //   d = (int)data[i];
  //   pc = (d >> 1) & (TABSIZE - 1);
  //   bit = d & 1;
  //   s = (int)state[pc];
  //   trans[s][bit]++;
  //   misses += bit ^ (s & 1);
  //   state[pc] = (unsigned char)fsm[s + s + bit];
  // }

  // bool ok = ((length - misses) == besthits);
  // printf("%s\n", ok ? "PASS" : "FAIL");

#ifdef DEBUG
  // print FSM state assignment in R's ncol format
  for (bit = 0; bit < 2; bit++) {
    for (s = 0; s < FSMSIZE; s++) {
      d = fsm[s + s + bit];
      printf("%c%d %c%d %d\n", (s & 1) ? 'P' : 'N', s / 2, (d & 1) ? 'P' : 'N', d / 2, ((bit * 2) - 1) * trans[s][bit]);
    }
  }
#endif

  free(data);
  HIP_CHECK(hipFree(d_data));
  HIP_CHECK(hipFree(d_best));
  HIP_CHECK(hipFree(d_state));
  HIP_CHECK(hipFree(d_bfsm));
  HIP_CHECK(hipFree(d_same));
  HIP_CHECK(hipFree(d_smax));
  HIP_CHECK(hipFree(d_sbest));
  HIP_CHECK(hipFree(d_oldmax));
  return 0;
}
