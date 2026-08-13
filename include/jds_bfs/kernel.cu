/*********************************************************************************
Implementing Breadth first search on CUDA using algorithm given in HiPC'07
  paper "Accelerating Large Graph Algorithms on the GPU using CUDA"

Copyright (c) 2008 International Institute of Information Technology - Hyderabad. 
All rights reserved.
  
Permission to use, copy, modify and distribute this software and its documentation for 
educational purpose is hereby granted without fee, provided that the above copyright 
notice and this permission notice appear in all copies of this software and that you do 
not sell the software.
  
THE SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTY OF ANY KIND,EXPRESS, IMPLIED OR 
OTHERWISE.

The CUDA Kernel for Applying BFS on a loaded Graph. Created By Pawan Harish
**********************************************************************************/
// #ifndef _KERNEL_H_
// #define _KERNEL_H_

// __global__ void
// Kernel( Node* g_graph_nodes, int* g_graph_edges, bool* g_graph_mask, bool* g_updating_graph_mask, bool *g_graph_visited, int* g_cost, int no_of_nodes) 
// {
// 	int tid = blockIdx.x*MAX_THREADS_PER_BLOCK + threadIdx.x;
// 	if( tid<no_of_nodes && g_graph_mask[tid])
// 	{
// 		g_graph_mask[tid]=false;
// 		for(int i=g_graph_nodes[tid].starting; i<(g_graph_nodes[tid].no_of_edges + g_graph_nodes[tid].starting); i++)
// 			{
// 			int id = g_graph_edges[i];
// 			if(!g_graph_visited[id])
// 				{
// 				g_cost[id]=g_cost[tid]+1;
// 				g_updating_graph_mask[id]=true;
// 				}
// 			}
// 	}
// }

// #endif 

// #ifndef _KERNEL_H_
// #define _KERNEL_H_
#define WARP_BITS 5
#define WARP_SIZE 32

//constant memory
__constant__ int jds_ptr_int[500000];
__constant__ int sh_zcnt_int[500000];

__global__ void Kernel(float *dst_vector,
						const float *d_data,const int *d_index, const int *d_perm,
						float *x_vec,const int *d_nzcnt,const int dim,
						bool* g_graph_mask, bool* g_updating_graph_mask, bool *g_graph_visited)

// {
// 	int tid = blockIdx.x*blockDim.x + threadIdx.x;
// 	int d_perm_tid = d_perm[tid];
// 	int warp_id = tid >> WARP_BITS;
// 	// if( tid < dim && g_graph_mask[tid])
// 	if( tid < dim )
// 	{
// 		// g_graph_mask[tid]=false; 
// 		// for(int i=g_graph_nodes[tid].starting; i<(g_graph_nodes[tid].no_of_edges + g_graph_nodes[tid].starting); i++)
// 		// 	{
// 		// 	int id = g_graph_edges[i];
// 		// 	if(!g_graph_visited[id])
// 		// 		{
// 		// 		g_cost[id]=g_cost[tid]+1;
// 		// 		g_updating_graph_mask[id]=true;
// 		// 		}
// 		// 	}
// 		float sum=0.0f;
// 		// 第tid行
// 		int	bound = sh_zcnt_int[warp_id]; // bound >= 每行非零元素，大于则多的索引到的data则为0
		
// 		// prefetch 0
// 		int j=jds_ptr_int[0]+tid; // 第ix行第0个非零元素的索引
// 		float d = d_data[j]; // 边的权重，不过bfs里面都一样的值
// 		int i = d_index[j]; // 对应的真实列索引，即边的另一个节点
// 		float t = x_vec[i];
// 		int ii = i;
// 		if (bound>1)
// 		{
// 			//prefetch 1
// 			j = jds_ptr_int[1]+tid;    
// 			i =  d_index[j];  
// 			int in;
// 			float dn;
// 			float tn;
// 			float iin;

// 			for(int k=2; k<bound; k++)
// 			{
// 				//prefetch k-1
// 				dn = d_data[j]; 
// 				//prefetch k
// 				j=jds_ptr_int[k]+tid;    
// 				in = d_index[j]; 
// 				iin = in;
// 				//prefetch k-1
// 				tn = x_vec[i];
// 				//compute k-2: d i 
// 				// if(!g_graph_visited[ii] && !(t>0))
// 				// if(!(t>0))
// 				// {
// 					// g_cost[ii]=g_cost[d_perm_tid]+d;
// 					// g_cost[ii]=t+d;
// 				sum = t+d+ii;
// 					// g_updating_graph_mask[ii]=true;
// 				// }
// 				//sweep to k
// 				i = in;  
// 				ii = iin;
// 				//sweep to k-1
// 				d = dn;
// 				t = tn;
// 			}

// 			//fetch last
// 			dn = d_data[j];
// 			tn = x_vec[i];
// 			iin = ii;

