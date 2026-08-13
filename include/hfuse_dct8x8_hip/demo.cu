__global__ void DCT8x8_kernel(
    float*__restrict__ dct_d_Dst,
    const float*__restrict__ dct_d_Src,
    const unsigned int dct_stride,
    const unsigned int dct_imageH,
    const unsigned int dct_imageW
){
    const unsigned int    dct_localX = threadIdx.x;
    const unsigned int    dct_localY = BLOCK_SIZE * threadIdx.y;
    const unsigned int dct_moddct_localX = dct_localX & (BLOCK_SIZE - 1);
    const unsigned int   dct_globalX = blockIdx.x * BLOCK_X + dct_localX;
    const unsigned int   dct_globalY = blockIdx.y * BLOCK_Y + dct_localY;

    __shared__ float dct_l_Transpose[BLOCK_Y * (BLOCK_X+1)];

    //Process only full blocks
    if( (dct_globalX - dct_moddct_localX + BLOCK_SIZE - 1 >= dct_imageW) || (dct_globalY + BLOCK_SIZE - 1 >= dct_imageH) )
        return;

    float *dct_l_V = &dct_l_Transpose[dct_localY * (BLOCK_X+1) + dct_localX];
    float *dct_l_H = &dct_l_Transpose[(dct_localY + dct_moddct_localX) * (BLOCK_X+1) + dct_localX - dct_moddct_localX];
    dct_d_Src += dct_globalY * dct_stride + dct_globalX;
    dct_d_Dst += dct_globalY * dct_stride + dct_globalX;

    float dct_D[8];
    for(unsigned int i = 0; i < BLOCK_SIZE; i++)
        dct_l_V[i * (BLOCK_X + 1)] = dct_d_Src[i * dct_stride];

    for(unsigned int i = 0; i < BLOCK_SIZE; i++)
        dct_D[i] = dct_l_H[i];
    DCT8(dct_D);
    for(unsigned int i = 0; i < BLOCK_SIZE; i++)
        dct_l_H[i] = dct_D[i];

    for(unsigned int i = 0; i < BLOCK_SIZE; i++)
        dct_D[i] = dct_l_V[i * (BLOCK_X + 1)];
    DCT8(dct_D);

    for(unsigned int i = 0; i < BLOCK_SIZE; i++)
        dct_d_Dst[i * dct_stride] = dct_D[i];
}