#include "hip/hip_runtime.h"
#define WARP_BITS 5
#define WARP_SIZE 32

// jds_ptr_int - pointer offset into the `data` output, referenced by the current row loop index
// sh_zcnt_int - number of non-zero entries in each row
// d_perm data_row_map - JDS row to real row

__global__ void spmv_jds(float *dst_vector,
						const float *d_data,const int *d_index, const int *d_perm,
						const float *x_vec,const int *d_nzcnt,const int dim)
{
	int ix=blockIdx.x*blockDim.x+threadIdx.x;
	int warp_id=ix>>WARP_BITS;
	// printf("ix:%d, warp_id:%d\n", ix, warp_id);
	// 确实是按行进行算的，data的排列是列优先，data的排列是按照：第ix行，其第k个非零元素为：jds_ptr_int[k]+ix
	if(ix<dim)
	{
		float sum=0.0f;
		int	bound=sh_zcnt_int[warp_id];
		//prefetch 0
		int j=jds_ptr_int[0]+ix;  
		float d = d_data[j]; 
		int i = d_index[j];  
		float t = x_vec[i];
		// printf("\n j:%d, i:%d \n", (j,i));

		if (bound>1)  //bound >=2
		{
			//prefetch 1
			j=jds_ptr_int[1]+ix;    
			i =  d_index[j];  // %38
			int in;
			float dn;
			float tn;
			// printf("\n j:%d, i:%d \n", (j,i));

			for(int k=2;k<bound;k++ )
			{	
				//prefetch k-1
				dn = d_data[j]; // %74
				//prefetch k
				j=jds_ptr_int[k]+ix;    
				in = d_index[j]; // %61
				//prefetch k-1
				tn = x_vec[i]; // %66
				// tn = dn;
				// printf("\n j:%d, i:%d \n", (j,i));
				//compute k-2
				sum += d*t; 
				// sum += d+t; 
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
			// sum += d+t; 
			//sweep to last
			d=dn;
			t=tn;
		}
		//compute last
		sum += d*t;  // 3 3
		// sum += d+t;
		
		//write out data
		dst_vector[d_perm[ix]]=sum; 
	}

}

// smallest kernel  通过数据集应该可以再调高
// spmv change smallest kernel, store bypass, 13%, -----------------------
// 0,jds_bfs_bypass,5.4078
// 1,jds_bfs_cache,6.232799999999999
// spmv change smallest kernel, store cache, 7%, -----------------------
// 0,jds_bfs_bypass,5.7682
// 1,jds_bfs_cache,6.212999999999999

// {
// 	int ix=blockIdx.x*blockDim.x+threadIdx.x;
// 	int warp_id=ix>>WARP_BITS;
// 	// printf("ix:%d, warp_id:%d\n", ix, warp_id);
// 	// 确实是按行进行算的，data的排列是列优先，data的排列是按照：第ix行，其第k个非零元素为：jds_ptr_int[k]+ix
// 	if(ix<dim)
// 	{
// 		// g_graph_mask[ix]=false; 

// 		float sum=0.0f;
// 		int	bound=sh_zcnt_int[warp_id];
		
// 		for (int k=0; k<bound; k++)
// 		{
// 			int j=jds_ptr_int[k]+ix;  
// 			float d = d_data[j]; 
// 			int i = d_index[j];  
// 			float t = x_vec[i]; 
// 			sum += d*t;
// 		}
// 		dst_vector[d_perm[ix]]=sum; 
// 	}

// }
