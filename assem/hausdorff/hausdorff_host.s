	.text
	.file	"hausdorff.hip"
	.globl	_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii # -- Begin function _Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.p2align	4, 0x90
	.type	_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii,@function
_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii: # @_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.cfi_startproc
# %bb.0:
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movq	%rdx, 56(%rsp)
	movl	%ecx, 4(%rsp)
	movl	%r8d, (%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	%rsp, %rax
	movq	%rax, 112(%rsp)
	leaq	40(%rsp), %rdi
	leaq	24(%rsp), %rsi
	leaq	16(%rsp), %rdx
	leaq	8(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	40(%rsp), %rsi
	movl	48(%rsp), %edx
	movq	24(%rsp), %rcx
	movl	32(%rsp), %r8d
	leaq	80(%rsp), %r9
	movl	$_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, %edi
	pushq	8(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	24(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$136, %rsp
	.cfi_adjust_cfa_offset -136
	retq
.Lfunc_end0:
	.size	_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, .Lfunc_end0-_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function main
.LCPI1_0:
	.long	0x30000000                      # float 4.65661287E-10
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI1_1:
	.quad	0x3eb0c6f7a0000000              # double 9.9999999747524271E-7
	.text
	.globl	main
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$160, %rsp
	.cfi_def_cfa_offset 208
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$4000000, %edi                  # imm = 0x3D0900
	callq	malloc
	movq	%rax, %rbx
	movl	$4000000, %edi                  # imm = 0x3D0900
	callq	malloc
	movq	%rax, %r14
	movl	$123, %edi
	callq	srand
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	callq	rand
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	.LCPI1_0(%rip), %xmm0
	movss	%xmm0, (%rbx,%r15,8)
	callq	rand
	movss	.LCPI1_0(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	%xmm1, %xmm0
	movss	%xmm0, 4(%rbx,%r15,8)
	incq	%r15
	cmpq	$500000, %r15                   # imm = 0x7A120
	jne	.LBB1_1
# %bb.2:
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	callq	rand
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	.LCPI1_0(%rip), %xmm0
	movss	%xmm0, (%r14,%r15,8)
	callq	rand
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	.LCPI1_0(%rip), %xmm0
	movss	%xmm0, 4(%r14,%r15,8)
	incq	%r15
	cmpq	$500000, %r15                   # imm = 0x7A120
	jne	.LBB1_3
# %bb.4:
	leaq	24(%rsp), %rdi
	movl	$4000000, %esi                  # imm = 0x3D0900
	callq	hipMalloc
	testl	%eax, %eax
	jne	.LBB1_5
# %bb.7:
	leaq	16(%rsp), %rdi
	movl	$4000000, %esi                  # imm = 0x3D0900
	callq	hipMalloc
	testl	%eax, %eax
	jne	.LBB1_8
# %bb.9:
	leaq	8(%rsp), %rdi
	movl	$8, %esi
	callq	hipMalloc
	testl	%eax, %eax
	jne	.LBB1_10
# %bb.11:
	movq	24(%rsp), %rdi
	movl	$4000000, %edx                  # imm = 0x3D0900
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	testl	%eax, %eax
	jne	.LBB1_12
# %bb.13:
	movq	16(%rsp), %rdi
	movl	$4000000, %edx                  # imm = 0x3D0900
	movq	%r14, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	testl	%eax, %eax
	jne	.LBB1_14
# %bb.15:
	movabsq	$-4647714812233515008, %rax     # imm = 0xBF800000BF800000
	movq	%rax, 104(%rsp)
	movq	8(%rsp), %rdi
	leaq	104(%rsp), %rsi
	movl	$8, %edx
	movl	$1, %ecx
	callq	hipMemcpy
	testl	%eax, %eax
	jne	.LBB1_16
# %bb.17:
	callq	hipDeviceSynchronize
	testl	%eax, %eax
	jne	.LBB1_18
# %bb.19:
	movabsq	$4294967552, %r12               # imm = 0x100000100
	callq	_ZNSt6chrono3_V212steady_clock3nowEv
	movq	%rax, %r15
	leaq	1698(%r12), %rdi
	movl	$1, %esi
	movq	%r12, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB1_21
# %bb.20:
	movq	24(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rsp), %rdx
	movq	%rax, 96(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rdx, 80(%rsp)
	movl	$500000, 4(%rsp)                # imm = 0x7A120
	movl	$500000, (%rsp)                 # imm = 0x7A120
	leaq	96(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	%rsp, %rax
	movq	%rax, 144(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	leaq	40(%rsp), %rdx
	leaq	32(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	leaq	112(%rsp), %r9
	movl	$_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, %edi
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	48(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB1_21:
	leaq	1698(%r12), %rdi
	movl	$1, %esi
	movq	%r12, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB1_23
# %bb.22:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	8(%rsp), %rdx
	addq	$4, %rdx
	movq	%rax, 96(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rdx, 80(%rsp)
	movl	$500000, 4(%rsp)                # imm = 0x7A120
	movl	$500000, (%rsp)                 # imm = 0x7A120
	leaq	96(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	%rsp, %rax
	movq	%rax, 144(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	leaq	40(%rsp), %rdx
	leaq	32(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	leaq	112(%rsp), %r9
	movl	$_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, %edi
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	48(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB1_23:
	callq	hipDeviceSynchronize
	testl	%eax, %eax
	jne	.LBB1_24
# %bb.25:
	callq	_ZNSt6chrono3_V212steady_clock3nowEv
	subq	%r15, %rax
	cvtsi2sd	%rax, %xmm0
	mulsd	.LCPI1_1(%rip), %xmm0
	movl	$.L.str.3, %edi
	movb	$1, %al
	callq	printf
	movq	8(%rsp), %rsi
	leaq	104(%rsp), %rdi
	movl	$8, %edx
	movl	$2, %ecx
	callq	hipMemcpy
	testl	%eax, %eax
	jne	.LBB1_26
# %bb.27:
	movq	%rbx, %rdi
	callq	free
	movq	%r14, %rdi
	callq	free
	movq	8(%rsp), %rdi
	callq	hipFree
	testl	%eax, %eax
	jne	.LBB1_28
# %bb.29:
	movq	24(%rsp), %rdi
	callq	hipFree
	testl	%eax, %eax
	jne	.LBB1_30
# %bb.31:
	movq	16(%rsp), %rdi
	callq	hipFree
	testl	%eax, %eax
	jne	.LBB1_32
# %bb.33:
	xorl	%eax, %eax
	addq	$160, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB1_5:
	.cfi_def_cfa_offset 208
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$72, %esi
	jmp	.LBB1_6
.LBB1_8:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$73, %esi
	jmp	.LBB1_6
.LBB1_10:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$74, %esi
	jmp	.LBB1_6
.LBB1_12:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$76, %esi
	jmp	.LBB1_6
.LBB1_14:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$77, %esi
	jmp	.LBB1_6
.LBB1_16:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$88, %esi
	jmp	.LBB1_6
.LBB1_18:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$90, %esi
	jmp	.LBB1_6
.LBB1_24:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$99, %esi
	jmp	.LBB1_6
.LBB1_26:
	movl	%eax, %ebp
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rbx
	movl	%ebp, %edi
	callq	hipGetErrorString
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$105, %esi
	jmp	.LBB1_6
.LBB1_28:
	movl	%eax, %ebx
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %r14
	movl	%ebx, %edi
	callq	hipGetErrorString
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$116, %esi
	jmp	.LBB1_6
.LBB1_30:
	movl	%eax, %ebx
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %r14
	movl	%ebx, %edi
	callq	hipGetErrorString
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$117, %esi
	jmp	.LBB1_6
.LBB1_32:
	movl	%eax, %ebx
	movl	$_ZSt4cerr, %edi
	movl	$.L.str, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %r14
	movl	%ebx, %edi
	callq	hipGetErrorString
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.1, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.L.str.2, %esi
	movq	%rax, %rdi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	$58, %esi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c
	movq	%rax, %rdi
	movl	$118, %esi
.LBB1_6:
	callq	_ZNSolsEi
	movq	%rax, %rdi
	callq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	movl	$-1, %edi
	callq	exit
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90                         # -- Begin function _GLOBAL__sub_I_hausdorff.hip
	.type	_GLOBAL__sub_I_hausdorff.hip,@function
_GLOBAL__sub_I_hausdorff.hip:           # @_GLOBAL__sub_I_hausdorff.hip
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	callq	_ZNSt8ios_base4InitC1Ev
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	movl	$_ZStL8__ioinit, %esi
	movl	$__dso_handle, %edx
	popq	%rax
	.cfi_def_cfa_offset 8
	jmp	__cxa_atexit                    # TAILCALL
.Lfunc_end2:
	.size	_GLOBAL__sub_I_hausdorff.hip, .Lfunc_end2-_GLOBAL__sub_I_hausdorff.hip
	.cfi_endproc
                                        # -- End function
	.text
	.p2align	4, 0x90                         # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	__hip_gpubin_handle(%rip), %rdi
	testq	%rdi, %rdi
	jne	.LBB3_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rdi
	movq	%rax, __hip_gpubin_handle(%rip)
.LBB3_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	movl	$__hip_module_dtor, %edi
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	jmp	atexit                          # TAILCALL
.Lfunc_end3:
	.size	__hip_module_ctor, .Lfunc_end3-__hip_module_ctor
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
	je	.LBB4_2
# %bb.1:
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle(%rip)
.LBB4_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	__hip_module_dtor, .Lfunc_end4-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	_ZStL8__ioinit,@object          # @_ZStL8__ioinit
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.type	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii,@object # @_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.section	.rodata,"a",@progbits
	.globl	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.p2align	3, 0x0
_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii:
	.quad	_Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.size	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, 8

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"An error encountered: \""
	.size	.L.str, 24

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"\" at "
	.size	.L.str.1, 6

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"../../src/hausdorff.hip"
	.size	.L.str.2, 24

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"%f ms\n"
	.size	.L.str.3, 7

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii"
	.size	.L__unnamed_1, 53

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
	.quad	_GLOBAL__sub_I_hausdorff.hip
	.quad	__hip_module_ctor
	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z30__device_stub__computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.addrsig_sym _GLOBAL__sub_I_hausdorff.hip
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _ZStL8__ioinit
	.addrsig_sym __dso_handle
	.addrsig_sym _Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.addrsig_sym _ZSt4cerr
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
