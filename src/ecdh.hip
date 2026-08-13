#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <math.h>
#include <hip/hip_runtime.h>
#include <example_utils.hpp>

#define ESS __host__ __device__

/*
  Description: Finds t and s such that a*t + b*s = gcd(a, b)
  Output: return gcd(a, b).
*/
ESS int ext_euclidian_alg(int a, int b, int& x, int& y) {
  x = 1, y = 0;
  int x1 = 0, y1 = 1, a1 = a, b1 = b;
  int s, t;
  while (b1) {
    int q = a1 / b1;
    s = x1;
    t = x - q * x1;
    x = s;
    x1 = t;
    s = y1;
    t = y - q * y1;
    y = s;
    y1 = t;
    s = b1;
    t = a1 - q * b1;
    a1 = s;
    b1 = t;
  }
  return a1;
}

/*
  Input:  integer to make positive mod m (a)
          modulus (m)
  Output: return positive integer congruent to a mod m
*/
ESS unsigned int make_positive(int a, unsigned int m) {
  while (a < 0) {
    a += m;
  }
  return a % m;
}

/*
  Input:  integer to find inverse of (a),
          modulus (m)
  Output: return inverse of a mod m.
*/
ESS int find_inverse(int a, unsigned int m) {
  int t, s;
  ext_euclidian_alg(a, m, t, s);
  return make_positive(t, m);
}

/*
  Input:  modulus (m)
          first point (x1, y1)
          second point (x2, y2)
  Output: sum of the input points (x3, y3)
  note: non-commutative (x1,y1) + (x2,y2) != (x2,y2) + (x1,y1)
*/
ESS void point_addition(unsigned int m, int x1, int y1, int x2, int y2, int *x3, int *y3) {
  int temp = make_positive(x2 - x1, m);
  int slope = make_positive((y2 - y1) * find_inverse(temp, m), m);
  *x3 = make_positive((slope * slope - x1 - x2), m);
  *y3 = make_positive((slope * (x1 - *x3) - y1), m);
}

/*
  Input:  modulus (m)
          point (x1, y1)
  Output: sum of the input point (x3, y3)
*/
ESS void point_doubling(unsigned int m, int a, int x1, int y1, int *x3, int *y3) {
  int slope = (3 * x1 * x1 + a) * find_inverse(2 * y1, m);
  *x3 = make_positive(slope * slope - 2 * x1, m);
  *y3 = make_positive(slope * (x1 - *x3) - y1, m);
}

/*
  Input:  integer to check (n)
  Output: return index of first set bit starting from the left
*/
ESS int first_set_bit(int n) {
  int i;
  for (i = (sizeof(int) * 8) - 1; i >= 0; --i) {
    if (((1 << i) & n))
      return i;
  }
  return 0;
}

/*
  Input:  secret key (sk),
          modulus (m),
          elliptic curve coeff (a),
          primitive (P_x, P_y)
  Output: public key (T_x, T_y)
*/
ESS void make_pk_fast(int sk, int P_x, int P_y, int *T_x, int *T_y, unsigned int m, int a) {
  int i = 0;
  *T_x = P_x;
  *T_y = P_y;

  for (i = first_set_bit(sk) - 1; i >= 0; --i) {
    point_doubling(m, a, *T_x, *T_y, T_x, T_y);

    if ((1 << i) & sk) // if the bit at index 'i' is 1 then point addition
      point_addition(m, *T_x, *T_y, P_x, P_y, T_x, T_y);
  }
}

/*
  Input:  secret key (sk),
          modulus (m),
          elliptic curve coeff (a),
          primitive (P_x, P_y)
  Output: public key (T_x, T_y)
*/
ESS void make_pk_slow(int sk, int P_x, int P_y, int *T_x, int *T_y, unsigned int m, int a) {
  point_doubling(m, a, P_x, P_y, T_x, T_y);

  sk -= 2;

  while (sk > 0) {
    point_addition(m, *T_x, *T_y, P_x, P_y, T_x, T_y);

    --sk;
  }
}

/*
  Input:  secret key (sk),
          other entity public key (T_x, T_y),
          elliptic curve coeff (a),
          modulus (m)
  Output: shared secret key (shared_x, shared_y)
*/
ESS void get_shared_key(int sk, int T_x, int T_y, int *shared_x, int *shared_y, unsigned int m, int a) {
  make_pk_fast(sk, T_x, T_y, shared_x, shared_y, m, a);
}

