/*$Id: MarsInc.h 755 2009-11-18 13:22:54Z wenbinor $*/
/**
 *This is the source code for Mars, a MapReduce framework on graphics
 *processors.
 *Developers: Wenbin Fang (HKUST), Bingsheng He (Microsoft Research Asia)
 *Naga K. Govindaraju (Microsoft Corp.), Qiong Luo (HKUST), Tuyong Wang (Sina.com).
 *If you have any question on the code, please contact us at 
 *           wenbin@cse.ust.hk or savenhe@microsoft.com
 *
 *The license is a free non-exclusive, non-transferable license to reproduce, 
 *use, modify and display the source code version of the Software, with or 
 *without modifications solely for non-commercial research, educational or 
 *evaluation purposes. The license does not entitle Licensee to technical support, 
 *telephone assistance, enhancements or updates to the Software. All rights, title 
 *to and ownership interest in Mars, including all intellectual property rights 
 *therein shall remain in HKUST.
 */

#ifndef __SYSDEP_H__
#define __SYSDEP_H__

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <pthread.h>
#include <sys/stat.h>
#include <fcntl.h>
// #include <cutil.h>
#include <hip/hip_runtime.h>
#include <string.h>
#include <assert.h>
#include <sys/time.h>
#include <time.h>
#include <stdarg.h>

#include <mm/MarsLib.hip>


#define CEIL(n,m) (n/m + (int)(n%m !=0))
#define THREAD_CONF(grid, block, gridBound, blockBound) do {\
	    block.x = blockBound;\
	    grid.x = gridBound; \
		if (grid.x > 65535) {\
		   grid.x = (int)sqrt((double)grid.x);\
		   grid.y = CEIL(gridBound, grid.x); \
		}\
	}while (0)

#define BLOCK_ID (gridDim.y * blockIdx.x + blockIdx.y)
#define THREAD_ID (threadIdx.x)
#define TID (BLOCK_ID * blockDim.x + THREAD_ID)

//------------------------------------------------------
//MarsScan.cu
//------------------------------------------------------
extern "C"
void prescanArray(int *outArray, int *inArray, int numElements);

extern "C"
int prefexSum( int* d_inArr, int* d_outArr, int numRecords );

//------------------------------------------------------
//MarsSort.cu
//------------------------------------------------------
typedef int4 cmp_type_t;
extern "C"
int sort_GPU (void * d_inputKeyArray, 
              int totalKeySize, 
              void * d_inputValArray, 
              int totalValueSize, 
              cmp_type_t * d_inputPointerArray, 
              int rLen, 
              void * d_outputKeyArray, 
              void * d_outputValArray, 
              cmp_type_t * d_outputPointerArray,
              int2 ** h_outputKeyListRange);

extern "C"
void saven_initialPrefixSum(unsigned int maxNumElements);

//-------------------------------------------------------
//MarsLib.cu
//-------------------------------------------------------

#define DEFAULT_DIMBLOCK	256
#define DEFAULT_NUMTASK		1

#define MAP_ONLY		0x01
#define MAP_GROUP		0x02
#define MAP_REDUCE		0x03


typedef struct
{
	//for input data on host
	char*		inputKeys;
	char*		inputVals;
	int4*		inputOffsetSizes;
	int		inputRecordCount;

	//for intermediate data on host
	char*		interKeys;
	char*		interVals;
	int4*		interOffsetSizes;
	int2*		interKeyListRange;
	int		interRecordCount;
	int		interDiffKeyCount;
	int		interAllKeySize;
	int		interAllValSize;

	//for output data on host
	char*		outputKeys;
	char*		outputVals;
	int4*		outputOffsetSizes;
	int2*		outputKeyListRange;
	int		outputRecordCount;
	int		outputAllKeySize;
	int		outputAllValSize;
	int		outputDiffKeyCount;

	//user specification
	char		workflow;
	char		outputToHost;

	int		numRecTaskMap;
	int		numRecTaskReduce;
	int		dimBlockMap;
	int		dimBlockReduce;
} Spec_t;

