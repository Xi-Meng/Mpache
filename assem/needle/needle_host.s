	.text
	.file	"needle.hip"
	.globl	_Z7maximumiii                   # -- Begin function _Z7maximumiii
	.p2align	4, 0x90
	.type	_Z7maximumiii,@function
_Z7maximumiii:                          # @_Z7maximumiii
	.cfi_startproc
# %bb.0:
	movl	%esi, %eax
	cmpl	%esi, %edi
	cmovgl	%edi, %eax
	cmpl	%edx, %eax
	cmovlel	%edx, %eax
	retq
.Lfunc_end0:
	.size	_Z7maximumiii, .Lfunc_end0-_Z7maximumiii
	.cfi_endproc
                                        # -- End function
	.globl	_Z35__device_stub__needle_cuda_shared_1PiS_iiii # -- Begin function _Z35__device_stub__needle_cuda_shared_1PiS_iiii
	.p2align	4, 0x90
	.type	_Z35__device_stub__needle_cuda_shared_1PiS_iiii,@function
_Z35__device_stub__needle_cuda_shared_1PiS_iiii: # @_Z35__device_stub__needle_cuda_shared_1PiS_iiii
	.cfi_startproc
# %bb.0:
	subq	$136, %rsp
	.cfi_def_cfa_offset 144
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movl	%edx, 12(%rsp)
	movl	%ecx, 8(%rsp)
	movl	%r8d, 4(%rsp)
	movl	%r9d, (%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	%rsp, %rax
	movq	%rax, 120(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	leaq	80(%rsp), %r9
	movl	$_Z20needle_cuda_shared_1PiS_iiii, %edi
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$152, %rsp
	.cfi_adjust_cfa_offset -152
	retq
.Lfunc_end1:
	.size	_Z35__device_stub__needle_cuda_shared_1PiS_iiii, .Lfunc_end1-_Z35__device_stub__needle_cuda_shared_1PiS_iiii
	.cfi_endproc
                                        # -- End function
	.globl	_Z35__device_stub__needle_cuda_shared_2PiS_iiii # -- Begin function _Z35__device_stub__needle_cuda_shared_2PiS_iiii
	.p2align	4, 0x90
	.type	_Z35__device_stub__needle_cuda_shared_2PiS_iiii,@function
_Z35__device_stub__needle_cuda_shared_2PiS_iiii: # @_Z35__device_stub__needle_cuda_shared_2PiS_iiii
	.cfi_startproc
# %bb.0:
	subq	$136, %rsp
	.cfi_def_cfa_offset 144
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movl	%edx, 12(%rsp)
	movl	%ecx, 8(%rsp)
	movl	%r8d, 4(%rsp)
	movl	%r9d, (%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	%rsp, %rax
	movq	%rax, 120(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	leaq	80(%rsp), %r9
	movl	$_Z20needle_cuda_shared_2PiS_iiii, %edi
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$152, %rsp
	.cfi_adjust_cfa_offset -152
	retq
.Lfunc_end2:
	.size	_Z35__device_stub__needle_cuda_shared_2PiS_iiii, .Lfunc_end2-_Z35__device_stub__needle_cuda_shared_2PiS_iiii
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z7gettimev
.LCPI3_0:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
	.text
	.globl	_Z7gettimev
	.p2align	4, 0x90
	.type	_Z7gettimev,@function
_Z7gettimev:                            # @_Z7gettimev
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	leaq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday
	cvtsi2sdq	8(%rsp), %xmm1
	cvtsi2sdq	16(%rsp), %xmm0
	mulsd	.LCPI3_0(%rip), %xmm0
	addsd	%xmm1, %xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_Z7gettimev, .Lfunc_end3-_Z7gettimev
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.L.str, %edi
	movl	$16, %esi
	xorl	%eax, %eax
	callq	printf
	callq	_Z7runTestiPPc
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z7runTestiPPc
.LCPI5_0:
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
.LCPI5_1:
	.long	4294967286                      # 0xfffffff6
	.long	4294967286                      # 0xfffffff6
	.long	4294967286                      # 0xfffffff6
	.long	4294967286                      # 0xfffffff6
.LCPI5_2:
	.long	4294967256                      # 0xffffffd8
	.long	4294967256                      # 0xffffffd8
	.long	4294967256                      # 0xffffffd8
	.long	4294967256                      # 0xffffffd8
.LCPI5_3:
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
	.text
	.globl	_Z7runTestiPPc
	.p2align	4, 0x90
	.type	_Z7runTestiPPc,@function
_Z7runTestiPPc:                         # @_Z7runTestiPPc
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
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	xorl	%edi, %edi
	callq	hipSetDevice
	leaq	208(%rsp), %rdi
	callq	hipStreamCreate
	leaq	200(%rsp), %rdi
	callq	hipStreamCreate
	movl	$1073872900, %edi               # imm = 0x40020004
	callq	malloc
	movq	%rax, %r15
	movl	$1, %edi
	movl	$1073872900, %esi               # imm = 0x40020004
	callq	calloc@PLT
	movq	%rax, %r14
	movl	$1073872900, %edi               # imm = 0x40020004
	callq	malloc
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	testq	%r14, %r14
	je	.LBB5_1
.LBB5_2:
	movl	$7, %edi
	callq	srand
	movl	$.Lstr, %edi
	callq	puts@PLT
	movl	$65540, %ebx                    # imm = 0x10004
	.p2align	4, 0x90
.LBB5_3:                                # =>This Inner Loop Header: Depth=1
	callq	rand
	cltq
	imulq	$1717986919, %rax, %rcx         # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	addl	%ecx, %ecx
	leal	(%rcx,%rcx,4), %ecx
	negl	%ecx
	addl	%ecx, %eax
	incl	%eax
	movl	%eax, (%r14,%rbx)
	addq	$65540, %rbx                    # imm = 0x10004
	cmpq	$1073872900, %rbx               # imm = 0x40020004
	jne	.LBB5_3
# %bb.4:
	movl	$1, %ebx
	.p2align	4, 0x90
.LBB5_5:                                # =>This Inner Loop Header: Depth=1
	callq	rand
	cltq
	imulq	$1717986919, %rax, %rcx         # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	addl	%ecx, %ecx
	leal	(%rcx,%rcx,4), %ecx
	negl	%ecx
	addl	%ecx, %eax
	incl	%eax
	movl	%eax, (%r14,%rbx,4)
	incq	%rbx
	cmpq	$16385, %rbx                    # imm = 0x4001
	jne	.LBB5_5
# %bb.6:
	movq	%r15, %rax
	addq	$65544, %rax                    # imm = 0x10008
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB5_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_8 Depth 2
	movq	%rcx, %rdx
	shlq	$16, %rdx
	leaq	(%rdx,%rcx,4), %rdx
	movslq	(%r14,%rdx), %rdx
	movl	$8, %esi
	.p2align	4, 0x90
.LBB5_8:                                #   Parent Loop BB5_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-4(%r14,%rsi), %rdi
	leaq	(%rdx,%rdx,2), %r8
	shlq	$5, %r8
	movl	blosum62(%r8,%rdi,4), %edi
	movl	%edi, -8(%rax,%rsi)
	movslq	(%r14,%rsi), %rdi
	movl	blosum62(%r8,%rdi,4), %edi
	movl	%edi, -4(%rax,%rsi)
	addq	$8, %rsi
	cmpq	$65544, %rsi                    # imm = 0x10008
	jne	.LBB5_8
# %bb.9:                                #   in Loop: Header=BB5_7 Depth=1
	incq	%rcx
	addq	$65540, %rax                    # imm = 0x10004
	cmpq	$16385, %rcx                    # imm = 0x4001
	jne	.LBB5_7
# %bb.10:
	movl	$262160, %eax                   # imm = 0x40010
	movl	$-40, %ecx
	.p2align	4, 0x90
.LBB5_11:                               # =>This Inner Loop Header: Depth=1
	leal	30(%rcx), %edx
	movl	%edx, -196620(%r14,%rax)
	leal	20(%rcx), %edx
	movl	%edx, -131080(%r14,%rax)
	leal	10(%rcx), %edx
	movl	%edx, -65540(%r14,%rax)
	movl	%ecx, (%r14,%rax)
	addq	$262160, %rax                   # imm = 0x40010
	addl	$-40, %ecx
	cmpq	$1074069520, %rax               # imm = 0x40050010
	jne	.LBB5_11
# %bb.12:
	movdqa	.LCPI5_0(%rip), %xmm0           # xmm0 = [1,2,3,4]
	movl	$5, %eax
	movdqa	.LCPI5_1(%rip), %xmm1           # xmm1 = [4294967286,4294967286,4294967286,4294967286]
	movdqa	.LCPI5_2(%rip), %xmm2           # xmm2 = [4294967256,4294967256,4294967256,4294967256]
	movdqa	.LCPI5_3(%rip), %xmm3           # xmm3 = [8,8,8,8]
	.p2align	4, 0x90
.LBB5_13:                               # =>This Inner Loop Header: Depth=1
	movdqa	%xmm0, %xmm4
	pmuludq	%xmm1, %xmm4
	pshufd	$232, %xmm4, %xmm4              # xmm4 = xmm4[0,2,2,3]
	pshufd	$245, %xmm0, %xmm5              # xmm5 = xmm0[1,1,3,3]
	pmuludq	%xmm1, %xmm5
	pshufd	$232, %xmm5, %xmm5              # xmm5 = xmm5[0,2,2,3]
	punpckldq	%xmm5, %xmm4            # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
	movdqu	%xmm4, -16(%r14,%rax,4)
	paddd	%xmm2, %xmm4
	movdqu	%xmm4, (%r14,%rax,4)
	paddd	%xmm3, %xmm0
	addq	$8, %rax
	cmpq	$16389, %rax                    # imm = 0x4005
	jne	.LBB5_13
# %bb.14:
	movabsq	$4294967296, %rbx               # imm = 0x100000000
	leaq	40(%rsp), %rdi
	movl	$1073872900, %esi               # imm = 0x40020004
	callq	hipMalloc
	leaq	24(%rsp), %rdi
	movl	$1073872900, %esi               # imm = 0x40020004
	callq	hipMalloc
	movq	40(%rsp), %rdi
	movl	$1073872900, %edx               # imm = 0x40020004
	movq	%r15, 192(%rsp)                 # 8-byte Spill
	movq	%r15, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	24(%rsp), %rdi
	movl	$1073872900, %edx               # imm = 0x40020004
	movq	%r14, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movl	$.L.str.6, %edi
	movl	$1024, %esi                     # imm = 0x400
	xorl	%eax, %eax
	callq	printf
	leaq	120(%rsp), %rdi
	callq	hipEventCreate
	leaq	48(%rsp), %rdi
	callq	hipEventCreate
	movl	$1065353216, 32(%rsp)           # imm = 0x3F800000
	movq	120(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movl	$1, %r15d
	leaq	16(%rbx), %r12
	leaq	36(%rsp), %rbp
	leaq	88(%rsp), %r13
	jmp	.LBB5_15
	.p2align	4, 0x90
.LBB5_17:                               #   in Loop: Header=BB5_15 Depth=1
	incq	%r15
	cmpq	$1025, %r15                     # imm = 0x401
	je	.LBB5_18
.LBB5_15:                               # =>This Inner Loop Header: Depth=1
	movq	%r15, %rdi
	orq	%rbx, %rdi
	movl	$1, %esi
	movq	%r12, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB5_17
# %bb.16:                               #   in Loop: Header=BB5_15 Depth=1
	movq	40(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rax, 112(%rsp)
	movq	%rcx, 104(%rsp)
	movl	$16385, 20(%rsp)                # imm = 0x4001
	movl	$10, 16(%rsp)
	movl	%r15d, 12(%rsp)
	movl	$1024, 36(%rsp)                 # imm = 0x400
	leaq	112(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	%rbp, 168(%rsp)
	movq	%r13, %rdi
	leaq	72(%rsp), %rsi
	leaq	64(%rsp), %rdx
	leaq	56(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	88(%rsp), %rsi
	movl	96(%rsp), %edx
	movq	72(%rsp), %rcx
	movl	80(%rsp), %r8d
	movl	$_Z20needle_cuda_shared_1PiS_iiii, %edi
	leaq	128(%rsp), %r9
	pushq	56(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	72(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	jmp	.LBB5_17
.LBB5_18:
	movl	$1023, %r13d                    # imm = 0x3FF
	leaq	128(%rsp), %r15
	jmp	.LBB5_19
	.p2align	4, 0x90
.LBB5_21:                               #   in Loop: Header=BB5_19 Depth=1
	leaq	-1(%r13), %rax
	cmpq	$1, %r13
	movq	%rax, %r13
	jbe	.LBB5_22
.LBB5_19:                               # =>This Inner Loop Header: Depth=1
	movq	%r13, %rdi
	orq	%rbx, %rdi
	movl	$1, %esi
	movq	%r12, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB5_21
# %bb.20:                               #   in Loop: Header=BB5_19 Depth=1
	movq	40(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rax, 112(%rsp)
	movq	%rcx, 104(%rsp)
	movl	$16385, 20(%rsp)                # imm = 0x4001
	movl	$10, 16(%rsp)
	movl	%r13d, 12(%rsp)
	movl	$1024, 36(%rsp)                 # imm = 0x400
	leaq	112(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	%rbp, 168(%rsp)
	leaq	88(%rsp), %rdi
	leaq	72(%rsp), %rsi
	leaq	64(%rsp), %rdx
	leaq	56(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	88(%rsp), %rsi
	movl	96(%rsp), %edx
	movq	72(%rsp), %rcx
	movl	80(%rsp), %r8d
	movl	$_Z20needle_cuda_shared_2PiS_iiii, %edi
	movq	%r15, %r9
	pushq	56(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	72(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	jmp	.LBB5_21
.LBB5_22:
	movq	48(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movq	48(%rsp), %rdi
	callq	hipEventSynchronize
	movq	120(%rsp), %rsi
	movq	48(%rsp), %rdx
	leaq	32(%rsp), %rdi
	callq	hipEventElapsedTime
	movss	32(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.7, %edi
	movb	$1, %al
	callq	printf
	movq	24(%rsp), %rsi
	movl	$1073872900, %edx               # imm = 0x40020004
	movq	184(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	movl	$2, %ecx
	callq	hipMemcpy
	movq	208(%rsp), %rdi
	callq	hipStreamDestroy
	movq	200(%rsp), %rdi
	callq	hipStreamDestroy
	movq	40(%rsp), %rdi
	callq	hipFree
	movq	24(%rsp), %rdi
	callq	hipFree
	movq	192(%rsp), %rdi                 # 8-byte Reload
	callq	free
	movq	%r14, %rdi
	callq	free
	movq	%rbx, %rdi
	callq	free
	addq	$216, %rsp
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
.LBB5_1:
	.cfi_def_cfa_offset 272
	movq	stderr(%rip), %rcx
	movl	$.L.str.4, %edi
	movl	$30, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	jmp	.LBB5_2
.Lfunc_end5:
	.size	_Z7runTestiPPc, .Lfunc_end5-_Z7runTestiPPc
	.cfi_endproc
                                        # -- End function
	.globl	_Z5usageiPPc                    # -- Begin function _Z5usageiPPc
	.p2align	4, 0x90
	.type	_Z5usageiPPc,@function
_Z5usageiPPc:                           # @_Z5usageiPPc
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movq	(%rsi), %rdx
	movl	$.L.str.1, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rcx
	movl	$.L.str.2, %edi
	movl	$35, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movq	stderr(%rip), %rcx
	movl	$.L.str.3, %edi
	movl	$39, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end6:
	.size	_Z5usageiPPc, .Lfunc_end6-_Z5usageiPPc
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -16
	movq	__hip_gpubin_handle(%rip), %rbx
	testq	%rbx, %rbx
	jne	.LBB7_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rbx
	movq	%rax, __hip_gpubin_handle(%rip)
.LBB7_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z20needle_cuda_shared_1PiS_iiii, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movq	%rbx, %rdi
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z20needle_cuda_shared_2PiS_iiii, %esi
	movl	$.L__unnamed_2, %edx
	movl	$.L__unnamed_2, %ecx
	movq	%rbx, %rdi
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	movl	$__hip_module_dtor, %edi
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	atexit                          # TAILCALL
.Lfunc_end7:
	.size	__hip_module_ctor, .Lfunc_end7-__hip_module_ctor
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
	je	.LBB8_2
# %bb.1:
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle(%rip)
.LBB8_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	__hip_module_dtor, .Lfunc_end8-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	_Z20needle_cuda_shared_1PiS_iiii,@object # @_Z20needle_cuda_shared_1PiS_iiii
	.section	.rodata,"a",@progbits
	.globl	_Z20needle_cuda_shared_1PiS_iiii
	.p2align	3, 0x0
_Z20needle_cuda_shared_1PiS_iiii:
	.quad	_Z35__device_stub__needle_cuda_shared_1PiS_iiii
	.size	_Z20needle_cuda_shared_1PiS_iiii, 8

	.type	_Z20needle_cuda_shared_2PiS_iiii,@object # @_Z20needle_cuda_shared_2PiS_iiii
	.globl	_Z20needle_cuda_shared_2PiS_iiii
	.p2align	3, 0x0
_Z20needle_cuda_shared_2PiS_iiii:
	.quad	_Z35__device_stub__needle_cuda_shared_2PiS_iiii
	.size	_Z20needle_cuda_shared_2PiS_iiii, 8

	.type	blosum62,@object                # @blosum62
	.data
	.globl	blosum62
	.p2align	4, 0x0
blosum62:
	.long	4                               # 0x4
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	5                               # 0x5
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	2                               # 0x2
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	6                               # 0x6
	.long	1                               # 0x1
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	3                               # 0x3
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	6                               # 0x6
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	2                               # 0x2
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	9                               # 0x9
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	5                               # 0x5
	.long	2                               # 0x2
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	3                               # 0x3
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	2                               # 0x2
	.long	4294967292                      # 0xfffffffc
	.long	2                               # 0x2
	.long	5                               # 0x5
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	1                               # 0x1
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	6                               # 0x6
	.long	4294967294                      # 0xfffffffe
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	8                               # 0x8
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	2                               # 0x2
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4                               # 0x4
	.long	2                               # 0x2
	.long	4294967293                      # 0xfffffffd
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	3                               # 0x3
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	2                               # 0x2
	.long	4                               # 0x4
	.long	4294967294                      # 0xfffffffe
	.long	2                               # 0x2
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	2                               # 0x2
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	1                               # 0x1
	.long	1                               # 0x1
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	5                               # 0x5
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	4294967295                      # 0xffffffff
	.long	5                               # 0x5
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	6                               # 0x6
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	3                               # 0x3
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967292                      # 0xfffffffc
	.long	7                               # 0x7
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967292                      # 0xfffffffc
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	5                               # 0x5
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	1                               # 0x1
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	11                              # 0xb
	.long	2                               # 0x2
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	2                               # 0x2
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	3                               # 0x3
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	2                               # 0x2
	.long	7                               # 0x7
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	3                               # 0x3
	.long	1                               # 0x1
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	4                               # 0x4
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	4294967293                      # 0xfffffffd
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	4294967293                      # 0xfffffffd
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	4294967293                      # 0xfffffffd
	.long	4294967293                      # 0xfffffffd
	.long	1                               # 0x1
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967293                      # 0xfffffffd
	.long	4294967294                      # 0xfffffffe
	.long	4294967294                      # 0xfffffffe
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	0                               # 0x0
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967294                      # 0xfffffffe
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	4294967294                      # 0xfffffffe
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	4294967292                      # 0xfffffffc
	.long	1                               # 0x1
	.size	blosum62, 2304

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"WG size of kernel = %d \n"
	.size	.L.str, 25

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Usage: %s <max_rows/max_cols> <penalty> \n"
	.size	.L.str.1, 42

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"\t<dimension>  - x and y dimensions\n"
	.size	.L.str.2, 36

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"\t<penalty> - penalty(positive integer)\n"
	.size	.L.str.3, 40

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"error: can not allocate memory"
	.size	.L.str.4, 31

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"block_width:%d\n"
	.size	.L.str.6, 16

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"kernel time (hipEventElapsedTime)=%6.3fms\n"
	.size	.L.str.7, 43

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z20needle_cuda_shared_1PiS_iiii"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"_Z20needle_cuda_shared_2PiS_iiii"
	.size	.L__unnamed_2, 33

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
	.asciz	"Start Needleman-Wunsch"
	.size	.Lstr, 23

	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z35__device_stub__needle_cuda_shared_1PiS_iiii
	.addrsig_sym _Z35__device_stub__needle_cuda_shared_2PiS_iiii
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Z20needle_cuda_shared_1PiS_iiii
	.addrsig_sym _Z20needle_cuda_shared_2PiS_iiii
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