// __global__ void k_slow (
//   const int sk,
//   const int P_x,
//   const int P_y,
//   int *__restrict__ T_x,
//   int *__restrict__ T_y,
//   const unsigned int m,
//   const int a,
//   const int num_pk)
// {
//   int i = blockIdx.x * blockDim.x + threadIdx.x;
//   if (i < num_pk)
//     make_pk_slow(sk, P_x, P_y, T_x+i, T_y+i, m, a);
// }

__global__ void k_fast(const int sk, const int P_x, const int P_y, int *__restrict__ T_x, int *__restrict__ T_y,
                       const unsigned int m, const int a, const int num_pk) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < num_pk)
    make_pk_fast(sk, P_x, P_y, T_x + i, T_y + i, m, a);
}

#define P_x 5
#define P_y 1
#define MODULUS 17
#define A 2

int main(int argc, char **argv) {
  const int num_pk = 50000000;
  const int repeat = 1;

  // timing fast and slow versions for making public key
  struct timeval start_fast, end_fast;

  const int pk_x_size = num_pk * sizeof(int);
  const int pk_y_size = num_pk * sizeof(int);

  // int *pk_slow_x = (int*) malloc (pk_x_size);
  // int *pk_slow_y = (int*) malloc (pk_y_size);
  int *pk_fast_x = (int *)malloc(pk_x_size);
  int *pk_fast_y = (int *)malloc(pk_y_size);

  int *d_pk_x, *d_pk_y;
  HIP_CHECK(hipMalloc((void **)&d_pk_x, pk_x_size));
  HIP_CHECK(hipMalloc((void **)&d_pk_y, pk_y_size));

  dim3 grids = (num_pk + 255) / 256;

  // gettimeofday(&start_slow,NULL);

  // for (int i = 0; i < repeat; i++)
  //   hipLaunchKernelGGL(k_slow, grids, 256, 0, 0, 18, P_x, P_y, d_pk_x, d_pk_y, MODULUS, A, num_pk);

  // HIP_CHECK(hipDeviceSynchronize());
  // gettimeofday(&end_slow,NULL);
  // double elapsed_slow = (((end_slow.tv_sec*1000000.0 + end_slow.tv_usec) -
  //                       (start_slow.tv_sec*1000000.0 + start_slow.tv_usec)) / 1000000.00);

  // printf("Average time (slow kernel): %f s\n", elapsed_slow / repeat);

  // HIP_CHECK(hipMemcpy(pk_slow_x, d_pk_x, pk_x_size, hipMemcpyDeviceToHost));
  // HIP_CHECK(hipMemcpy(pk_slow_y, d_pk_y, pk_y_size, hipMemcpyDeviceToHost));

  gettimeofday(&start_fast, NULL);

  for (int i = 0; i < repeat; i++)
    hipLaunchKernelGGL(k_fast, grids, 256, 0, 0, 18, P_x, P_y, d_pk_x, d_pk_y, MODULUS, A, num_pk);

  HIP_CHECK(hipDeviceSynchronize());
  gettimeofday(&end_fast, NULL);
  double elapsed_fast =
      (((end_fast.tv_sec * 1000000.0 + end_fast.tv_usec) - (start_fast.tv_sec * 1000000.0 + start_fast.tv_usec)) /
       1000000.00);

  printf("%f ms\n", elapsed_fast * 1000 / repeat);

  HIP_CHECK(hipMemcpy(pk_fast_x, d_pk_x, pk_x_size, hipMemcpyDeviceToHost));
  HIP_CHECK(hipMemcpy(pk_fast_y, d_pk_y, pk_y_size, hipMemcpyDeviceToHost));

  // bool fail_pk_x = memcmp(pk_slow_x, pk_fast_x, pk_x_size);
  // bool fail_pk_y = memcmp(pk_slow_y, pk_fast_y, pk_x_size);
  // printf("%s\n", (fail_pk_x || fail_pk_y) ? "FAIL" : "PASS");

  HIP_CHECK(hipFree(d_pk_x));
  HIP_CHECK(hipFree(d_pk_y));
  // free(pk_slow_x);
  // free(pk_slow_y);
  free(pk_fast_x);
  free(pk_fast_y);
  return 0;
}
