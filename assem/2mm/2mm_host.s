	.text
	.file	"2mm.hip"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z6absValf
.LCPI0_0:
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.text
	.globl	_Z6absValf
	.p2align	4, 0x90
	.type	_Z6absValf,@function
_Z6absValf:                             # @_Z6absValf
	.cfi_startproc
# %bb.0:
	movaps	.LCPI0_0(%rip), %xmm1           # xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	xorps	%xmm0, %xmm1
	maxss	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	retq
.Lfunc_end0:
	.size	_Z6absValf, .Lfunc_end0-_Z6absValf
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z11percentDiffdd
.LCPI1_0:
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI1_1:
	.quad	0x3f847ae147ae147b              # double 0.01
.LCPI1_2:
	.quad	0x3e45798ee0000000              # double 9.9999999392252903E-9
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI1_3:
	.long	0x42c80000                      # float 100
	.text
	.globl	_Z11percentDiffdd
	.p2align	4, 0x90
	.type	_Z11percentDiffdd,@function
_Z11percentDiffdd:                      # @_Z11percentDiffdd
	.cfi_startproc
# %bb.0:
	cvtsd2ss	%xmm0, %xmm2
	movaps	.LCPI1_0(%rip), %xmm3           # xmm3 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	xorps	%xmm2, %xmm3
	maxss	%xmm2, %xmm3
	xorps	%xmm2, %xmm2
	cvtss2sd	%xmm3, %xmm2
	movsd	.LCPI1_1(%rip), %xmm3           # xmm3 = mem[0],zero
	ucomisd	%xmm2, %xmm3
	jbe	.LBB1_2
# %bb.1:
	xorps	%xmm2, %xmm2
	cvtsd2ss	%xmm1, %xmm2
	movaps	.LCPI1_0(%rip), %xmm4           # xmm4 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	xorps	%xmm2, %xmm4
	maxss	%xmm2, %xmm4
	cvtss2sd	%xmm4, %xmm4
	xorps	%xmm2, %xmm2
	ucomisd	%xmm4, %xmm3
	ja	.LBB1_3
.LBB1_2:
	movaps	%xmm0, %xmm2
	addsd	.LCPI1_2(%rip), %xmm0
	subsd	%xmm1, %xmm2
	unpcklpd	%xmm0, %xmm2                    # xmm2 = xmm2[0],xmm0[0]
	cvtpd2ps	%xmm2, %xmm0
	movapd	.LCPI1_0(%rip), %xmm2           # xmm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	movapd	%xmm0, %xmm1
	xorpd	%xmm2, %xmm1
	maxps	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	shufps	$85, %xmm1, %xmm0               # xmm0 = xmm0[1,1],xmm1[1,1]
	divss	%xmm0, %xmm1
	xorpd	%xmm1, %xmm2
	maxss	%xmm1, %xmm2
	mulss	.LCPI1_3(%rip), %xmm2
.LBB1_3:
	movaps	%xmm2, %xmm0
	retq
.Lfunc_end1:
	.size	_Z11percentDiffdd, .Lfunc_end1-_Z11percentDiffdd
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_
.LCPI2_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
.LCPI2_1:
	.long	4                               # 0x4
	.long	4                               # 0x4
	.long	4                               # 0x4
	.long	4                               # 0x4
.LCPI2_2:
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
.LCPI2_3:
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
.LCPI2_5:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI2_6:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI2_7:
	.long	5                               # 0x5
	.long	5                               # 0x5
	.long	5                               # 0x5
	.long	5                               # 0x5
.LCPI2_8:
	.quad	8                               # 0x8
	.quad	8                               # 0x8
.LCPI2_9:
	.long	3                               # 0x3
	.long	3                               # 0x3
	.long	3                               # 0x3
	.long	3                               # 0x3
.LCPI2_10:
	.long	7                               # 0x7
	.long	7                               # 0x7
	.long	7                               # 0x7
	.long	7                               # 0x7
.LCPI2_11:
	.long	2                               # 0x2
	.long	2                               # 0x2
	.long	2                               # 0x2
	.long	2                               # 0x2
.LCPI2_12:
	.long	6                               # 0x6
	.long	6                               # 0x6
	.long	6                               # 0x6
	.long	6                               # 0x6
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI2_4:
	.long	0x3a800000                      # float 9.765625E-4
	.text
	.globl	_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_
	.p2align	4, 0x90
	.type	_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_,@function
_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_: # @_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$1191000064, (%r8)              # imm = 0x46FD3800
	movl	$1157935104, (%r9)              # imm = 0x4504B000
	testl	%edi, %edi
	jle	.LBB2_10
# %bb.1:
	testl	%edx, %edx
	jle	.LBB2_22
# %bb.2:
	movq	40(%rsp), %rax
	movl	%edi, %r8d
	movl	%edx, %r9d
	movl	%r9d, %r10d
	andl	$-8, %r10d
	leaq	16(%rax), %r11
	leaq	(,%r9,4), %rbx
	andq	$-32, %rbx
	xorl	%r14d, %r14d
	movss	.LCPI2_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movdqa	.LCPI2_0(%rip), %xmm1           # xmm1 = [0,1,2,3]
	movdqa	.LCPI2_1(%rip), %xmm2           # xmm2 = [4,4,4,4]
	movaps	.LCPI2_2(%rip), %xmm3           # xmm3 = [9.765625E-4,9.765625E-4,9.765625E-4,9.765625E-4]
	movdqa	.LCPI2_3(%rip), %xmm4           # xmm4 = [8,8,8,8]
	jmp	.LBB2_3
	.p2align	4, 0x90
.LBB2_9:                                #   in Loop: Header=BB2_3 Depth=1
	incq	%r14
	addq	$4096, %r11                     # imm = 0x1000
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	%r8, %r14
	je	.LBB2_10
.LBB2_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #     Child Loop BB2_8 Depth 2
	xorps	%xmm5, %xmm5
	cvtsi2ss	%r14d, %xmm5
	cmpl	$8, %edx
	jae	.LBB2_5
# %bb.4:                                #   in Loop: Header=BB2_3 Depth=1
	xorl	%r15d, %r15d
	jmp	.LBB2_8
	.p2align	4, 0x90
.LBB2_5:                                #   in Loop: Header=BB2_3 Depth=1
	movaps	%xmm5, %xmm6
	shufps	$0, %xmm5, %xmm6                # xmm6 = xmm6[0,0],xmm5[0,0]
	xorl	%r15d, %r15d
	movdqa	%xmm1, %xmm7
	.p2align	4, 0x90
.LBB2_6:                                #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm7, %xmm8
	paddd	%xmm2, %xmm8
	cvtdq2ps	%xmm7, %xmm9
	cvtdq2ps	%xmm8, %xmm8
	mulps	%xmm6, %xmm9
	mulps	%xmm6, %xmm8
	mulps	%xmm3, %xmm9
	mulps	%xmm3, %xmm8
	movups	%xmm9, -16(%r11,%r15)
	movups	%xmm8, (%r11,%r15)
	paddd	%xmm4, %xmm7
	addq	$32, %r15
	cmpq	%r15, %rbx
	jne	.LBB2_6
# %bb.7:                                #   in Loop: Header=BB2_3 Depth=1
	movq	%r10, %r15
	cmpq	%r9, %r10
	je	.LBB2_9
	.p2align	4, 0x90
.LBB2_8:                                #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorps	%xmm6, %xmm6
	cvtsi2ss	%r15d, %xmm6
	mulss	%xmm5, %xmm6
	mulss	%xmm0, %xmm6
	movss	%xmm6, (%rax,%r15,4)
	incq	%r15
	cmpq	%r15, %r9
	jne	.LBB2_8
	jmp	.LBB2_9
.LBB2_10:
	testl	%edx, %edx
	jle	.LBB2_20
# %bb.11:
	testl	%esi, %esi
	jle	.LBB2_20
# %bb.12:
	movq	48(%rsp), %rax
	movl	%edx, %edx
	movl	%esi, %r8d
	movl	%r8d, %r9d
	andl	$-8, %r9d
	leaq	16(%rax), %r10
	leaq	(,%r8,4), %r11
	andq	$-32, %r11
	xorl	%ebx, %ebx
	movss	.LCPI2_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movaps	.LCPI2_5(%rip), %xmm1           # xmm1 = [2,3]
	movaps	.LCPI2_6(%rip), %xmm2           # xmm2 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	pcmpeqd	%xmm3, %xmm3
	movdqa	.LCPI2_7(%rip), %xmm4           # xmm4 = [5,5,5,5]
	movaps	.LCPI2_2(%rip), %xmm5           # xmm5 = [9.765625E-4,9.765625E-4,9.765625E-4,9.765625E-4]
	movdqa	.LCPI2_8(%rip), %xmm6           # xmm6 = [8,8]
	jmp	.LBB2_13
	.p2align	4, 0x90
.LBB2_19:                               #   in Loop: Header=BB2_13 Depth=1
	incq	%rbx
	addq	$4096, %r10                     # imm = 0x1000
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	%rdx, %rbx
	je	.LBB2_20
