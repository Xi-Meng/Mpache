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
#ifndef _KERNEL2_H_
#define _KERNEL2_H_

__global__ void
Kernel2( bool* g_graph_mask, bool *g_updating_graph_mask, bool* g_graph_visited, bool *g_over, int no_of_nodes)
{
	int tid = blockIdx.x*blockDim.x + threadIdx.x;
	if( tid<no_of_nodes && g_updating_graph_mask[tid])
	{

		g_graph_mask[tid]=true;
		g_graph_visited[tid]=true;
		*g_over=true;
		g_updating_graph_mask[tid]=false;
	}
}

#endif

// __global__ void Kernel(float *dst_vector,
// 						const float *d_data,const int *d_index, const int *d_perm,
// 						const float *x_vec,const int *d_nzcnt,const int dim,
// 						bool* g_graph_mask, bool* g_updating_graph_mask, bool *g_graph_visited)

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