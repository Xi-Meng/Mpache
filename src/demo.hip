// #include <hip/hip_ext.h>
#include <hip/hip_runtime.h>
// #include <hip/hipfort.f>

int main() {
    hipDevice_t device;
    hipStream_t stream;
    uint32_t cuMask[3] = {0xFFFFFFFF, 0xFFFFFFFF, 0}; // 这代表您希望使用前40个CU（0到39），即总共80个计算单元的前一半。
    hipError_t status = hipExtStreamCreateWithCUMask(&stream, 3, cuMask);
    if (status != hipSuccess) {
        // 处理错误
    }
    hipStreamDestroy(stream);
    return 0;

}