.LBB2_13:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_16 Depth 2
                                        #     Child Loop BB2_18 Depth 2
	xorps	%xmm7, %xmm7
	cvtsi2ss	%ebx, %xmm7
	cmpl	$8, %esi
	jae	.LBB2_15
# %bb.14:                               #   in Loop: Header=BB2_13 Depth=1
	xorl	%r14d, %r14d
	jmp	.LBB2_18
	.p2align	4, 0x90
.LBB2_15:                               #   in Loop: Header=BB2_13 Depth=1
	movaps	%xmm7, %xmm8
	shufps	$0, %xmm7, %xmm8                # xmm8 = xmm8[0,0],xmm7[0,0]
	xorl	%r14d, %r14d
	movaps	%xmm2, %xmm9
	movaps	%xmm1, %xmm10
	.p2align	4, 0x90
.LBB2_16:                               #   Parent Loop BB2_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movaps	%xmm9, %xmm11
	shufps	$136, %xmm10, %xmm11            # xmm11 = xmm11[0,2],xmm10[0,2]
	movaps	%xmm11, %xmm12
	psubd	%xmm3, %xmm12
	paddd	%xmm4, %xmm11
	cvtdq2ps	%xmm12, %xmm12
	cvtdq2ps	%xmm11, %xmm11
	mulps	%xmm8, %xmm12
	mulps	%xmm8, %xmm11
	mulps	%xmm5, %xmm12
	mulps	%xmm5, %xmm11
	movups	%xmm12, -16(%r10,%r14)
	movups	%xmm11, (%r10,%r14)
	paddq	%xmm6, %xmm9
	paddq	%xmm6, %xmm10
	addq	$32, %r14
	cmpq	%r14, %r11
	jne	.LBB2_16
# %bb.17:                               #   in Loop: Header=BB2_13 Depth=1
	movq	%r9, %r14
	cmpq	%r8, %r9
	je	.LBB2_19
	.p2align	4, 0x90
.LBB2_18:                               #   Parent Loop BB2_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	1(%r14), %r15
	xorps	%xmm8, %xmm8
	cvtsi2ss	%r15d, %xmm8
	mulss	%xmm7, %xmm8
	mulss	%xmm0, %xmm8
	movss	%xmm8, (%rax,%r14,4)
	movq	%r15, %r14
	cmpq	%r15, %r8
	jne	.LBB2_18
	jmp	.LBB2_19
.LBB2_20:
	testl	%ecx, %ecx
	jle	.LBB2_41
# %bb.21:
	testl	%esi, %esi
	jg	.LBB2_24
.LBB2_32:
	testl	%edi, %edi
	jle	.LBB2_41
.LBB2_33:
	movq	64(%rsp), %rax
	movl	%edi, %edx
	movl	%ecx, %esi
	movl	%esi, %edi
	andl	$-8, %edi
	leaq	16(%rax), %r8
	leaq	(,%rsi,4), %r9
	andq	$-32, %r9
	xorl	%r10d, %r10d
	movss	.LCPI2_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movdqa	.LCPI2_0(%rip), %xmm1           # xmm1 = [0,1,2,3]
	movdqa	.LCPI2_11(%rip), %xmm2          # xmm2 = [2,2,2,2]
	movdqa	.LCPI2_12(%rip), %xmm3          # xmm3 = [6,6,6,6]
	movaps	.LCPI2_2(%rip), %xmm4           # xmm4 = [9.765625E-4,9.765625E-4,9.765625E-4,9.765625E-4]
	movdqa	.LCPI2_3(%rip), %xmm5           # xmm5 = [8,8,8,8]
	jmp	.LBB2_34
	.p2align	4, 0x90
.LBB2_40:                               #   in Loop: Header=BB2_34 Depth=1
	incq	%r10
	addq	$4096, %r8                      # imm = 0x1000
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	%rdx, %r10
	je	.LBB2_41
.LBB2_34:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_37 Depth 2
                                        #     Child Loop BB2_39 Depth 2
	xorps	%xmm6, %xmm6
	cvtsi2ss	%r10d, %xmm6
	cmpl	$8, %ecx
	jae	.LBB2_36
# %bb.35:                               #   in Loop: Header=BB2_34 Depth=1
	xorl	%r11d, %r11d
	jmp	.LBB2_39
	.p2align	4, 0x90
.LBB2_36:                               #   in Loop: Header=BB2_34 Depth=1
	movaps	%xmm6, %xmm7
	shufps	$0, %xmm6, %xmm7                # xmm7 = xmm7[0,0],xmm6[0,0]
	xorl	%r11d, %r11d
	movdqa	%xmm1, %xmm8
	.p2align	4, 0x90
.LBB2_37:                               #   Parent Loop BB2_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm8, %xmm9
	paddd	%xmm2, %xmm9
	movdqa	%xmm8, %xmm10
	paddd	%xmm3, %xmm10
	cvtdq2ps	%xmm9, %xmm9
	cvtdq2ps	%xmm10, %xmm10
	mulps	%xmm7, %xmm9
	mulps	%xmm7, %xmm10
	mulps	%xmm4, %xmm9
	mulps	%xmm4, %xmm10
	movups	%xmm9, -16(%r8,%r11)
	movups	%xmm10, (%r8,%r11)
	paddd	%xmm5, %xmm8
	addq	$32, %r11
	cmpq	%r11, %r9
	jne	.LBB2_37
# %bb.38:                               #   in Loop: Header=BB2_34 Depth=1
	movq	%rdi, %r11
	cmpq	%rsi, %rdi
	je	.LBB2_40
	.p2align	4, 0x90
.LBB2_39:                               #   Parent Loop BB2_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	2(%r11), %ebx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%ebx, %xmm7
	mulss	%xmm6, %xmm7
	mulss	%xmm0, %xmm7
	movss	%xmm7, (%rax,%r11,4)
	incq	%r11
	cmpq	%r11, %rsi
	jne	.LBB2_39
	jmp	.LBB2_40
.LBB2_22:
	testl	%ecx, %ecx
	jle	.LBB2_41
# %bb.23:
	testl	%esi, %esi
	jle	.LBB2_33
.LBB2_24:
	movq	56(%rsp), %rax
	movl	%ecx, %edx
	movl	%esi, %r8d
	movl	%r8d, %r9d
	andl	$-8, %r9d
	leaq	16(%rax), %r10
	leaq	(,%r8,4), %r11
	andq	$-32, %r11
	xorl	%ebx, %ebx
	movss	.LCPI2_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movdqa	.LCPI2_0(%rip), %xmm1           # xmm1 = [0,1,2,3]
	movdqa	.LCPI2_9(%rip), %xmm2           # xmm2 = [3,3,3,3]
	movdqa	.LCPI2_10(%rip), %xmm3          # xmm3 = [7,7,7,7]
	movaps	.LCPI2_2(%rip), %xmm4           # xmm4 = [9.765625E-4,9.765625E-4,9.765625E-4,9.765625E-4]
	movdqa	.LCPI2_3(%rip), %xmm5           # xmm5 = [8,8,8,8]
	jmp	.LBB2_25
	.p2align	4, 0x90
.LBB2_31:                               #   in Loop: Header=BB2_25 Depth=1
	incq	%rbx
	addq	$4096, %r10                     # imm = 0x1000
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	%rdx, %rbx
	je	.LBB2_32
.LBB2_25:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_28 Depth 2
                                        #     Child Loop BB2_30 Depth 2
	xorps	%xmm6, %xmm6
	cvtsi2ss	%ebx, %xmm6
	cmpl	$8, %esi
	jae	.LBB2_27
# %bb.26:                               #   in Loop: Header=BB2_25 Depth=1
	xorl	%r14d, %r14d
	jmp	.LBB2_30
	.p2align	4, 0x90
.LBB2_27:                               #   in Loop: Header=BB2_25 Depth=1
	movaps	%xmm6, %xmm7
	shufps	$0, %xmm6, %xmm7                # xmm7 = xmm7[0,0],xmm6[0,0]
	xorl	%r14d, %r14d
	movdqa	%xmm1, %xmm8
	.p2align	4, 0x90
.LBB2_28:                               #   Parent Loop BB2_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm8, %xmm9
	paddd	%xmm2, %xmm9
	movdqa	%xmm8, %xmm10
	paddd	%xmm3, %xmm10
	cvtdq2ps	%xmm9, %xmm9
	cvtdq2ps	%xmm10, %xmm10
	mulps	%xmm7, %xmm9
	mulps	%xmm7, %xmm10
	mulps	%xmm4, %xmm9
	mulps	%xmm4, %xmm10
	movups	%xmm9, -16(%r10,%r14)
	movups	%xmm10, (%r10,%r14)
	paddd	%xmm5, %xmm8
	addq	$32, %r14
	cmpq	%r14, %r11
	jne	.LBB2_28
# %bb.29:                               #   in Loop: Header=BB2_25 Depth=1
	movq	%r9, %r14
	cmpq	%r8, %r9
	je	.LBB2_31
	.p2align	4, 0x90
.LBB2_30:                               #   Parent Loop BB2_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	3(%r14), %ebp
	xorps	%xmm7, %xmm7
	cvtsi2ss	%ebp, %xmm7
	mulss	%xmm6, %xmm7
	mulss	%xmm0, %xmm7
	movss	%xmm7, (%rax,%r14,4)
	incq	%r14
	cmpq	%r14, %r8
	jne	.LBB2_30
	jmp	.LBB2_31