// 			//compute last-1
// 			// sum += d*t; 
// 			// if(!g_graph_visited[ii] && !(t>0))
// 			// if(!(t>0))
// 			// {
// 				// g_cost[ii]=g_cost[d_perm_tid]+d;
// 				// g_cost[ii]=t+d;
// 			sum = t+d+ii;
// 				// g_updating_graph_mask[ii]=true;
// 			// }
// 			//sweep to last
// 			d=dn;
// 			t=tn;
// 			ii=iin;
// 		}
// 		//compute last
// 		// if(!g_graph_visited[ii] && !(t>0))
// 		// if(!(t>0))
// 		// {
// 			// g_cost[ii]=g_cost[d_perm_tid]+d;
// 			// g_cost[ii]=t+d;
// 		sum = t+d+ii;
// 			// g_updating_graph_mask[ii]=true;
// 		// }
// 		dst_vector[d_perm_tid]=sum;
// 	}
// }

// #endif 
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
// 		//prefetch 0
// 		int j=jds_ptr_int[0]+ix;  
// 		float d = d_data[j]; 
// 		int i = d_index[j];  
// 		float t = x_vec[i]; //g_cost
// 		// g_updating_graph_mask[i]=true;
// 		int ii = i;
// 		// printf("\n j:%d, i:%d \n", (j,i));

// 		if (bound>1)  //bound >=2
// 		{
// 			//prefetch 1
// 			j=jds_ptr_int[1]+ix;    
// 			i =  d_index[j];  
// 			int in;
// 			float dn;
// 			float tn;
// 			int iin;
// 			// printf("\n j:%d, i:%d \n", (j,i));

// 			for(int k=2;k<bound;k++ )
// 			{	
// 				//prefetch k-1
// 				// g_updating_graph_mask[i]=true;
// 				dn = d_data[j]; 
// 				//prefetch k
// 				j=jds_ptr_int[k]+ix;    
// 				in = d_index[j]; 
// 				iin = in;
// 				//prefetch k-1
// 				tn = x_vec[i];
// 				// tn = dn;
// 				// printf("\n j:%d, i:%d \n", (j,i));
// 				//compute k-2
// 				// sum += d*t; 
// 				sum += t+d+ii; // 这里不能有一点store数组，否则bypass就无效了，没有研究过g_updating_graph_mask的store bypass
// 				// g_updating_graph_mask[ii]=true;
// 				// dst_vector[ii] = t+d;
// 				// sum += d+t; 
// 				//sweep to k
// 				i = in;  
// 				ii = iin;
// 				//sweep to k-1
// 				d = dn;
// 				t =tn; 
// 			}	
		
// 			//fetch last
// 			// g_updating_graph_mask[i]=true;
// 			dn = d_data[j];
// 			tn = x_vec[i];
// 			iin = ii;
// 			//compute last-1
// 			// sum += d*t; 
// 			sum += t+d+ii;
// 			// g_updating_graph_mask[ii]=true;
// 			// dst_vector[ii] = t+d;
// 			// sum += d+t; 
// 			//sweep to last
// 			d=dn;
// 			t=tn;
// 			ii=iin;
// 		}
// 		//compute last
// 		// sum += d*t;  // 3 3
// 		sum += t+d+ii;
// 		// g_updating_graph_mask[ii]=true;
// 		// dst_vector[ii] = t+d;
// 		// sum += d+t;
		
// 		//write out data
// 		dst_vector[d_perm[ix]]=sum; 
// 	}

// }


{
	int ix=blockIdx.x*blockDim.x+threadIdx.x;
	int warp_id=ix>>WARP_BITS;
	// int d_perm_id = d_perm[ix];
	bool mask = g_graph_mask[ix];
	g_graph_mask[ix] = false;
	// printf("ix:%d, warp_id:%d\n", ix, warp_id);
	// 确实是按行进行算的，data的排列是列优先，data的排列是按照：第ix行，其第k个非零元素为：jds_ptr_int[k]+ix
	if(ix<dim)
	{
		// g_graph_mask[ix]=false;
		// printf("ix: %d\n", ix);

		float sum=0.0f;
		int	bound=sh_zcnt_int[warp_id];
		
		for (int k=0; k<bound; k++)
		{
			int j=jds_ptr_int[k]+ix; 
			float d = d_data[j]; 
			int i = d_index[j];  
			float t = x_vec[i]; 
			// sum += d*t;
			// x_vec[i] = t + d;
			if (mask)
			{
				x_vec[i]=d+t;
				g_graph_mask[i] = true;
			// 	g_graph_mask[i] = true;
			}
			// 存放在(ix, i) 
			// dst_vector[d_perm_id*dim + i]= d + t;
		}
		// dst_vector[ix]=sum; 
		// g_graph_mask[ix]=false;
	}

}