__device__ void EmitInterCount(int	keySize,
                               int	valSize,
                               int*	interKeysSizePerTask,
                               int*	interValsSizePerTask,
                               int*	interCountPerTask);



__device__ void EmitIntermediate(void*		key, 
				 void*		val, 
				 int		keySize, 
				 int		valSize,
				 int*	psKeySizes,
				 int*	psValSizes,
				 int*	psCounts,
				 int2*		keyValOffsets,
				 char*		interKeys,
				 char*		interVals,
				 int4*		interOffsetSizes,
				 int*	curIndex);


__device__ void EmitCount(int		keySize,
			  int		valSize,
			  int*		outputKeysSizePerTask,
			  int*		outputValsSizePerTask,
			  int*		outputCountPerTask);

__device__ void Emit  (char*		key, 
                       char*		val, 
		       int		keySize, 
                       int		valSize,
		       int*		psKeySizes, 
		       int*		psValSizes, 
		       int*		psCounts, 
		       int2*		keyValOffsets, 
		       char*		outputKeys,
	               char*		outputVals,
	               int4*		outputOffsetSizes,
	               int*		curIndex);

__device__ void *GetVal(void *vals, int4* interOffsetSizes, int index, int valStartIndex);
__device__ void *GetKey(void *key, int4* interOffsetSizes, int index, int valStartIndex);

#define MAP_COUNT_FUNC \
	map_count(void*		key,\
		  void*		val,\
		  int	keySize,\
		  int	valSize,\
		  int*	interKeysSizePerTask,\
		  int*	interValsSizePerTask,\
		  int*	interCountPerTask)

#define EMIT_INTER_COUNT_FUNC(keySize, valSize)\
		EmitInterCount(keySize, valSize, \
		interKeysSizePerTask, interValsSizePerTask, interCountPerTask)



#define MAP_FUNC \
	 map	(void*		key, \
		 void*		val, \
		 int		keySize, \
		 int		valSize,\
		 int*	psKeySizes, \
		 int*	psValSizes, \
		 int*	psCounts, \
		 int2*		keyValOffsets, \
		 char*		interKeys,\
		 char*		interVals,\
		 int4*		interOffsetSizes,\
		 int*	curIndex)


#define EMIT_INTERMEDIATE_FUNC(newKey, newVal, newKeySize, newValSize) \
	EmitIntermediate((char*)newKey,\
	             (char*)newVal,\
			 newKeySize,\
			 newValSize,\
			 psKeySizes,\
			 psValSizes,\
			 psCounts,\
			 keyValOffsets,\
			 interKeys,\
			 interVals,\
			 interOffsetSizes,\
			 curIndex)


#define REDUCE_COUNT_FUNC \
	reduce_count(void		*key,\
	         void		*vals,\
		 int		keySize,\
		 int		valCount,\
		 int4*		interOffsetSizes,\
		 int*	outputKeysSizePerTask,\
		 int*	outputValsSizePerTask,\
		 int*	outputCountPerTask)

#define EMIT_COUNT_FUNC(newKeySize, newValSize) \
	EmitCount(newKeySize,\
			  newValSize,\
			  outputKeysSizePerTask,\
			  outputValsSizePerTask,\
			  outputCountPerTask)

#define REDUCE_FUNC \
	reduce(void*	 key, \
		   void*	 vals, \
		   int	 keySize, \
		   int	 valCount, \
		   int*	 psKeySizes,\
		   int*	 psValSizes, \
		   int*	 psCounts, \
		   int2*	 keyValOffsets,\
		   int4*	 interOffsetSizes,\
		   char*	 outputKeys, \
		   char*	 outputVals,\
		   int4*	 outputOffsetSizes, \
		   int* curIndex,\
			int valStartIndex)

#define EMIT_FUNC(newKey, newVal, newKeySize, newValSize) \
	Emit((char*)newKey,\
	     (char*)newVal,\
		 newKeySize,\
		 newValSize,\
		 psKeySizes,\
		 psValSizes,\
		 psCounts, \
		 keyValOffsets, \
		 outputKeys,\
		 outputVals,\
		 outputOffsetSizes,\
		 curIndex)

