/*$Id: main.cu 738 2009-11-13 16:08:10Z wenbinor $*/
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

/***********************************************************************
 *Matrix Multiplication (MM): Matrix
 *multiplication is widely applicable to analyze the
 *relationship of two documents. Given two matrices M
 *and N, each Map computes multiplication for a row
 *from M and a column from N. It outputs the pair of the
 *row ID and the column ID as the key and the
 *corresponding result as the value. No Reduce stage is
 *required.
 ***********************************************************************/

// #include "MarsInc.h"
// #include "global.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>
#include <hip/hip_runtime.h>

//#define __OUTPUT__
#define MAP_ONLY		0x01
typedef struct timeval TimeVal_t;
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

typedef struct
{
	float* matrix1;
	float* matrix2;
} MM_KEY_T;

typedef struct
{
	int row;
	int col;
	int row_dim;
	int col_dim;
} MM_VAL_T;

void startTimer(TimeVal_t *start_tv)
{
   gettimeofday((struct timeval*)start_tv, NULL);
}

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

//----------------------------------------------
//Get default runtime configuration
//
//return: default spec
//----------------------------------------------
Spec_t *GetDefaultSpec()
{
	Spec_t *spec = (Spec_t*)malloc(sizeof(Spec_t));
	if (NULL == spec) exit(-1);
	memset(spec, 0, sizeof(Spec_t));

	return spec;
}


static float *GenMatrix(int M_ROW_COUNT, int M_COL_COUNT)
{
	float *matrix = (float*)malloc(sizeof(float)*M_ROW_COUNT*M_COL_COUNT);

	srand(time(0));
	for (int i = 0; i < M_ROW_COUNT; i++)
		for (int j = 0; j < M_COL_COUNT; j++)
			matrix[i*M_COL_COUNT+j] = (float)(rand() % 100);

	return matrix;
}

static float *RotateMatrix(float *matrix, int rowCount, int colCount)
{
	float *m = (float*)malloc(sizeof(float)*rowCount*colCount);

	for (int i = 0; i < rowCount; i++)
		for (int j = 0; j < colCount; j++)
				m[i * colCount + j] = matrix[i + colCount * j];

	return m;
}

void printFun(void* key, void* val, int keySize, int valSize)
{
	float* result = (float*)key;
	int2* pos = (int2*)val;

	printf("GPU: %f - (%d, %d)\n", *result, pos->x, pos->y);
}

void validate(float* matrix1, float* matrix2, int rowCount, int colCount, Spec_t* spec, int num)
{
	float* result = (float*)malloc(rowCount*rowCount*sizeof(float));
	int2* pos = (int2*)malloc(rowCount*rowCount*sizeof(int2));
	int count = 0;
	for (int i = 0; i < rowCount; i++)
	{
		for (int k = 0; k < rowCount; k++)
		{
			result[count] = 0.0f;
			for (int j = 0; j < colCount; j++)
				result[count] += (matrix1[i*colCount+j] * matrix2[k*colCount+j]);
			pos[count].x = i;
			pos[count].y = k;
			++count;
		}
	}

	for (int i = 0; i < num; i++)
		printf("CPU:%f - (%d, %d)\n", result[i], pos[i].x, pos[i].y);
	printf("-----------------\n");
	PrintOutputRecords(spec, num, printFun);
	free(result);
	free(pos);
}

//---------------------------------------------------------------
//usage: MatrixMul rowNum colNum [dimGrid dimBlock]
//param: rowNum
//param: colNum
//---------------------------------------------------------------
int main( int argc, char** argv) 
{
	if (argc != 3)
	{	
		printf("usage: %s rowNum colNum\n", argv[0]);
		exit(-1);
	}

	Spec_t *spec = GetDefaultSpec();
	spec->workflow = MAP_ONLY;
#ifdef __OUTPUT__
	spec->outputToHost = 1;
#endif

	int M_ROW_COUNT	= atoi(argv[1]);
	int M_COL_COUNT = atoi(argv[2]);

	//------------------------------------------------------------------
	//make map input
	//------------------------------------------------------------------
	TimeVal_t timer;
	startTimer(&timer);
	printf("generate two %dx%d matrice...\n", M_ROW_COUNT, M_COL_COUNT);
	float *matrix1 =  GenMatrix(M_ROW_COUNT, M_COL_COUNT);
	float *tmpMatrix2 =  GenMatrix(M_COL_COUNT, M_ROW_COUNT);

	TimeVal_t rotateTimer;
	startTimer(&rotateTimer);
	float *matrix2 = RotateMatrix(tmpMatrix2, M_COL_COUNT, M_ROW_COUNT);
	endTimer("rotate matrix2", &rotateTimer);

	DoLog("** load matrice...");
	int matrixSize = sizeof(float)*M_ROW_COUNT*M_COL_COUNT;

	float *d_matrix1 = NULL;
	hipMalloc((void**)&d_matrix1, matrixSize);
	hipMemcpy(d_matrix1, matrix1, matrixSize, hipMemcpyHostToDevice);

	float *d_matrix2 = NULL;
	hipMalloc((void**)&d_matrix2, matrixSize);
	hipMemcpy(d_matrix2, matrix2, matrixSize, hipMemcpyHostToDevice);

	MM_KEY_T key;
	MM_VAL_T val;

	key.matrix1 = d_matrix1;
	key.matrix2 = d_matrix2;

	val.row_dim = M_ROW_COUNT;
	val.col_dim = M_COL_COUNT;

	startTimer(&timer);

	for (int i = 0; i < M_ROW_COUNT; i++)
	{
		val.row = i;
		for (int j = 0; j < M_ROW_COUNT; j++)
		{
			val.col = j;
			AddMapInputRecord(spec, &key, &val, sizeof(MM_KEY_T), sizeof(MM_VAL_T));	
		}
	}

	//-----------------------------------------------------------------------
	//main MapReduce procedure
	//-----------------------------------------------------------------------
	MapReduce(spec);
	endTimer("all-test", &timer);

	//-----------------------------------------------------------------------
	//further processing
	//-----------------------------------------------------------------------
#ifdef __OUTPUT__
	validate(matrix1, matrix2, M_ROW_COUNT, M_COL_COUNT,spec, 10);
#endif

	//-----------------------------------------------------------------------
	//finish
	//-----------------------------------------------------------------------
	free(matrix1);
	free(matrix2);
	free(tmpMatrix2);
	hipFree(d_matrix1);
	hipFree(d_matrix2);

	FinishMapReduce(spec);

	return 0;
}
