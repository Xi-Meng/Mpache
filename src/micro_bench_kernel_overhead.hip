#include <hip/hip_runtime.h>
#include <example_utils.hpp>
#include <bits/stdc++.h>

using namespace std;

__global__ void kernel() {
}

int main(int argc,char *argv[]) {
  int iterations = 150000;
  if(argc>1){
    iterations = std::atoi(argv[1]);
  }
  auto start = std::chrono::steady_clock::now();
  for (int i = 0; i < iterations; i++) {
    kernel<<<1, 1>>>();
  }
  auto end = std::chrono::steady_clock::now();
  auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
  std::cout << "total: " << time * 1e-6f << " ms\n";
  std::cout << "average: " << time / iterations * 1e-6f << " ms\n";
}