.LBB2_41:
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_, .Lfunc_end2-_Z10init_arrayiiiiPfS_PA1024_fS1_S1_S1_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z14compareResultsiiPA1024_fS0_
.LCPI3_0:
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
.LCPI3_1:
	.quad	0x3f847ae147ae147b              # double 0.01
	.quad	0x3f847ae147ae147b              # double 0.01
.LCPI3_2:
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
.LCPI3_3:
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
.LCPI3_4:
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI3_5:
	.quad	0x3f847ae147ae147b              # double 0.01
.LCPI3_8:
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI3_6:
	.long	0x322bcc77                      # float 9.99999993E-9
.LCPI3_7:
	.long	0x42c80000                      # float 100
	.text
	.globl	_Z14compareResultsiiPA1024_fS0_
	.p2align	4, 0x90
	.type	_Z14compareResultsiiPA1024_fS0_,@function
_Z14compareResultsiiPA1024_fS0_:        # @_Z14compareResultsiiPA1024_fS0_
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	xorl	%eax, %eax
	testl	%edi, %edi
	jle	.LBB3_13
# %bb.1:
	testl	%esi, %esi
	jle	.LBB3_13
# %bb.2:
	movl	%edi, %edi
	movl	%esi, %r8d
	movl	%r8d, %r9d
	andl	$-8, %r9d
	leaq	16(%rdx), %r10
	leaq	16(%rcx), %r11
	leaq	(,%r8,4), %rbx
	andq	$-32, %rbx
	xorl	%r14d, %r14d
	movaps	.LCPI3_0(%rip), %xmm5           # xmm5 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	movsd	.LCPI3_5(%rip), %xmm11          # xmm11 = mem[0],zero
	movsd	.LCPI3_8(%rip), %xmm7           # xmm7 = mem[0],zero
	movd	.LCPI3_6(%rip), %xmm9           # xmm9 = mem[0],zero,zero,zero
	movss	.LCPI3_7(%rip), %xmm10          # xmm10 = mem[0],zero,zero,zero
	movapd	.LCPI3_1(%rip), %xmm1           # xmm1 = [1.0E-2,1.0E-2]
	movaps	.LCPI3_3(%rip), %xmm8           # xmm8 = [1.0E+2,1.0E+2,1.0E+2,1.0E+2]
	xorl	%eax, %eax
	jmp	.LBB3_3
	.p2align	4, 0x90
.LBB3_12:                               #   in Loop: Header=BB3_3 Depth=1
	incq	%r14
	addq	$4096, %r10                     # imm = 0x1000
	addq	$4096, %r11                     # imm = 0x1000
	addq	$4096, %rdx                     # imm = 0x1000
	addq	$4096, %rcx                     # imm = 0x1000
	cmpq	%rdi, %r14
	je	.LBB3_13
.LBB3_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_6 Depth 2
                                        #     Child Loop BB3_8 Depth 2
	cmpl	$8, %esi
	jae	.LBB3_5
# %bb.4:                                #   in Loop: Header=BB3_3 Depth=1
	xorl	%r15d, %r15d
	jmp	.LBB3_8
	.p2align	4, 0x90
.LBB3_5:                                #   in Loop: Header=BB3_3 Depth=1
	movd	%eax, %xmm10
	pxor	%xmm9, %xmm9
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB3_6:                                #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-16(%r10,%rax), %xmm13
	movups	(%r10,%rax), %xmm12
	movups	-16(%r11,%rax), %xmm2
	movups	(%r11,%rax), %xmm6
	movaps	%xmm13, %xmm4
	xorps	%xmm5, %xmm4
	movaps	%xmm12, %xmm11
	xorps	%xmm5, %xmm11
	maxps	%xmm13, %xmm4
	maxps	%xmm12, %xmm11
	cvtps2pd	%xmm4, %xmm3
	movhlps	%xmm4, %xmm4                    # xmm4 = xmm4[1,1]
	movaps	%xmm2, %xmm15
	cvtps2pd	%xmm11, %xmm7
	xorps	%xmm5, %xmm15
	maxps	%xmm2, %xmm15
	cvtps2pd	%xmm4, %xmm4
	cvtps2pd	%xmm15, %xmm14
	movhlps	%xmm15, %xmm15                  # xmm15 = xmm15[1,1]
	cmpltpd	%xmm1, %xmm4
	cvtps2pd	%xmm15, %xmm15
	cmpltpd	%xmm1, %xmm15
	andpd	%xmm4, %xmm15
	movaps	%xmm6, %xmm4
	xorps	%xmm5, %xmm4
	maxps	%xmm6, %xmm4
	cmpltpd	%xmm1, %xmm3
	cmpltpd	%xmm1, %xmm14
	andpd	%xmm3, %xmm14
	cvtps2pd	%xmm4, %xmm3
	cmpltpd	%xmm1, %xmm7
	cmpltpd	%xmm1, %xmm3
	andpd	%xmm7, %xmm3
	movaps	%xmm13, %xmm7
	subps	%xmm2, %xmm7
	movaps	%xmm12, %xmm2
	subps	%xmm6, %xmm2
	movaps	%xmm7, %xmm6
	xorps	%xmm5, %xmm6
	maxps	%xmm7, %xmm6
	movaps	%xmm2, %xmm7
	xorps	%xmm5, %xmm7
	maxps	%xmm2, %xmm7
	movaps	.LCPI3_2(%rip), %xmm2           # xmm2 = [9.99999993E-9,9.99999993E-9,9.99999993E-9,9.99999993E-9]
	movapd	%xmm1, %xmm0
	movaps	%xmm2, %xmm1
	addps	%xmm2, %xmm13
	movaps	%xmm13, %xmm2
	xorps	%xmm5, %xmm2
	maxps	%xmm13, %xmm2
	addps	%xmm1, %xmm12
	movapd	%xmm0, %xmm1
	divps	%xmm2, %xmm6
	movaps	%xmm12, %xmm2
	xorps	%xmm5, %xmm2
	maxps	%xmm12, %xmm2
	movapd	.LCPI3_4(%rip), %xmm0           # xmm0 = [5.0000000000000003E-2,5.0000000000000003E-2]
	divps	%xmm2, %xmm7
	movaps	%xmm6, %xmm2
	xorps	%xmm5, %xmm2
	maxps	%xmm6, %xmm2
	movaps	%xmm7, %xmm6
	xorps	%xmm5, %xmm6
	maxps	%xmm7, %xmm6
	movhlps	%xmm11, %xmm11                  # xmm11 = xmm11[1,1]
	cvtps2pd	%xmm11, %xmm7
	movhlps	%xmm4, %xmm4                    # xmm4 = xmm4[1,1]
	cvtps2pd	%xmm4, %xmm4
	cmpltpd	%xmm1, %xmm7
	cmpltpd	%xmm1, %xmm4
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm6
	andpd	%xmm7, %xmm4
	cvtps2pd	%xmm2, %xmm7
	movhlps	%xmm2, %xmm2                    # xmm2 = xmm2[1,1]
	andnpd	%xmm7, %xmm14
	cvtps2pd	%xmm6, %xmm7
	cvtps2pd	%xmm2, %xmm2
	andnpd	%xmm2, %xmm15
	movhlps	%xmm6, %xmm6                    # xmm6 = xmm6[1,1]
	cvtps2pd	%xmm6, %xmm2
	andnpd	%xmm7, %xmm3
	andnpd	%xmm2, %xmm4
	movapd	%xmm0, %xmm2
	cmpltpd	%xmm14, %xmm2
	movapd	%xmm0, %xmm6
	cmpltpd	%xmm15, %xmm6
	packssdw	%xmm6, %xmm2
	movapd	%xmm0, %xmm6
	cmpltpd	%xmm3, %xmm6
	movapd	%xmm0, %xmm3
	cmpltpd	%xmm4, %xmm3
	psubd	%xmm2, %xmm10
	packssdw	%xmm3, %xmm6
	psubd	%xmm6, %xmm9
	addq	$32, %rax
	cmpq	%rax, %rbx
	jne	.LBB3_6
# %bb.7:                                #   in Loop: Header=BB3_3 Depth=1
	paddd	%xmm10, %xmm9
	pshufd	$238, %xmm9, %xmm2              # xmm2 = xmm9[2,3,2,3]
	paddd	%xmm9, %xmm2
	pshufd	$85, %xmm2, %xmm3               # xmm3 = xmm2[1,1,1,1]
	paddd	%xmm2, %xmm3
	movd	%xmm3, %eax
	movq	%r9, %r15
	cmpq	%r8, %r9
	movsd	.LCPI3_8(%rip), %xmm7           # xmm7 = mem[0],zero
	movd	.LCPI3_6(%rip), %xmm9           # xmm9 = mem[0],zero,zero,zero
	movss	.LCPI3_7(%rip), %xmm10          # xmm10 = mem[0],zero,zero,zero
	movsd	.LCPI3_5(%rip), %xmm11          # xmm11 = mem[0],zero
	jne	.LBB3_8
	jmp	.LBB3_12
	.p2align	4, 0x90
