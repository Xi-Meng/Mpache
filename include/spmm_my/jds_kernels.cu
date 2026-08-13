#include "hip/hip_runtime.h"
#define WARP_BITS 5
#define WARP_SIZE 32


__global__ void spmm_jds(float *dst_matrix,
						const float *d_data,const int *d_index, const int *d_perm,
						const float *x_mat,const int *d_nzcnt,const int dim, const int mat_col)
{
	int ix=blockIdx.x*blockDim.x+threadIdx.x;
	int warp_id=ix>>WARP_BITS;
	if(ix<dim)
	{
		for(int c=0; c < mat_col; c++){
			float sum=0.0f;
			int	bound=sh_zcnt_int[warp_id];
			//prefetch 0
			int j=jds_ptr_int[0]+ix;  
			float d = d_data[j]; 
			int i = d_index[j];  
			float t = x_mat[c * dim + i]; // (i, c): x_mat矩阵是列优先排列
			// printf("\n j:%d, i:%d \n", (j,i));

			if (bound>1)  //bound >=2
			{
				//prefetch 1
				j=jds_ptr_int[1]+ix;    
				i =  d_index[j];  
				int in;
				float dn;
				float tn;
				// printf("\n j:%d, i:%d \n", (j,i));

				for(int k=2;k<bound;k++ )
				{	
					//prefetch k-1
					dn = d_data[j]; 
					//prefetch k
					j=jds_ptr_int[k]+ix;    
					in = d_index[j]; 
					//prefetch k-1
					tn = x_mat[c * dim + i];
					// printf("\n j:%d, i:%d \n", (j,i));
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
				tn = x_mat[c * dim + i];
		
				//compute last-1
				sum += d*t; 
				//sweep to last
				d=dn;
				t=tn;
			}
			//compute last
			sum += d*t;  // 3 3
			
			//write out data
			// 对应的行列为 (ix, c）：列优先排列
			dst_matrix[d_perm[ix] + c * dim]=sum; 
		}
	}

}