HIP_DYNAMIC_SHARED( char, sbuf)
#define GET_OUTPUT_BUF(offset) (sbuf + threadIdx.x * 5 * sizeof(int) + offset)
#define GET_VAL_FUNC(vals, index) GetVal(vals, interOffsetSizes, index, valStartIndex)
#define GET_KEY_FUNC(key, index) GetKey(key, interOffsetSizes, index, valStartIndex)

extern "C"
// Spec_t *GetDefaultSpec();
Spec_t *GetDefaultSpec()
{
	Spec_t *spec = (Spec_t*)malloc(sizeof(Spec_t));
	if (NULL == spec) exit(-1);
	memset(spec, 0, sizeof(Spec_t));

	return spec;
}

extern "C"
void AddMapInputRecord(Spec_t*		spec, 
		   void*		key, 
		   void*		val, 
		   int		keySize, 
		   int		valSize);

extern "C"
// void MapReduce(Spec_t *spec);
void MapReduce(Spec_t *spec)
{
	assert(NULL != spec);
	Spec_t* g_spec = spec;

	DoLog( "=====start map/reduce=====");

	//-------------------------------------------
	//1, init device
	//-------------------------------------------
	//CUT_DEVICE_INIT();
	DoLog( "** init GPU");
	InitMapReduce(spec);

	//-------------------------------------------
	//2, start map
	//-------------------------------------------
	DoLog( "----------start map-----------");
	if (startMap(spec))
	{
		printf("** No output.");
		return;
	}

	if (g_spec->workflow == MAP_ONLY)
	{
		g_spec->outputKeys = g_spec->interKeys;	
		g_spec->outputVals = g_spec->interVals;
		g_spec->outputOffsetSizes = g_spec->interOffsetSizes;
		g_spec->outputRecordCount = g_spec->interRecordCount;
		g_spec->outputAllKeySize = g_spec->interAllKeySize;
		g_spec->outputAllValSize = g_spec->interAllValSize;
		goto EXIT_MR;
	}

	//-------------------------------------------
	//3, start group
	//-------------------------------------------
	DoLog( "----------start group-----------");
	TimeVal_t groupTimer;
	startTimer(&groupTimer);
	startGroup(spec);
	endTimer("Group", &groupTimer);

	if (g_spec->workflow == MAP_GROUP)
	{
		g_spec->outputKeys = g_spec->interKeys;	
		g_spec->outputVals = g_spec->interVals;
		g_spec->outputOffsetSizes = g_spec->interOffsetSizes;
		g_spec->outputRecordCount = g_spec->interRecordCount;
		g_spec->outputAllKeySize = g_spec->interAllKeySize;
		g_spec->outputAllValSize = g_spec->interAllValSize;
		g_spec->outputDiffKeyCount = g_spec->interDiffKeyCount;
		if (g_spec->outputToHost == 1)
		{
			g_spec->outputKeyListRange = (int2*)malloc(sizeof(int2)*g_spec->outputDiffKeyCount);
			CUDA_SAFE_CALL(hipMemcpy(g_spec->outputKeyListRange, g_spec->interKeyListRange, sizeof(int2)*g_spec->outputDiffKeyCount, hipMemcpyDeviceToHost));
                        CUDA_SAFE_CALL(hipFree(g_spec->interKeyListRange));
		}
		goto EXIT_MR;
	}

	//-------------------------------------------
	//4, start reduce
	//-------------------------------------------
	DoLog( "----------start reduce--------");
	TimeVal_t reduceTimer;
	startTimer(&reduceTimer);
	startReduce(spec);
	endTimer("Reduce", &reduceTimer);
EXIT_MR:
	if (g_spec->outputToHost == 1)
	{
		int indexSize = g_spec->outputRecordCount * sizeof(int4);
		char* h_outputKeys = (char*)malloc(g_spec->outputAllKeySize);
		if (h_outputKeys == NULL) exit(0);
		char* h_outputVals = (char*)malloc(g_spec->outputAllValSize);
		if (h_outputVals == NULL) exit(0);
		int4* h_outputOffsetSizes = (int4*)malloc(indexSize);
		if (h_outputOffsetSizes == NULL) exit(0);

		CUDA_SAFE_CALL(hipMemcpy(h_outputKeys, g_spec->outputKeys, g_spec->outputAllKeySize, hipMemcpyDeviceToHost));
		CUDA_SAFE_CALL(hipMemcpy(h_outputVals, g_spec->outputVals, g_spec->outputAllValSize, hipMemcpyDeviceToHost));
		CUDA_SAFE_CALL(hipMemcpy(h_outputOffsetSizes, g_spec->outputOffsetSizes, indexSize, hipMemcpyDeviceToHost));

		CUDA_SAFE_CALL(hipFree(g_spec->outputKeys));
		CUDA_SAFE_CALL(hipFree(g_spec->outputVals));
		CUDA_SAFE_CALL(hipFree(g_spec->outputOffsetSizes));

		g_spec->outputKeys = h_outputKeys;
		g_spec->outputVals = h_outputVals;
		g_spec->outputOffsetSizes = h_outputOffsetSizes;
	}
}


