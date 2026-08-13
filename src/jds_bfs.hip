/***********************************************************************************
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

  Created by Pawan Harish.
 ************************************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <chrono>
#include <hip/hip_runtime.h>
#include "../include/jds_bfs/convert_dataset.h"
#include "../include/jds_bfs/gpu_info.h"
#include "../include/jds_bfs/kernel.cu"
#include "../include/jds_bfs/kernel2.cu"

// #define MAX_THREADS_PER_BLOCK 512

// __constant__ int jds_ptr_int[500000];
// __constant__ int sh_zcnt_int[500000];

// int edge_list_size;
// FILE *fp;

//Structure to hold a node information
// struct Node
// {
// 	int starting;
// 	int no_of_edges;
// };



void BFSGraph(int argc, char** argv);

////////////////////////////////////////////////////////////////////////////////
// Main Program
////////////////////////////////////////////////////////////////////////////////
int main( int argc, char** argv) 
{
	//parameters declaration
	int len;
	int depth;
	int dim;
	int pad=32;
	int nzcnt_len;
	
	//host memory allocation
	//matrix
	float *h_data;
	int *h_indices;
	int *h_ptr;
	int *h_perm;
	int *h_nzcnt;
	//vector
	float *h_Ax_vector;
    float *h_x_vector;
	
	//device memory allocation
	//matrix
	float *d_data;
	int *d_indices;
	int *d_ptr;
	int *d_perm;
	int *d_nzcnt;
	//vector
	float *d_Ax_vector;
    float *d_x_vector;

	int col_count;
	coo_to_jds(
		// parameters->inpFiles[0], // bcsstk32.mtx, fidapm05.mtx, jgl009.mtx
		"/workspace/Inst-level-cache-management/include/jds_bfs/data/demo_matrix.mtx",
		1, // row padding
		pad, // warp size, IMPORTANT: change in kernel as well
		1, // pack size
		1, // is mirrored?
		0, // binary matrix
		1, // debug level [0:2]
		&h_data, &h_ptr, &h_nzcnt, &h_indices, &h_perm,
		&col_count, &dim, &len, &nzcnt_len, &depth
	);
	// dim*dim cost
	h_x_vector=(float*)malloc(sizeof(float)*dim);
	for (int i=0; i<dim; i++)
		h_x_vector[i] = 0;

	//memory allocation
	hipMalloc((void **)&d_data, len*sizeof(float));
	hipMalloc((void **)&d_indices, len*sizeof(int));
	hipMalloc((void **)&d_ptr, depth*sizeof(int));
	hipMalloc((void **)&d_perm, dim*sizeof(int));
	hipMalloc((void **)&d_nzcnt, nzcnt_len*sizeof(int));
	hipMalloc((void **)&d_x_vector, dim*sizeof(float)); 
	// hipMalloc((void **)&d_Ax_vector,dim*dim*sizeof(float)); // dim * dim mark
	hipMalloc((void **)&d_Ax_vector,dim*sizeof(float));
	// hipMemset( (void *) d_Ax_vector, 0, dim*dim*sizeof(float));
	hipMemset( (void *) d_Ax_vector, 0, dim*sizeof(float));
	
	//memory copy
	hipMemcpy(d_data, h_data, len*sizeof(float), hipMemcpyHostToDevice);
	hipMemcpy(d_indices, h_indices, len*sizeof(int), hipMemcpyHostToDevice);
	hipMemcpy(d_perm, h_perm, dim*sizeof(int), hipMemcpyHostToDevice);
	hipMemcpy(d_x_vector, h_x_vector, dim*sizeof(int), hipMemcpyHostToDevice); // int ? 否则会卡？
	hipMemcpyToSymbol(HIP_SYMBOL(jds_ptr_int), h_ptr, depth*sizeof(int));
	hipMemcpyToSymbol(HIP_SYMBOL(sh_zcnt_int), h_nzcnt,nzcnt_len*sizeof(int));
	
	hipDeviceProp_t deviceProp;
    hipGetDeviceProperties(&deviceProp, 0);
	unsigned int grid;
	unsigned int block;
    compute_active_thread(&block, &grid, nzcnt_len, pad, deviceProp.major,deviceProp.minor,
					deviceProp.warpSize, deviceProp.multiProcessorCount);
	printf("grid: %d, block:%d \n", grid, block);


	int no_of_nodes = dim;


	// allocate host memory
	bool *h_graph_mask = (bool*) malloc(sizeof(bool)*no_of_nodes);
	bool *h_updating_graph_mask = (bool*) malloc(sizeof(bool)*no_of_nodes);
	bool *h_graph_visited = (bool*) malloc(sizeof(bool)*no_of_nodes);

	// int start, edgeno;   
	// // initalize the memory
	// for( unsigned int i = 0; i < no_of_nodes; i++) 
	// {
	// 	fscanf(fp,"%d %d",&start,&edgeno);
	// 	h_graph_nodes[i].starting = start;
	// 	h_graph_nodes[i].no_of_edges = edgeno;
	// 	h_graph_mask[i]=false;
	// 	h_updating_graph_mask[i]=false;
	// 	h_graph_visited[i]=false;
	// }

	// //read the source node from the file
	// fscanf(fp,"%d",&source);
	int source=0;

	// //set the source node as true in the mask
	h_graph_mask[source]=true;
	h_graph_visited[source]=true;

	//Copy the Mask to device memory
	bool* d_graph_mask;
	hipMalloc( (void**) &d_graph_mask, sizeof(bool)*no_of_nodes) ;
	hipMemcpy( d_graph_mask, h_graph_mask, sizeof(bool)*no_of_nodes, hipMemcpyHostToDevice) ;

	bool* d_updating_graph_mask;
	hipMalloc( (void**) &d_updating_graph_mask, sizeof(bool)*no_of_nodes) ;
	hipMemcpy( d_updating_graph_mask, h_updating_graph_mask, sizeof(bool)*no_of_nodes, hipMemcpyHostToDevice) ;

	//Copy the Visited nodes array to device memory
	bool* d_graph_visited;
	hipMalloc( (void**) &d_graph_visited, sizeof(bool)*no_of_nodes) ;
	hipMemcpy( d_graph_visited, h_graph_visited, sizeof(bool)*no_of_nodes, hipMemcpyHostToDevice) ;

	// allocate mem for the result on host side
	// int* h_cost = (int*) malloc( sizeof(int)*no_of_nodes);
	// for(int i=0;i<no_of_nodes;i++)
	// 	h_cost[i]=-1;
	// h_cost[source]=0;
    // d_Ax_vector[source]=0;
	

	//make a bool to check if the execution is over
	bool *d_over;
	hipMalloc( (void**) &d_over, sizeof(bool));



	// int k=0;
    int k=dim;
	// int k=200;
	printf("Start traversing the tree\n");
	bool stop;

	hipEvent_t start, end;
	hipEventCreate(&start);
	hipEventCreate(&end);
	float eventMs =1.0f;
	hipEventRecord(start, NULL);
    printf("k: %d\n", k);
	//Call the Kernel untill all the elements of Frontier are not false
	do
	{
		//if no thread changes this value then the loop stops
		// stop=false;
		// hipMemcpy( d_over, &stop, sizeof(bool), hipMemcpyHostToDevice) ;
		

		// Kernel<<< grid, threads, 0 >>>( d_graph_nodes, d_graph_edges, d_graph_mask, d_updating_graph_mask, d_graph_visited, d_cost, no_of_nodes);
		// check if kernel execution generated and error
		Kernel<<<grid, block>>>(d_Ax_vector,d_data,d_indices,d_perm,d_x_vector,d_nzcnt,dim,
								  d_graph_mask, d_updating_graph_mask, d_graph_visited);


		// Kernel2<<<grid, block>>>( d_graph_mask, d_updating_graph_mask, d_graph_visited, d_over, no_of_nodes);
		// check if kernel execution generated and error
		

		// hipMemcpy( &stop, d_over, sizeof(bool), hipMemcpyDeviceToHost) ;
		// k++;
	}
	while(k--);

	hipEventRecord(end, NULL);
	hipEventSynchronize(end);
	hipEventElapsedTime(&eventMs, start, end);
    // printf("k: %d\n", k);
	printf("kernel time (hipEventElapsedTime)=%6.3fms\n", eventMs);
	printf("%6.3f ms\n", eventMs);

	// // copy result from device to host
	// hipMemcpy( h_cost, d_cost, sizeof(int)*no_of_nodes, hipMemcpyDeviceToHost) ;

	// //Store the result into a file
	// FILE *fpo = fopen("result.txt","w");
	// for(int i=0;i<no_of_nodes;i++)
	// 	fprintf(fpo,"%d) cost:%d\n",i,h_cost[i]);
	// fclose(fpo);
	// // printf("Result stored in result.txt\n");


	// cleanup memory
	// free( h_graph_nodes);
	// free( h_graph_edges);
	free( h_graph_mask);
	free( h_updating_graph_mask);
	free( h_graph_visited);
	// free( h_cost);
	// hipFree(d_graph_nodes);
	// hipFree(d_graph_edges);
	hipFree(d_graph_mask);
	hipFree(d_updating_graph_mask);
	hipFree(d_graph_visited);
	// hipFree(d_cost);
	
	hipFree(d_data);
    hipFree(d_indices);
    hipFree(d_ptr);
	hipFree(d_perm);
    hipFree(d_nzcnt);
    hipFree(d_x_vector);
	hipFree(d_Ax_vector);
	free (h_data);
	free (h_indices);
	free (h_ptr);
	free (h_perm);
	free (h_nzcnt);
	free (h_Ax_vector);
	free (h_x_vector);
}
