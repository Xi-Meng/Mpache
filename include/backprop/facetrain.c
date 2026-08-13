

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "backprop.h"
#include "omp.h"

extern char *strcpy();
extern void exit();

int layer_size = 0;

backprop_face()
{
  BPNN *net;
  int i;
  float out_err, hid_err;
  net = bpnn_create(layer_size, 16, 1); // (16, 1 can not be changed)
  
  printf("Input layer size : %d\n", layer_size);
  load(net);
  //entering the training kernel, only one iteration
  printf("Starting training kernel\n");
  bpnn_train_cuda(net, &out_err, &hid_err);
  bpnn_free(net);
  // printf("Training done\n");
}

int setup(argc, argv)
int argc;
char *argv[];
{
	
  int seed;

  // if (argc!=2){
  // fprintf(stderr, "usage: backprop <num of input elements>\n");
  // exit(0);
  // }
  // layer_size = atoi(argv[1]);
  // layer_size = 97536;
  // layer_size = 16777216;
  FILE *fp;

  // 打开文件
  fp = fopen("/workspace/Inst-level-cache-management/include/backprop/input.txt", "r");
  if (fp == NULL) {
      fprintf(stderr, "Could not open input.txt\n");
      exit(0);
  }

  // 从文件中读取layer_size值
  if (fscanf(fp, "%d", &layer_size) != 1) {
      fprintf(stderr, "Could not read layer_size from input.txt\n");
      exit(0);
  }
  
  // 关闭文件
  fclose(fp);
  
  if (layer_size%16!=0){
  fprintf(stderr, "The number of input points must be divided by 16\n");
  exit(0);
  }
  

  seed = 7;   
  bpnn_initialize(seed);
  backprop_face();

  exit(0);
}