extern "C"
// void FinishMapReduce(Spec_t* spec);
void FinishMapReduce(Spec_t* spec)
{
	Spec_t* g_spec = spec;
	//-------------------------------------------
	//1, free global variables' memory
	//-------------------------------------------
	free(g_spec->inputKeys);
	free(g_spec->inputVals);
	free(g_spec->inputOffsetSizes);
	
	if (g_spec->outputToHost == 1)
	{
		free(g_spec->outputKeys);
		free(g_spec->outputVals);
		free(g_spec->outputOffsetSizes);
		if (g_spec->workflow == MAP_GROUP)
			free(g_spec->outputKeyListRange);
	}
	else
	{
		hipFree(g_spec->outputKeys);
		hipFree(g_spec->outputVals);
		hipFree(g_spec->outputOffsetSizes);
		if (g_spec->workflow == MAP_GROUP)
			hipFree(g_spec->outputKeyListRange);
	}

	free(g_spec);

	DoLog( "=====finish map/reduce=====");
}


void MakeMapInput(Spec_t *spec,
		  char *fdata, 
		  int fsize,
		  void *(*make_routine)(void*), 
		  int threadNum,
		  void *other);

//-------------------------------------------------------
//MarsUtils.cu
//-------------------------------------------------------
typedef struct timeval TimeVal_t;

extern "C"
// void startTimer(TimeVal_t *timer);
void startTimer(TimeVal_t *start_tv)
{
   gettimeofday((struct timeval*)start_tv, NULL);
}

extern "C"
// void endTimer(char *info, TimeVal_t *timer);
void endTimer(char *msg, TimeVal_t *start_tv)
{
	hipDeviceSynchronize();
   struct timeval end_tv;

   gettimeofday(&end_tv, NULL);

   time_t sec = end_tv.tv_sec - start_tv->tv_sec;
   time_t ms = end_tv.tv_usec - start_tv->tv_usec;

   time_t diff = sec * 1000000 + ms;

   printf("%10s:\t\t%fms\n", msg, (double)((double)diff/1000.0));
}


#ifdef _DEBUG
#define DoLog(...) do{printf(__VA_ARGS__);printf("\n");}while(0)
#else
#define DoLog(...) //do{printf(__VA_ARGS__);printf("\n");}while(0)
#endif

typedef void (*PrintFunc_t)(void* key, void* val, int keySize, int valSize);
// void PrintOutputRecords(Spec_t* spec, int num, PrintFunc_t printFunc);
void PrintOutputRecords(Spec_t* spec, int num, PrintFunc_t printFunc)
{
	int maxNum = num;
	if (maxNum > spec->outputRecordCount || maxNum < 0) maxNum = spec->outputRecordCount;
	for (int i = 0; i < maxNum; ++i)
	{
		int4 index = spec->outputOffsetSizes[i];
		printFunc((char*)spec->outputKeys + index.x, (char*)spec->outputVals + index.z, index.y, index.w);
	}
}


#endif //__SYSDEP_H__
