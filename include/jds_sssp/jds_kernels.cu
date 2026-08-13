#include "hip/hip_runtime.h"
#define WARP_BITS 5
#define WARP_SIZE 32

// jds_ptr_int - pointer offset into the `data` output, referenced by the current row loop index
// sh_zcnt_int - number of non-zero entries in each row
// d_perm data_row_map - JDS row to real row

__global__ void sssp_jds(float *dst_vector,
						const float *d_data,const int *d_index, const int *d_perm,
						float *x_vec,const int *d_nzcnt,const int dim)

// smallest kernel
// spmv change smallest kernel, store bypass, 13%, -----------------------
// 0,jds_bfs_bypass,5.4078
// 1,jds_bfs_cache,6.232799999999999
// spmv change smallest kernel, store cache, 7%, -----------------------
// 0,jds_bfs_bypass,5.7682
// 1,jds_bfs_cache,6.212999999999999

{
	int ix=blockIdx.x*blockDim.x+threadIdx.x;
	int warp_id=ix>>WARP_BITS;
	int d_perm_id = d_perm[ix];
	// printf("ix:%d, warp_id:%d\n", ix, warp_id);
	// 确实是按行进行算的，data的排列是列优先，data的排列是按照：第ix行，其第k个非零元素为：jds_ptr_int[k]+ix
	if(ix<dim)
	{
		
		float min = x_vec[d_perm_id];
		int	bound=sh_zcnt_int[warp_id];
		
		for (int k=0; k<bound; k++)
		{
			int j=jds_ptr_int[k]+ix;  
			float d = d_data[j]; 
			int i = d_index[j];  
			float t = x_vec[i]; 
			// sum += d*t;
			// x_vec[i] = 
			if (min > d + t ) min = d+t;

		}
		x_vec[d_perm_id] = min; 
	}

}