.LBB3_10:                               #   in Loop: Header=BB3_8 Depth=2
	movaps	%xmm2, %xmm4
	subss	%xmm3, %xmm4
	movaps	%xmm4, %xmm3
	xorps	%xmm5, %xmm3
	maxss	%xmm4, %xmm3
	addss	%xmm9, %xmm2
	movaps	%xmm2, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm2, %xmm4
	divss	%xmm4, %xmm3
	movaps	%xmm3, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm3, %xmm4
	mulss	%xmm10, %xmm4
.LBB3_11:                               #   in Loop: Header=BB3_8 Depth=2
	xorps	%xmm2, %xmm2
	cvtss2sd	%xmm4, %xmm2
	xorl	%ebp, %ebp
	ucomisd	%xmm7, %xmm2
	seta	%bpl
	addl	%ebp, %eax
	incq	%r15
	cmpq	%r15, %r8
	je	.LBB3_12
.LBB3_8:                                #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movss	(%rdx,%r15,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
	movss	(%rcx,%r15,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	movaps	%xmm2, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm2, %xmm4
	cvtss2sd	%xmm4, %xmm4
	ucomisd	%xmm4, %xmm11
	jbe	.LBB3_10
# %bb.9:                                #   in Loop: Header=BB3_8 Depth=2
	movaps	%xmm3, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm3, %xmm4
	xorps	%xmm6, %xmm6
	cvtss2sd	%xmm4, %xmm6
	xorps	%xmm4, %xmm4
	ucomisd	%xmm6, %xmm11
	jbe	.LBB3_10
	jmp	.LBB3_11
.LBB3_13:
	movsd	.LCPI3_8(%rip), %xmm0           # xmm0 = mem[0],zero
	movl	$.L.str, %edi
	movl	%eax, %esi
	movb	$1, %al
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	printf                          # TAILCALL
.Lfunc_end3:
	.size	_Z14compareResultsiiPA1024_fS0_, .Lfunc_end3-_Z14compareResultsiiPA1024_fS0_
	.cfi_endproc
                                        # -- End function
	.globl	_Z13GPU_argv_initv              # -- Begin function _Z13GPU_argv_initv
	.p2align	4, 0x90
	.type	_Z13GPU_argv_initv,@function
_Z13GPU_argv_initv:                     # @_Z13GPU_argv_initv
	.cfi_startproc
# %bb.0:
	subq	$792, %rsp                      # imm = 0x318
	.cfi_def_cfa_offset 800
	movq	%rsp, %rdi
	xorl	%esi, %esi
	callq	hipGetDeviceProperties
	xorl	%edi, %edi
	callq	hipSetDevice
	addq	$792, %rsp                      # imm = 0x318
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	_Z13GPU_argv_initv, .Lfunc_end4-_Z13GPU_argv_initv
	.cfi_endproc
                                        # -- End function
	.globl	_Z26__device_stub__mm2_kernel1iiiiffPfS_S_ # -- Begin function _Z26__device_stub__mm2_kernel1iiiiffPfS_S_
	.p2align	4, 0x90
	.type	_Z26__device_stub__mm2_kernel1iiiiffPfS_S_,@function
_Z26__device_stub__mm2_kernel1iiiiffPfS_S_: # @_Z26__device_stub__mm2_kernel1iiiiffPfS_S_
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movl	%edi, 28(%rsp)
	movl	%esi, 24(%rsp)
	movl	%edx, 20(%rsp)
	movl	%ecx, 16(%rsp)
	movss	%xmm0, 12(%rsp)
	movss	%xmm1, 8(%rsp)
	movq	%r8, 88(%rsp)
	movq	%r9, 80(%rsp)
	leaq	28(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	leaq	40(%rsp), %rdx
	leaq	32(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	leaq	96(%rsp), %r9
	movl	$_Z11mm2_kernel1iiiiffPfS_S_, %edi
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	48(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end5:
	.size	_Z26__device_stub__mm2_kernel1iiiiffPfS_S_, .Lfunc_end5-_Z26__device_stub__mm2_kernel1iiiiffPfS_S_
	.cfi_endproc
                                        # -- End function
	.globl	_Z26__device_stub__mm2_kernel2iiiiffPfS_S_ # -- Begin function _Z26__device_stub__mm2_kernel2iiiiffPfS_S_
	.p2align	4, 0x90
	.type	_Z26__device_stub__mm2_kernel2iiiiffPfS_S_,@function
_Z26__device_stub__mm2_kernel2iiiiffPfS_S_: # @_Z26__device_stub__mm2_kernel2iiiiffPfS_S_
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movl	%edi, 28(%rsp)
	movl	%esi, 24(%rsp)
	movl	%edx, 20(%rsp)
	movl	%ecx, 16(%rsp)
	movss	%xmm0, 12(%rsp)
	movss	%xmm1, 8(%rsp)
	movq	%r8, 88(%rsp)
	movq	%r9, 80(%rsp)
	leaq	28(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	leaq	40(%rsp), %rdx
	leaq	32(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	leaq	96(%rsp), %r9
	movl	$_Z11mm2_kernel2iiiiffPfS_S_, %edi
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	48(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end6:
	.size	_Z26__device_stub__mm2_kernel2iiiiffPfS_S_, .Lfunc_end6-_Z26__device_stub__mm2_kernel2iiiiffPfS_S_
	.cfi_endproc
                                        # -- End function
	.globl	_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_ # -- Begin function _Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_
	.p2align	4, 0x90
	.type	_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_,@function
_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_:   # @_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	testl	%edi, %edi
	jle	.LBB7_41
# %bb.1:
	movq	%r8, %rbx
	movl	%esi, %ebp
	testl	%esi, %esi
	jle	.LBB7_21
# %bb.2:
	testl	%edx, %edx
	movaps	%xmm1, 32(%rsp)                 # 16-byte Spill
	movl	%ecx, 28(%rsp)                  # 4-byte Spill
	movl	%edi, 24(%rsp)                  # 4-byte Spill
	jle	.LBB7_3
# %bb.5:
	movq	112(%rsp), %rax
	movl	%edi, %ecx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movl	%ebp, %esi
	movl	%edx, %edi
	movl	%edi, %r8d
	andl	$-2, %r8d
	leaq	4(%r9), %r10
	addq	$4096, %rax                     # imm = 0x1000
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	jmp	.LBB7_6
	.p2align	4, 0x90
.LBB7_14:                               #   in Loop: Header=BB7_6 Depth=1
	incq	%rcx
	addq	$4096, %r10                     # imm = 0x1000
	cmpq	8(%rsp), %rcx                   # 8-byte Folded Reload
	je	.LBB7_20
.LBB7_6:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_7 Depth 2
                                        #       Child Loop BB7_10 Depth 3
	movq	16(%rsp), %rax                  # 8-byte Reload
	xorl	%r12d, %r12d
	jmp	.LBB7_7
	.p2align	4, 0x90
.LBB7_13:                               #   in Loop: Header=BB7_7 Depth=2
	incq	%r12
	addq	$4, %rax
	cmpq	%rsi, %r12
	je	.LBB7_14
.LBB7_7:                                #   Parent Loop BB7_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_10 Depth 3
	movq	%rcx, %r14
	shlq	$12, %r14
	leaq	(%rbx,%r14), %r11
	leaq	(%r11,%r12,4), %r13
	movl	$0, (%r11,%r12,4)
	xorps	%xmm1, %xmm1
	cmpl	$1, %edx
	jne	.LBB7_9
# %bb.8:                                #   in Loop: Header=BB7_7 Depth=2
	xorl	%r11d, %r11d
	jmp	.LBB7_11
	.p2align	4, 0x90
.LBB7_9:                                #   in Loop: Header=BB7_7 Depth=2
	movq	%rax, %r15
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB7_10:                               #   Parent Loop BB7_6 Depth=1
                                        #     Parent Loop BB7_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	-4(%r10,%r11,4), %xmm2          # xmm2 = mem[0],zero,zero,zero
	mulss	%xmm0, %xmm2
	mulss	-4096(%r15), %xmm2
	addss	%xmm1, %xmm2
	movss	%xmm2, (%r13)
	movss	(%r10,%r11,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm0, %xmm1
	mulss	(%r15), %xmm1
	addss	%xmm2, %xmm1
	movss	%xmm1, (%r13)
	addq	$2, %r11
	addq	$8192, %r15                     # imm = 0x2000
	cmpq	%r11, %r8
	jne	.LBB7_10
.LBB7_11:                               #   in Loop: Header=BB7_7 Depth=2
	testb	$1, %dil
	je	.LBB7_13
# %bb.12:                               #   in Loop: Header=BB7_7 Depth=2
	addq	%r9, %r14
	movss	(%r14,%r11,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
	mulss	%xmm0, %xmm2
	shlq	$12, %r11
	addq	112(%rsp), %r11
	mulss	(%r11,%r12,4), %xmm2
	addss	%xmm2, %xmm1
	movss	%xmm1, (%r13)
	jmp	.LBB7_13
.LBB7_3:
	movl	%ebp, %r12d
	shlq	$2, %r12
	movl	%edi, %r15d
	movq	%r15, 8(%rsp)                   # 8-byte Spill
                                        # kill: def $r15d killed $r15d killed $r15 def $r15
	andl	$7, %r15d
	cmpl	$8, %edi
	jae	.LBB7_15
# %bb.4:
	xorl	%r14d, %r14d
	jmp	.LBB7_17
.LBB7_15:
	movq	8(%rsp), %rax                   # 8-byte Reload
	andl	$-8, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	28672(%rbx), %r13
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB7_16:                               # =>This Inner Loop Header: Depth=1
	leaq	-28672(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-24576(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-20480(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-16384(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-12288(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-8192(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	leaq	-4096(%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	movq	%r13, %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	addq	$8, %r14
	addq	$32768, %r13                    # imm = 0x8000
	cmpq	%r14, 8(%rsp)                   # 8-byte Folded Reload
	jne	.LBB7_16
.LBB7_17:
	testq	%r15, %r15
	je	.LBB7_20
# %bb.18:
	shlq	$12, %r14
	addq	%rbx, %r14
	shlq	$12, %r15
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB7_19:                               # =>This Inner Loop Header: Depth=1
	leaq	(%r14,%r13), %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	addq	$4096, %r13                     # imm = 0x1000
	cmpq	%r13, %r15
	jne	.LBB7_19
.LBB7_20:
	movl	24(%rsp), %edi                  # 4-byte Reload
	testl	%edi, %edi
	movaps	32(%rsp), %xmm1                 # 16-byte Reload
	movl	28(%rsp), %ecx                  # 4-byte Reload
	jle	.LBB7_41
.LBB7_21:
	testl	%ecx, %ecx
	jle	.LBB7_41
# %bb.22:
	movq	128(%rsp), %rax
	movl	%edi, %edx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movl	%ecx, %edx
	testl	%ebp, %ebp
	jle	.LBB7_23
# %bb.26:
	movq	120(%rsp), %rsi
	movl	%ebp, %edi
	movl	%edi, %r8d
	andl	$-2, %r8d
	leaq	4(%rbx), %r9
	leaq	4096(%rsi), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	xorl	%r11d, %r11d
	jmp	.LBB7_27
	.p2align	4, 0x90
.LBB7_35:                               #   in Loop: Header=BB7_27 Depth=1
	incq	%r11
	addq	$4096, %r9                      # imm = 0x1000
	cmpq	8(%rsp), %r11                   # 8-byte Folded Reload
	je	.LBB7_41
.LBB7_27:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_28 Depth 2
                                        #       Child Loop BB7_31 Depth 3
	movq	16(%rsp), %r10                  # 8-byte Reload
	xorl	%r15d, %r15d
	jmp	.LBB7_28
	.p2align	4, 0x90
.LBB7_34:                               #   in Loop: Header=BB7_28 Depth=2
	incq	%r15
	addq	$4, %r10
	cmpq	%rdx, %r15
	je	.LBB7_35
.LBB7_28:                               #   Parent Loop BB7_27 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_31 Depth 3
	movq	%r11, %r13
	shlq	$12, %r13
	leaq	(%rax,%r13), %rcx
	leaq	(%rcx,%r15,4), %r12
	movss	(%rcx,%r15,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%rcx,%r15,4)
	cmpl	$1, %ebp
	jne	.LBB7_30
# %bb.29:                               #   in Loop: Header=BB7_28 Depth=2
	xorl	%ecx, %ecx
	jmp	.LBB7_32
	.p2align	4, 0x90
.LBB7_30:                               #   in Loop: Header=BB7_28 Depth=2
	movq	%r10, %r14
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB7_31:                               #   Parent Loop BB7_27 Depth=1
                                        #     Parent Loop BB7_28 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	-4(%r9,%rcx,4), %xmm2           # xmm2 = mem[0],zero,zero,zero
	mulss	-4096(%r14), %xmm2
	addss	%xmm0, %xmm2
	movss	%xmm2, (%r12)
	movss	(%r9,%rcx,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
	mulss	(%r14), %xmm0
	addss	%xmm2, %xmm0
	movss	%xmm0, (%r12)
	addq	$2, %rcx
	addq	$8192, %r14                     # imm = 0x2000
	cmpq	%rcx, %r8
	jne	.LBB7_31
.LBB7_32:                               #   in Loop: Header=BB7_28 Depth=2
	testb	$1, %dil
	je	.LBB7_34
# %bb.33:                               #   in Loop: Header=BB7_28 Depth=2
	addq	%rbx, %r13
	movss	(%r13,%rcx,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
	shlq	$12, %rcx
	addq	%rsi, %rcx
	mulss	(%rcx,%r15,4), %xmm2
	addss	%xmm2, %xmm0
	movss	%xmm0, (%r12)
	jmp	.LBB7_34
.LBB7_23:
	movl	%edx, %esi
	andl	$-8, %esi
	movaps	%xmm1, %xmm0
	shufps	$0, %xmm1, %xmm0                # xmm0 = xmm0[0,0],xmm1[0,0]
	leaq	16(%rax), %rdi
	leaq	(,%rdx,4), %r8
	andq	$-32, %r8
	xorl	%r9d, %r9d
	jmp	.LBB7_24
	.p2align	4, 0x90
.LBB7_40:                               #   in Loop: Header=BB7_24 Depth=1
	incq	%r9
	addq	$4096, %rdi                     # imm = 0x1000
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	8(%rsp), %r9                    # 8-byte Folded Reload
	je	.LBB7_41
.LBB7_24:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_37 Depth 2
                                        #     Child Loop BB7_39 Depth 2
	cmpl	$8, %ecx
	jae	.LBB7_36
# %bb.25:                               #   in Loop: Header=BB7_24 Depth=1
	xorl	%r10d, %r10d
	jmp	.LBB7_39
	.p2align	4, 0x90
.LBB7_36:                               #   in Loop: Header=BB7_24 Depth=1
	movaps	%xmm1, %xmm3
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB7_37:                               #   Parent Loop BB7_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-16(%rdi,%r10), %xmm1
	movups	(%rdi,%r10), %xmm2
	mulps	%xmm0, %xmm1
	mulps	%xmm0, %xmm2
	movups	%xmm1, -16(%rdi,%r10)
	movups	%xmm2, (%rdi,%r10)
	addq	$32, %r10
	cmpq	%r10, %r8
	jne	.LBB7_37
# %bb.38:                               #   in Loop: Header=BB7_24 Depth=1
	movq	%rsi, %r10
	cmpq	%rdx, %rsi
	movaps	%xmm3, %xmm1
	je	.LBB7_40
	.p2align	4, 0x90
.LBB7_39:                               #   Parent Loop BB7_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movss	(%rax,%r10,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm2
	movss	%xmm2, (%rax,%r10,4)
	incq	%r10
	cmpq	%r10, %rdx
	jne	.LBB7_39
	jmp	.LBB7_40
.LBB7_41:
	addq	$56, %rsp
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
.Lfunc_end7:
	.size	_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_, .Lfunc_end7-_Z7mm2_cpuiiiiffPA1024_fS0_S0_S0_S0_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_
.LCPI8_0:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
.LCPI8_1:
	.quad	0x408f400000000000              # double 1000
	.text
	.globl	_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_
	.p2align	4, 0x90
	.type	_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_,@function
_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_: # @_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_
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
	subq	$232, %rsp
	.cfi_def_cfa_offset 288
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%r9, %rbx
	movq	%r8, %r14
	movss	%xmm1, 44(%rsp)                 # 4-byte Spill
	movss	%xmm0, 40(%rsp)                 # 4-byte Spill
	movl	%ecx, 36(%rsp)                  # 4-byte Spill
	movl	%edx, 32(%rsp)                  # 4-byte Spill
	movl	%esi, 28(%rsp)                  # 4-byte Spill
	movl	%edi, 24(%rsp)                  # 4-byte Spill
	movq	296(%rsp), %r13
	movq	288(%rsp), %rbp
	movabsq	$549755813920, %r12             # imm = 0x8000000020
	movabsq	$34359738400, %r15              # imm = 0x800000020
	leaq	56(%rsp), %rdi
	movl	$4194304, %esi                  # imm = 0x400000
	callq	hipMalloc
	leaq	80(%rsp), %rdi
	movl	$4194304, %esi                  # imm = 0x400000
	callq	hipMalloc
	leaq	72(%rsp), %rdi
	movl	$4194304, %esi                  # imm = 0x400000
	callq	hipMalloc
	leaq	64(%rsp), %rdi
	movl	$4194304, %esi                  # imm = 0x400000
	callq	hipMalloc
	leaq	48(%rsp), %rdi
	movl	$4194304, %esi                  # imm = 0x400000
	callq	hipMalloc
	movq	56(%rsp), %rdi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	%r14, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	80(%rsp), %rdi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	72(%rsp), %rdi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	%rbp, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	64(%rsp), %rdi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	%r13, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	48(%rsp), %rdi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	304(%rsp), %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	callq	_Z21polybench_timer_startv
	movq	%r12, %rdi
	movl	$1, %esi
	movq	%r15, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB8_2
# %bb.1:
	movq	56(%rsp), %rax
	movq	80(%rsp), %rcx
	movq	72(%rsp), %rdx
	movl	24(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 20(%rsp)
	movl	28(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 16(%rsp)
	movl	32(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 12(%rsp)
	movl	36(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 8(%rsp)
	movss	40(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 4(%rsp)
	movss	44(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, (%rsp)
	movq	%rax, 152(%rsp)
	movq	%rcx, 144(%rsp)
	movq	%rdx, 136(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 184(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	%rsp, %rax
	movq	%rax, 200(%rsp)
	leaq	152(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 216(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	120(%rsp), %rdi
	leaq	104(%rsp), %rsi
	leaq	96(%rsp), %rdx
	leaq	88(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	120(%rsp), %rsi
	movl	128(%rsp), %edx
	movq	104(%rsp), %rcx
	movl	112(%rsp), %r8d
	leaq	160(%rsp), %r9
	movl	$_Z11mm2_kernel1iiiiffPfS_S_, %edi
	pushq	88(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	104(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB8_2:
	callq	hipDeviceSynchronize
	movq	%r12, %rdi
	movl	$1, %esi
	movq	%r15, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB8_4
# %bb.3:
	movq	56(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	48(%rsp), %rdx
	movl	24(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 20(%rsp)
	movl	28(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 16(%rsp)
	movl	32(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 12(%rsp)
	movl	36(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 8(%rsp)
	movss	40(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 4(%rsp)
	movss	44(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, (%rsp)
	movq	%rax, 152(%rsp)
	movq	%rcx, 144(%rsp)
	movq	%rdx, 136(%rsp)
	leaq	20(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 184(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	%rsp, %rax
	movq	%rax, 200(%rsp)
	leaq	152(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 216(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	120(%rsp), %rdi
	leaq	104(%rsp), %rsi
	leaq	96(%rsp), %rdx
	leaq	88(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	120(%rsp), %rsi
	movl	128(%rsp), %edx
	movq	104(%rsp), %rcx
	movl	112(%rsp), %r8d
	leaq	160(%rsp), %r9
	movl	$_Z11mm2_kernel2iiiiffPfS_S_, %edi
	pushq	88(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	104(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB8_4:
	movq	312(%rsp), %rbx
	callq	hipDeviceSynchronize
	leaq	160(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday
	testl	%eax, %eax
	je	.LBB8_6
# %bb.5:
	movl	$.L.str.4, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
.LBB8_6:
	cvtsi2sdq	160(%rsp), %xmm1
	xorps	%xmm0, %xmm0
	cvtsi2sdq	168(%rsp), %xmm0
	mulsd	.LCPI8_0(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, polybench_t_end(%rip)
	subsd	polybench_t_start(%rip), %xmm0
	mulsd	.LCPI8_1(%rip), %xmm0
	movl	$.L.str.3, %edi
	movb	$1, %al
	callq	printf
	movq	48(%rsp), %rsi
	movl	$4194304, %edx                  # imm = 0x400000
	movq	%rbx, %rdi
	movl	$2, %ecx
	callq	hipMemcpy
	movq	56(%rsp), %rdi
	callq	hipFree
	movq	80(%rsp), %rdi
	callq	hipFree
	movq	72(%rsp), %rdi
	callq	hipFree
	movq	64(%rsp), %rdi
	callq	hipFree
	movq	48(%rsp), %rdi
	callq	hipFree
	addq	$232, %rsp
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
.Lfunc_end8:
	.size	_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_, .Lfunc_end8-_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_timer_startv
.LCPI9_0:
	.quad	0x4024000000000000              # double 10
.LCPI9_1:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
	.text
	.globl	_Z21polybench_timer_startv
	.p2align	4, 0x90
	.type	_Z21polybench_timer_startv,@function
_Z21polybench_timer_startv:             # @_Z21polybench_timer_startv
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$4194560, %edi                  # imm = 0x400100
	movl	$8, %esi
	callq	calloc
	xorpd	%xmm0, %xmm0
	movl	$7, %ecx
	.p2align	4, 0x90
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	addsd	-56(%rax,%rcx,8), %xmm0
	addsd	-48(%rax,%rcx,8), %xmm0
	addsd	-40(%rax,%rcx,8), %xmm0
	addsd	-32(%rax,%rcx,8), %xmm0
	addsd	-24(%rax,%rcx,8), %xmm0
	addsd	-16(%rax,%rcx,8), %xmm0
	addsd	-8(%rax,%rcx,8), %xmm0
	addsd	(%rax,%rcx,8), %xmm0
	addq	$8, %rcx
	cmpq	$4194567, %rcx                  # imm = 0x400107
	jne	.LBB9_1
# %bb.2:
	movsd	.LCPI9_0(%rip), %xmm1           # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB9_6
# %bb.3:
	movq	%rax, %rdi
	callq	free
	leaq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday
	testl	%eax, %eax
	je	.LBB9_5
# %bb.4:
	movl	$.L.str.4, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
.LBB9_5:
	xorps	%xmm0, %xmm0
	cvtsi2sdq	8(%rsp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdq	16(%rsp), %xmm1
	mulsd	.LCPI9_1(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, polybench_t_start(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB9_6:
	.cfi_def_cfa_offset 32
	movl	$.L.str.1, %edi
	movl	$.L.str.2, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end9:
	.size	_Z21polybench_timer_startv, .Lfunc_end9-_Z21polybench_timer_startv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z20polybench_timer_stopv
.LCPI10_0:
	.quad	0x3eb0c6f7a0b5ed8d              # double 9.9999999999999995E-7
	.text
	.globl	_Z20polybench_timer_stopv
	.p2align	4, 0x90
	.type	_Z20polybench_timer_stopv,@function
_Z20polybench_timer_stopv:              # @_Z20polybench_timer_stopv
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	leaq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday
	testl	%eax, %eax
	je	.LBB10_2
# %bb.1:
	movl	$.L.str.4, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
.LBB10_2:
	cvtsi2sdq	8(%rsp), %xmm0
	cvtsi2sdq	16(%rsp), %xmm1
	mulsd	.LCPI10_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, polybench_t_end(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	_Z20polybench_timer_stopv, .Lfunc_end10-_Z20polybench_timer_stopv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_timer_printv
.LCPI11_0:
	.quad	0x408f400000000000              # double 1000
	.text
	.globl	_Z21polybench_timer_printv
	.p2align	4, 0x90
	.type	_Z21polybench_timer_printv,@function
_Z21polybench_timer_printv:             # @_Z21polybench_timer_printv
	.cfi_startproc
# %bb.0:
	movsd	polybench_t_end(%rip), %xmm0    # xmm0 = mem[0],zero
	subsd	polybench_t_start(%rip), %xmm0
	mulsd	.LCPI11_0(%rip), %xmm0
	movl	$.L.str.3, %edi
	movb	$1, %al
	jmp	printf                          # TAILCALL
.Lfunc_end11:
	.size	_Z21polybench_timer_printv, .Lfunc_end11-_Z21polybench_timer_printv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function main
.LCPI12_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
.LCPI12_1:
	.long	4                               # 0x4
	.long	4                               # 0x4
	.long	4                               # 0x4
	.long	4                               # 0x4
.LCPI12_2:
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
	.long	0x3a800000                      # float 9.765625E-4
.LCPI12_3:
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
.LCPI12_4:
	.long	12                              # 0xc
	.long	12                              # 0xc
	.long	12                              # 0xc
	.long	12                              # 0xc
.LCPI12_5:
	.long	16                              # 0x10
	.long	16                              # 0x10
	.long	16                              # 0x10
	.long	16                              # 0x10
.LCPI12_6:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI12_7:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI12_8:
	.long	5                               # 0x5
	.long	5                               # 0x5
	.long	5                               # 0x5
	.long	5                               # 0x5
.LCPI12_9:
	.quad	8                               # 0x8
	.quad	8                               # 0x8
.LCPI12_10:
	.long	3                               # 0x3
	.long	3                               # 0x3
	.long	3                               # 0x3
	.long	3                               # 0x3
.LCPI12_11:
	.long	7                               # 0x7
	.long	7                               # 0x7
	.long	7                               # 0x7
	.long	7                               # 0x7
.LCPI12_12:
	.long	2                               # 0x2
	.long	2                               # 0x2
	.long	2                               # 0x2
	.long	2                               # 0x2
.LCPI12_13:
	.long	6                               # 0x6
	.long	6                               # 0x6
	.long	6                               # 0x6
	.long	6                               # 0x6
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI12_14:
	.long	0x46fd3800                      # float 32412
.LCPI12_15:
	.long	0x4504b000                      # float 2123
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
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$792, %rsp                      # imm = 0x318
	.cfi_def_cfa_offset 848
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB12_29
# %bb.1:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.2:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %r14
	testq	%r14, %r14
	je	.LBB12_29
# %bb.3:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.4:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %r15
	testq	%r15, %r15
	je	.LBB12_29
# %bb.5:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.6:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %r12
	testq	%r12, %r12
	je	.LBB12_29
# %bb.7:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.8:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %r13
	testq	%r13, %r13
	je	.LBB12_29
# %bb.9:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.10:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4194304, %edx                  # imm = 0x400000
	callq	posix_memalign
	movq	(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB12_29
# %bb.11:
	testl	%eax, %eax
	jne	.LBB12_29
# %bb.12:
	leaq	48(%r14), %rax
	xorl	%ecx, %ecx
	movdqa	.LCPI12_0(%rip), %xmm2          # xmm2 = [0,1,2,3]
	movdqa	.LCPI12_1(%rip), %xmm3          # xmm3 = [4,4,4,4]
	movaps	.LCPI12_2(%rip), %xmm0          # xmm0 = [9.765625E-4,9.765625E-4,9.765625E-4,9.765625E-4]
	movdqa	.LCPI12_3(%rip), %xmm1          # xmm1 = [8,8,8,8]
	movdqa	.LCPI12_4(%rip), %xmm4          # xmm4 = [12,12,12,12]
	movdqa	.LCPI12_5(%rip), %xmm5          # xmm5 = [16,16,16,16]
	.p2align	4, 0x90
.LBB12_13:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_14 Depth 2
	xorps	%xmm6, %xmm6
	cvtsi2ss	%ecx, %xmm6
	shufps	$0, %xmm6, %xmm6                # xmm6 = xmm6[0,0,0,0]
	xorl	%edx, %edx
	movdqa	%xmm2, %xmm7
	.p2align	4, 0x90
.LBB12_14:                              #   Parent Loop BB12_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm7, %xmm8
	paddd	%xmm3, %xmm8
	cvtdq2ps	%xmm7, %xmm9
	cvtdq2ps	%xmm8, %xmm8
	mulps	%xmm6, %xmm9
	mulps	%xmm6, %xmm8
	mulps	%xmm0, %xmm9
	mulps	%xmm0, %xmm8
	movups	%xmm9, -48(%rax,%rdx,4)
	movups	%xmm8, -32(%rax,%rdx,4)
	movdqa	%xmm7, %xmm8
	paddd	%xmm1, %xmm8
	movdqa	%xmm7, %xmm9
	paddd	%xmm4, %xmm9
	cvtdq2ps	%xmm8, %xmm8
	cvtdq2ps	%xmm9, %xmm9
	mulps	%xmm6, %xmm8
	mulps	%xmm6, %xmm9
	mulps	%xmm0, %xmm8
	mulps	%xmm0, %xmm9
	movups	%xmm8, -16(%rax,%rdx,4)
	movups	%xmm9, (%rax,%rdx,4)
	addq	$16, %rdx
	paddd	%xmm5, %xmm7
	cmpq	$1024, %rdx                     # imm = 0x400
	jne	.LBB12_14
# %bb.15:                               #   in Loop: Header=BB12_13 Depth=1
	incq	%rcx
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	$1024, %rcx                     # imm = 0x400
	jne	.LBB12_13
# %bb.16:
	leaq	16(%r15), %rax
	xorl	%ecx, %ecx
	movaps	.LCPI12_6(%rip), %xmm2          # xmm2 = [2,3]
	movaps	.LCPI12_7(%rip), %xmm3          # xmm3 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	pcmpeqd	%xmm4, %xmm4
	movdqa	.LCPI12_8(%rip), %xmm5          # xmm5 = [5,5,5,5]
	movdqa	.LCPI12_9(%rip), %xmm6          # xmm6 = [8,8]
	.p2align	4, 0x90
.LBB12_17:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_18 Depth 2
	xorps	%xmm7, %xmm7
	cvtsi2ss	%ecx, %xmm7
	shufps	$0, %xmm7, %xmm7                # xmm7 = xmm7[0,0,0,0]
	xorl	%edx, %edx
	movaps	%xmm3, %xmm8
	movaps	%xmm2, %xmm9
	.p2align	4, 0x90
.LBB12_18:                              #   Parent Loop BB12_17 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movaps	%xmm8, %xmm10
	shufps	$136, %xmm9, %xmm10             # xmm10 = xmm10[0,2],xmm9[0,2]
	movaps	%xmm10, %xmm11
	psubd	%xmm4, %xmm11
	paddd	%xmm5, %xmm10
	cvtdq2ps	%xmm11, %xmm11
	cvtdq2ps	%xmm10, %xmm10
	mulps	%xmm7, %xmm11
	mulps	%xmm7, %xmm10
	mulps	%xmm0, %xmm11
	mulps	%xmm0, %xmm10
	movups	%xmm11, -16(%rax,%rdx,4)
	movups	%xmm10, (%rax,%rdx,4)
	addq	$8, %rdx
	paddq	%xmm6, %xmm8
	paddq	%xmm6, %xmm9
	cmpq	$1024, %rdx                     # imm = 0x400
	jne	.LBB12_18
# %bb.19:                               #   in Loop: Header=BB12_17 Depth=1
	incq	%rcx
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	$1024, %rcx                     # imm = 0x400
	jne	.LBB12_17
# %bb.20:
	leaq	16(%r12), %rax
	xorl	%ecx, %ecx
	movdqa	.LCPI12_0(%rip), %xmm2          # xmm2 = [0,1,2,3]
	movdqa	.LCPI12_10(%rip), %xmm3         # xmm3 = [3,3,3,3]
	movdqa	.LCPI12_11(%rip), %xmm4         # xmm4 = [7,7,7,7]
	.p2align	4, 0x90
.LBB12_21:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_22 Depth 2
	xorps	%xmm5, %xmm5
	cvtsi2ss	%ecx, %xmm5
	shufps	$0, %xmm5, %xmm5                # xmm5 = xmm5[0,0,0,0]
	xorl	%edx, %edx
	movdqa	%xmm2, %xmm6
	.p2align	4, 0x90
.LBB12_22:                              #   Parent Loop BB12_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm6, %xmm7
	paddd	%xmm3, %xmm7
	movdqa	%xmm6, %xmm8
	paddd	%xmm4, %xmm8
	cvtdq2ps	%xmm7, %xmm7
	cvtdq2ps	%xmm8, %xmm8
	mulps	%xmm5, %xmm7
	mulps	%xmm5, %xmm8
	mulps	%xmm0, %xmm7
	mulps	%xmm0, %xmm8
	movups	%xmm7, -16(%rax,%rdx,4)
	movups	%xmm8, (%rax,%rdx,4)
	addq	$8, %rdx
	paddd	%xmm1, %xmm6
	cmpq	$1024, %rdx                     # imm = 0x400
	jne	.LBB12_22
# %bb.23:                               #   in Loop: Header=BB12_21 Depth=1
	incq	%rcx
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	$1024, %rcx                     # imm = 0x400
	jne	.LBB12_21
# %bb.24:
	leaq	16(%r13), %rax
	xorl	%ecx, %ecx
	movdqa	.LCPI12_0(%rip), %xmm2          # xmm2 = [0,1,2,3]
	movdqa	.LCPI12_12(%rip), %xmm3         # xmm3 = [2,2,2,2]
	movdqa	.LCPI12_13(%rip), %xmm4         # xmm4 = [6,6,6,6]
	.p2align	4, 0x90
.LBB12_25:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_26 Depth 2
	xorps	%xmm5, %xmm5
	cvtsi2ss	%ecx, %xmm5
	shufps	$0, %xmm5, %xmm5                # xmm5 = xmm5[0,0,0,0]
	xorl	%edx, %edx
	movdqa	%xmm2, %xmm6
	.p2align	4, 0x90
.LBB12_26:                              #   Parent Loop BB12_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm6, %xmm7
	paddd	%xmm3, %xmm7
	movdqa	%xmm6, %xmm8
	paddd	%xmm4, %xmm8
	cvtdq2ps	%xmm7, %xmm7
	cvtdq2ps	%xmm8, %xmm8
	mulps	%xmm5, %xmm7
	mulps	%xmm5, %xmm8
	mulps	%xmm0, %xmm7
	mulps	%xmm0, %xmm8
	movups	%xmm7, -16(%rax,%rdx,4)
	movups	%xmm8, (%rax,%rdx,4)
	addq	$8, %rdx
	paddd	%xmm1, %xmm6
	cmpq	$1024, %rdx                     # imm = 0x400
	jne	.LBB12_26
# %bb.27:                               #   in Loop: Header=BB12_25 Depth=1
	incq	%rcx
	addq	$4096, %rax                     # imm = 0x1000
	cmpq	$1024, %rcx                     # imm = 0x400
	jne	.LBB12_25
# %bb.28:
	movq	%rsp, %rdi
	xorl	%esi, %esi
	callq	hipGetDeviceProperties
	xorl	%edi, %edi
	callq	hipSetDevice
	movss	.LCPI12_14(%rip), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI12_15(%rip), %xmm1         # xmm1 = mem[0],zero,zero,zero
	movl	$1024, %edi                     # imm = 0x400
	movl	$1024, %esi                     # imm = 0x400
	movl	$1024, %edx                     # imm = 0x400
	movl	$1024, %ecx                     # imm = 0x400
	movq	%rbx, %r8
	movq	%r14, %r9
	pushq	%rbp
	.cfi_adjust_cfa_offset 8
	pushq	%r13
	.cfi_adjust_cfa_offset 8
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	pushq	%r15
	.cfi_adjust_cfa_offset 8
	callq	_Z7mm2CudaiiiiffPA1024_fS0_S0_S0_S0_S0_
	addq	$32, %rsp
	.cfi_adjust_cfa_offset -32
	movq	%rbx, %rdi
	callq	free
	movq	%r14, %rdi
	callq	free
	movq	%r15, %rdi
	callq	free
	movq	%r12, %rdi
	callq	free
	movq	%r13, %rdi
	callq	free
	movq	%rbp, %rdi
	callq	free
	xorl	%eax, %eax
	addq	$792, %rsp                      # imm = 0x318
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
.LBB12_29:
	.cfi_def_cfa_offset 848
	movq	stderr(%rip), %rcx
	movl	$.L.str.5, %edi
	movl	$50, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end12:
	.size	main, .Lfunc_end12-main
	.cfi_endproc
                                        # -- End function
	.globl	_Z20polybench_alloc_datayi      # -- Begin function _Z20polybench_alloc_datayi
	.p2align	4, 0x90
	.type	_Z20polybench_alloc_datayi,@function
_Z20polybench_alloc_datayi:             # @_Z20polybench_alloc_datayi
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movslq	%esi, %rdx
	imulq	%rdi, %rdx
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	callq	posix_memalign
	movl	%eax, %ecx
	movq	(%rsp), %rax
	testq	%rax, %rax
	je	.LBB13_3
# %bb.1:
	testl	%ecx, %ecx
	jne	.LBB13_3
# %bb.2:
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB13_3:
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.5, %edi
	movl	$50, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end13:
	.size	_Z20polybench_alloc_datayi, .Lfunc_end13-_Z20polybench_alloc_datayi
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_flush_cachev
.LCPI14_0:
	.quad	0x4024000000000000              # double 10
	.text
	.globl	_Z21polybench_flush_cachev
	.p2align	4, 0x90
	.type	_Z21polybench_flush_cachev,@function
_Z21polybench_flush_cachev:             # @_Z21polybench_flush_cachev
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$4194560, %edi                  # imm = 0x400100
	movl	$8, %esi
	callq	calloc
	xorpd	%xmm0, %xmm0
	movl	$7, %ecx
	.p2align	4, 0x90
.LBB14_1:                               # =>This Inner Loop Header: Depth=1
	addsd	-56(%rax,%rcx,8), %xmm0
	addsd	-48(%rax,%rcx,8), %xmm0
	addsd	-40(%rax,%rcx,8), %xmm0
	addsd	-32(%rax,%rcx,8), %xmm0
	addsd	-24(%rax,%rcx,8), %xmm0
	addsd	-16(%rax,%rcx,8), %xmm0
	addsd	-8(%rax,%rcx,8), %xmm0
	addsd	(%rax,%rcx,8), %xmm0
	addq	$8, %rcx
	cmpq	$4194567, %rcx                  # imm = 0x400107
	jne	.LBB14_1
# %bb.2:
	movsd	.LCPI14_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB14_3
# %bb.4:
	movq	%rax, %rdi
	popq	%rax
	.cfi_def_cfa_offset 8
	jmp	free                            # TAILCALL
.LBB14_3:
	.cfi_def_cfa_offset 16
	movl	$.L.str.1, %edi
	movl	$.L.str.2, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end14:
	.size	_Z21polybench_flush_cachev, .Lfunc_end14-_Z21polybench_flush_cachev
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z29polybench_prepare_instrumentsv
.LCPI15_0:
	.quad	0x4024000000000000              # double 10
	.text
	.globl	_Z29polybench_prepare_instrumentsv
	.p2align	4, 0x90
	.type	_Z29polybench_prepare_instrumentsv,@function
_Z29polybench_prepare_instrumentsv:     # @_Z29polybench_prepare_instrumentsv
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$4194560, %edi                  # imm = 0x400100
	movl	$8, %esi
	callq	calloc
	xorpd	%xmm0, %xmm0
	movl	$7, %ecx
	.p2align	4, 0x90
.LBB15_1:                               # =>This Inner Loop Header: Depth=1
	addsd	-56(%rax,%rcx,8), %xmm0
	addsd	-48(%rax,%rcx,8), %xmm0
	addsd	-40(%rax,%rcx,8), %xmm0
	addsd	-32(%rax,%rcx,8), %xmm0
	addsd	-24(%rax,%rcx,8), %xmm0
	addsd	-16(%rax,%rcx,8), %xmm0
	addsd	-8(%rax,%rcx,8), %xmm0
	addsd	(%rax,%rcx,8), %xmm0
	addq	$8, %rcx
	cmpq	$4194567, %rcx                  # imm = 0x400107
	jne	.LBB15_1
# %bb.2:
	movsd	.LCPI15_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB15_3
# %bb.4:
	movq	%rax, %rdi
	popq	%rax
	.cfi_def_cfa_offset 8
	jmp	free                            # TAILCALL
.LBB15_3:
	.cfi_def_cfa_offset 16
	movl	$.L.str.1, %edi
	movl	$.L.str.2, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end15:
	.size	_Z29polybench_prepare_instrumentsv, .Lfunc_end15-_Z29polybench_prepare_instrumentsv
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
	jne	.LBB16_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rbx
	movq	%rax, __hip_gpubin_handle(%rip)
.LBB16_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z11mm2_kernel1iiiiffPfS_S_, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movq	%rbx, %rdi
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z11mm2_kernel2iiiiffPfS_S_, %esi
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
.Lfunc_end16:
	.size	__hip_module_ctor, .Lfunc_end16-__hip_module_ctor
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
	je	.LBB17_2
# %bb.1:
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle(%rip)
.LBB17_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end17:
	.size	__hip_module_dtor, .Lfunc_end17-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Non-Matching CPU-GPU Outputs Beyond Error Threshold of %4.2f Percent: %d\n"
	.size	.L.str, 74

	.type	_Z11mm2_kernel1iiiiffPfS_S_,@object # @_Z11mm2_kernel1iiiiffPfS_S_
	.section	.rodata,"a",@progbits
	.globl	_Z11mm2_kernel1iiiiffPfS_S_
	.p2align	3, 0x0
_Z11mm2_kernel1iiiiffPfS_S_:
	.quad	_Z26__device_stub__mm2_kernel1iiiiffPfS_S_
	.size	_Z11mm2_kernel1iiiiffPfS_S_, 8

	.type	_Z11mm2_kernel2iiiiffPfS_S_,@object # @_Z11mm2_kernel2iiiiffPfS_S_
	.globl	_Z11mm2_kernel2iiiiffPfS_S_
	.p2align	3, 0x0
_Z11mm2_kernel2iiiiffPfS_S_:
	.quad	_Z26__device_stub__mm2_kernel2iiiiffPfS_S_
	.size	_Z11mm2_kernel2iiiiffPfS_S_, 8

	.type	polybench_papi_counters_threadid,@object # @polybench_papi_counters_threadid
	.bss
	.globl	polybench_papi_counters_threadid
	.p2align	2, 0x0
polybench_papi_counters_threadid:
	.long	0                               # 0x0
	.size	polybench_papi_counters_threadid, 4

	.type	polybench_program_total_flops,@object # @polybench_program_total_flops
	.globl	polybench_program_total_flops
	.p2align	3, 0x0
polybench_program_total_flops:
	.quad	0x0000000000000000              # double 0
	.size	polybench_program_total_flops, 8

	.type	polybench_t_start,@object       # @polybench_t_start
	.globl	polybench_t_start
	.p2align	3, 0x0
polybench_t_start:
	.quad	0x0000000000000000              # double 0
	.size	polybench_t_start, 8

	.type	polybench_t_end,@object         # @polybench_t_end
	.globl	polybench_t_end
	.p2align	3, 0x0
polybench_t_end:
	.quad	0x0000000000000000              # double 0
	.size	polybench_t_end, 8

	.type	polybench_c_start,@object       # @polybench_c_start
	.globl	polybench_c_start
	.p2align	3, 0x0
polybench_c_start:
	.quad	0                               # 0x0
	.size	polybench_c_start, 8

	.type	polybench_c_end,@object         # @polybench_c_end
	.globl	polybench_c_end
	.p2align	3, 0x0
polybench_c_end:
	.quad	0                               # 0x0
	.size	polybench_c_end, 8

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"tmp <= 10.0"
	.size	.L.str.1, 12

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"../../src/../include/polybench.c"
	.size	.L.str.2, 33

	.type	.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev,@object # @__PRETTY_FUNCTION__._Z21polybench_flush_cachev
.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev:
	.asciz	"void polybench_flush_cache()"
	.size	.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, 29

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"%f ms\n"
	.size	.L.str.3, 7

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"Error return from gettimeofday: %d"
	.size	.L.str.4, 35

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"[PolyBench] posix_memalign: cannot allocate memory"
	.size	.L.str.5, 51

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z11mm2_kernel1iiiiffPfS_S_"
	.size	.L__unnamed_1, 28

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"_Z11mm2_kernel2iiiiffPfS_S_"
	.size	.L__unnamed_2, 28

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
	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z26__device_stub__mm2_kernel1iiiiffPfS_S_
	.addrsig_sym _Z26__device_stub__mm2_kernel2iiiiffPfS_S_
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Z11mm2_kernel1iiiiffPfS_S_
	.addrsig_sym _Z11mm2_kernel2iiiiffPfS_S_
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
