	.text
	.file	"spmv_my.hip"
	.globl	_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i # -- Begin function _Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i
	.p2align	4, 0x90
	.type	_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i,@function
_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i: # @_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i
	.cfi_startproc
# %bb.0:
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movq	%r8, 56(%rsp)
	movq	%r9, 48(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	160(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	32(%rsp), %rdi
	leaq	16(%rsp), %rsi
	leaq	8(%rsp), %rdx
	movq	%rsp, %rcx
	callq	__hipPopCallConfiguration
	movq	32(%rsp), %rsi
	movl	40(%rsp), %edx
	movq	16(%rsp), %rcx
	movl	24(%rsp), %r8d
	leaq	96(%rsp), %r9
	movl	$_Z8spmv_jdsPfPKfPKiS3_S1_S3_i, %edi
	pushq	(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$168, %rsp
	.cfi_adjust_cfa_offset -168
	retq
.Lfunc_end0:
	.size	_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i, .Lfunc_end0-_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$1432, %rsp                     # imm = 0x598
	.cfi_def_cfa_offset 1488
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbx
	movabsq	$4294967296, %r15               # imm = 0x100000000
	movl	%edi, 88(%rsp)
	movl	$.Lstr, %edi
	callq	puts@PLT
	movl	$.Lstr.9, %edi
	callq	puts@PLT
	movl	$.Lstr.10, %edi
	callq	puts@PLT
	leaq	88(%rsp), %rdi
	movq	%rbx, %rsi
	callq	pb_ReadParameters
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	leaq	352(%rsp), %rbx
	movq	%rbx, %rdi
	callq	pb_InitializeTimerSet
	movq	%rbx, %rdi
	movl	$6, %esi
	callq	pb_SwitchToTimer
	movq	%rbx, %rdi
	movl	$1, %esi
	callq	pb_SwitchToTimer
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	leaq	44(%rsp), %rax
	leaq	28(%rsp), %r10
	leaq	24(%rsp), %r11
	leaq	20(%rsp), %rbx
	leaq	292(%rsp), %r14
	leaq	128(%rsp), %r13
	leaq	144(%rsp), %rbp
	leaq	120(%rsp), %r12
	movl	$.L.str.3, %edi
	movl	$1, %esi
	movl	$32, %edx
	movl	$1, %ecx
	movl	$1, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	pushq	%r11
	.cfi_adjust_cfa_offset 8
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	pushq	%r14
	.cfi_adjust_cfa_offset 8
	pushq	%r13
	.cfi_adjust_cfa_offset 8
	pushq	%rbp
	.cfi_adjust_cfa_offset 8
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	leaq	200(%rsp), %rax
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	leaq	224(%rsp), %rax
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	$1
	.cfi_adjust_cfa_offset 8
	callq	coo_to_jds
	addq	$96, %rsp
	.cfi_adjust_cfa_offset -96
	movslq	12(%rsp), %rbx
	movq	%rbx, %r14
	shlq	$2, %r14
	movq	%r14, %rdi
	callq	malloc
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	%r14, %rdi
	callq	malloc
	movq	%rax, %r14
	movl	$.L.str.4, %edi
	movq	%rax, %rsi
	movl	%ebx, %edx
	callq	_Z9input_vecPcPfi
	leaq	352(%rsp), %rbx
	movq	%rbx, %rdi
	movl	$6, %esi
	callq	pb_SwitchToTimer
	leaq	640(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipGetDeviceProperties
	movq	%rbx, %rdi
	movl	$3, %esi
	callq	pb_SwitchToTimer
	movslq	16(%rsp), %rsi
	shlq	$2, %rsi
	leaq	80(%rsp), %rdi
	callq	hipMalloc
	movslq	16(%rsp), %rsi
	shlq	$2, %rsi
	leaq	72(%rsp), %rdi
	callq	hipMalloc
	movslq	36(%rsp), %rsi
	shlq	$2, %rsi
	leaq	176(%rsp), %rdi
	callq	hipMalloc
	movslq	12(%rsp), %rsi
	shlq	$2, %rsi
	leaq	64(%rsp), %rdi
	callq	hipMalloc
	movslq	20(%rsp), %rsi
	shlq	$2, %rsi
	leaq	104(%rsp), %rdi
	callq	hipMalloc
	movslq	12(%rsp), %rsi
	shlq	$2, %rsi
	leaq	56(%rsp), %rdi
	callq	hipMalloc
	movslq	12(%rsp), %rsi
	shlq	$2, %rsi
	leaq	40(%rsp), %rdi
	callq	hipMalloc
	movq	40(%rsp), %rdi
	movslq	12(%rsp), %rdx
	shlq	$2, %rdx
	xorl	%esi, %esi
	callq	hipMemset
	movq	80(%rsp), %rdi
	movq	144(%rsp), %rsi
	movslq	16(%rsp), %rdx
	shlq	$2, %rdx
	movl	$1, %ecx
	callq	hipMemcpy
	movq	72(%rsp), %rdi
	movq	136(%rsp), %rsi
	movslq	16(%rsp), %rdx
	shlq	$2, %rdx
	movl	$1, %ecx
	callq	hipMemcpy
	movq	64(%rsp), %rdi
	movq	120(%rsp), %rsi
	movslq	12(%rsp), %rdx
	shlq	$2, %rdx
	movl	$1, %ecx
	callq	hipMemcpy
	movq	56(%rsp), %rdi
	movslq	12(%rsp), %rdx
	shlq	$2, %rdx
	movq	%r14, 152(%rsp)                 # 8-byte Spill
	movq	%r14, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	128(%rsp), %rsi
	movslq	36(%rsp), %rdx
	shlq	$2, %rdx
	movl	$jds_ptr_int, %edi
	xorl	%ecx, %ecx
	movl	$1, %r8d
	callq	hipMemcpyToSymbol
	movq	112(%rsp), %rsi
	movslq	20(%rsp), %rdx
	shlq	$2, %rdx
	movl	$sh_zcnt_int, %edi
	xorl	%ecx, %ecx
	movl	$1, %r8d
	callq	hipMemcpyToSymbol
	callq	hipDeviceSynchronize
	movq	%rbx, %rdi
	movl	$6, %esi
	callq	pb_SwitchToTimer
	movl	20(%rsp), %edx
	movl	916(%rsp), %eax
	movl	968(%rsp), %r8d
	movl	972(%rsp), %r9d
	movl	976(%rsp), %r10d
	leaq	28(%rsp), %rdi
	leaq	32(%rsp), %rsi
	movl	$32, %ecx
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	callq	_Z21compute_active_threadPjS_iiiiii
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movl	32(%rsp), %esi
	movl	28(%rsp), %edx
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	printf
	movl	972(%rsp), %esi
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	printf
	movq	%rbx, %rdi
	movl	$2, %esi
	callq	pb_SwitchToTimer
	leaq	96(%rsp), %rdi
	callq	hipEventCreate
	leaq	48(%rsp), %rdi
	callq	hipEventCreate
	movl	$1065353216, 24(%rsp)           # imm = 0x3F800000
	movq	96(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movl	$50, %r12d
	leaq	200(%rsp), %r13
	leaq	192(%rsp), %rbp
	leaq	184(%rsp), %rbx
	leaq	288(%rsp), %r14
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_3:                                #   in Loop: Header=BB1_1 Depth=1
	decl	%r12d
	je	.LBB1_4
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movl	32(%rsp), %edi
	movl	28(%rsp), %edx
	orq	%r15, %rdi
	orq	%r15, %rdx
	movl	$1, %esi
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB1_3
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movq	40(%rsp), %rax
	movq	80(%rsp), %rcx
	movq	72(%rsp), %rdx
	movq	64(%rsp), %rsi
	movq	56(%rsp), %rdi
	movq	104(%rsp), %r8
	movl	12(%rsp), %r9d
	movq	%rax, 272(%rsp)
	movq	%rcx, 264(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsi, 248(%rsp)
	movq	%rdi, 240(%rsp)
	movq	%r8, 232(%rsp)
	movl	%r9d, 92(%rsp)
	leaq	272(%rsp), %rax
	movq	%rax, 288(%rsp)
	leaq	264(%rsp), %rax
	movq	%rax, 296(%rsp)
	leaq	256(%rsp), %rax
	movq	%rax, 304(%rsp)
	leaq	248(%rsp), %rax
	movq	%rax, 312(%rsp)
	leaq	240(%rsp), %rax
	movq	%rax, 320(%rsp)
	leaq	232(%rsp), %rax
	movq	%rax, 328(%rsp)
	leaq	92(%rsp), %rax
	movq	%rax, 336(%rsp)
	leaq	216(%rsp), %rdi
	movq	%r13, %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rcx
	callq	__hipPopCallConfiguration
	movq	216(%rsp), %rsi
	movl	224(%rsp), %edx
	movq	200(%rsp), %rcx
	movl	208(%rsp), %r8d
	movl	$_Z8spmv_jdsPfPKfPKiS3_S1_S3_i, %edi
	movq	%r14, %r9
	pushq	184(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	200(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	jmp	.LBB1_3
.LBB1_4:
	movq	48(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movq	48(%rsp), %rdi
	callq	hipEventSynchronize
	movq	96(%rsp), %rsi
	movq	48(%rsp), %rdx
	leaq	24(%rsp), %rdi
	callq	hipEventElapsedTime
	movss	24(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.7, %edi
	movb	$1, %al
	callq	printf
	leaq	352(%rsp), %r12
	movq	%r12, %rdi
	movl	$3, %esi
	callq	pb_SwitchToTimer
	movq	40(%rsp), %rsi
	movslq	12(%rsp), %rdx
	shlq	$2, %rdx
	movq	160(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	movl	$2, %ecx
	callq	hipMemcpy
	callq	hipDeviceSynchronize
	movq	80(%rsp), %rdi
	callq	hipFree
	movq	72(%rsp), %rdi
	callq	hipFree
	movq	176(%rsp), %rdi
	callq	hipFree
	movq	64(%rsp), %rdi
	callq	hipFree
	movq	104(%rsp), %rdi
	callq	hipFree
	movq	56(%rsp), %rdi
	callq	hipFree
	movq	40(%rsp), %rdi
	callq	hipFree
	movq	%r12, %rdi
	movl	$1, %esi
	callq	pb_SwitchToTimer
	movl	12(%rsp), %edx
	movl	$.L.str.8, %edi
	movq	%rbx, %rsi
	callq	_Z10outputDataPcPfi
	movq	%r12, %rdi
	movl	$6, %esi
	callq	pb_SwitchToTimer
	movq	144(%rsp), %rdi
	callq	free
	movq	136(%rsp), %rdi
	callq	free
	movq	128(%rsp), %rdi
	callq	free
	movq	120(%rsp), %rdi
	callq	free
	movq	112(%rsp), %rdi
	callq	free
	movq	%rbx, %rdi
	callq	free
	movq	152(%rsp), %rdi                 # 8-byte Reload
	callq	free
	movq	%r12, %rdi
	xorl	%esi, %esi
	callq	pb_SwitchToTimer
	movq	%r12, %rdi
	callq	pb_PrintTimerSet
	movq	168(%rsp), %rdi                 # 8-byte Reload
	callq	pb_FreeParameters
	xorl	%eax, %eax
	addq	$1432, %rsp                     # imm = 0x598
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	__hip_gpubin_handle(%rip), %rbx
	testq	%rbx, %rbx
	jne	.LBB2_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rbx
	movq	%rax, __hip_gpubin_handle(%rip)
.LBB2_2:
	subq	$32, %rsp
	.cfi_adjust_cfa_offset 32
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z8spmv_jdsPfPKfPKiS3_S1_S3_i, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movq	%rbx, %rdi
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	addq	$32, %rsp
	.cfi_adjust_cfa_offset -32
	movl	$jds_ptr_int, %esi
	movl	$.L__unnamed_2, %edx
	movl	$.L__unnamed_2, %ecx
	movl	$20000, %r9d                    # imm = 0x4E20
	movq	%rbx, %rdi
	xorl	%r8d, %r8d
	pushq	$0
	.cfi_adjust_cfa_offset 8
	pushq	$1
	.cfi_adjust_cfa_offset 8
	callq	__hipRegisterVar
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movl	$sh_zcnt_int, %esi
	movl	$.L__unnamed_3, %edx
	movl	$.L__unnamed_3, %ecx
	movl	$20000, %r9d                    # imm = 0x4E20
	movq	%rbx, %rdi
	xorl	%r8d, %r8d
	pushq	$0
	.cfi_adjust_cfa_offset 8
	pushq	$1
	.cfi_adjust_cfa_offset 8
	callq	__hipRegisterVar
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movl	$__hip_module_dtor, %edi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	atexit                          # TAILCALL
.Lfunc_end2:
	.size	__hip_module_ctor, .Lfunc_end2-__hip_module_ctor
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __hip_module_dtor
	.type	__hip_module_dtor,@function
__hip_module_dtor:                      # @__hip_module_dtor
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	__hip_gpubin_handle(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB3_2
# %bb.1:
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle(%rip)
.LBB3_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	__hip_module_dtor, .Lfunc_end3-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	jds_ptr_int,@object             # @jds_ptr_int
	.local	jds_ptr_int
	.comm	jds_ptr_int,20000,16
	.type	sh_zcnt_int,@object             # @sh_zcnt_int
	.local	sh_zcnt_int
	.comm	sh_zcnt_int,20000,16
	.type	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i,@object # @_Z8spmv_jdsPfPKfPKiS3_S1_S3_i
	.section	.rodata,"a",@progbits
	.globl	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i
	.p2align	3, 0x0
_Z8spmv_jdsPfPKfPKiS3_S1_S3_i:
	.quad	_Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i
	.size	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i, 8

	.type	.L.str.3,@object                # @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"/workspace/Inst-level-cache-management/include/spmv_my/dataset/fidapm05.mtx"
	.size	.L.str.3, 76

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"/workspace/Inst-level-cache-management/include/spmv_my/dataset/fidapm05_rhs1.mtx"
	.size	.L.str.4, 81

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"grid: %d, block:%d \n"
	.size	.L.str.5, 21

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"deviceProp.major:%d,deviceProp.minor:%d\n"
	.size	.L.str.6, 41

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"kernel time (hipEventElapsedTime)=%6.3fms\n"
	.size	.L.str.7, 43

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"/workspace/Inst-level-cache-management/include/spmv_my/dataset/output.mtx"
	.size	.L.str.8, 74

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z8spmv_jdsPfPKfPKiS3_S1_S3_i"
	.size	.L__unnamed_1, 30

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"jds_ptr_int"
	.size	.L__unnamed_2, 12

	.type	.L__unnamed_3,@object           # @2
.L__unnamed_3:
	.asciz	"sh_zcnt_int"
	.size	.L__unnamed_3, 12

	.type	__hip_fatbin_wrapper,@object    # @__hip_fatbin_wrapper
	.section	.hipFatBinSegment,"a",@progbits
	.p2align	3, 0x0
__hip_fatbin_wrapper:
	.long	1212764230                      # 0x48495046
	.long	1                               # 0x1
	.quad	__hip_fatbin
	.quad	0
	.size	__hip_fatbin_wrapper, 24

	.hidden	__hip_gpubin_handle             # @__hip_gpubin_handle
	.type	__hip_gpubin_handle,@object
	.section	.bss.__hip_gpubin_handle,"aGw",@nobits,__hip_gpubin_handle,comdat
	.weak	__hip_gpubin_handle
	.p2align	3, 0x0
__hip_gpubin_handle:
	.quad	0
	.size	__hip_gpubin_handle, 8

	.section	.init_array,"aw",@init_array
	.p2align	3, 0x90
	.quad	__hip_module_ctor
	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"CUDA accelerated sparse matrix vector multiplication****"
	.size	.Lstr, 57

	.type	.Lstr.9,@object                 # @str.9
.Lstr.9:
	.asciz	"Original version by Li-Wen Chang <lchang20@illinois.edu> and Shengzhao Wu<wu14@illinois.edu>"
	.size	.Lstr.9, 93

	.type	.Lstr.10,@object                # @str.10
.Lstr.10:
	.asciz	"This version maintained by Chris Rodrigues  ***********"
	.size	.Lstr.10, 56

	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z23__device_stub__spmv_jdsPfPKfPKiS3_S1_S3_i
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym jds_ptr_int
	.addrsig_sym sh_zcnt_int
	.addrsig_sym _Z8spmv_jdsPfPKfPKiS3_S1_S3_i
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
