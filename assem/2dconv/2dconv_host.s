	.text
	.file	"2dconv.hip"
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
	.p2align	4, 0x0                          # -- Begin function _Z6conv2DiiPA4096_fS0_
.LCPI2_0:
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
.LCPI2_1:
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
.LCPI2_2:
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
.LCPI2_3:
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
.LCPI2_4:
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
.LCPI2_5:
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
.LCPI2_6:
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
.LCPI2_7:
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
.LCPI2_8:
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI2_9:
	.long	0x3e4ccccd                      # float 0.200000003
.LCPI2_10:
	.long	0xbe99999a                      # float -0.300000012
.LCPI2_11:
	.long	0x3ecccccd                      # float 0.400000006
.LCPI2_12:
	.long	0x3f000000                      # float 0.5
.LCPI2_13:
	.long	0x3f19999a                      # float 0.600000024
.LCPI2_14:
	.long	0x3f333333                      # float 0.699999988
.LCPI2_15:
	.long	0xbf4ccccd                      # float -0.800000011
.LCPI2_16:
	.long	0xbf666666                      # float -0.899999976
.LCPI2_17:
	.long	0x3dcccccd                      # float 0.100000001
	.text
	.globl	_Z6conv2DiiPA4096_fS0_
	.p2align	4, 0x90
	.type	_Z6conv2DiiPA4096_fS0_,@function
_Z6conv2DiiPA4096_fS0_:                 # @_Z6conv2DiiPA4096_fS0_
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
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
                                        # kill: def $esi killed $esi def $rsi
                                        # kill: def $edi killed $edi def $rdi
	cmpl	$3, %edi
	jl	.LBB2_11
# %bb.1:
	cmpl	$3, %esi
	jl	.LBB2_11
# %bb.2:
	decl	%edi
	decl	%esi
	leaq	16384(,%rsi,4), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	leaq	32772(,%rsi,4), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	leaq	-1(%rsi), %r9
	movq	%r9, %r10
	andq	$-4, %r10
	leaq	1(%r10), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	leaq	32776(%rdx), %rbx
	leaq	16388(%rcx), %r14
	leaq	16384(%rcx), %r15
	movl	$1, %r12d
	xorl	%eax, %eax
	movss	.LCPI2_9(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI2_10(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	movss	.LCPI2_11(%rip), %xmm2          # xmm2 = mem[0],zero,zero,zero
	movss	.LCPI2_12(%rip), %xmm3          # xmm3 = mem[0],zero,zero,zero
	movss	.LCPI2_13(%rip), %xmm4          # xmm4 = mem[0],zero,zero,zero
	movss	.LCPI2_14(%rip), %xmm5          # xmm5 = mem[0],zero,zero,zero
	movss	.LCPI2_15(%rip), %xmm6          # xmm6 = mem[0],zero,zero,zero
	movss	.LCPI2_16(%rip), %xmm7          # xmm7 = mem[0],zero,zero,zero
	movss	.LCPI2_17(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
	movaps	.LCPI2_0(%rip), %xmm14          # xmm14 = [2.00000003E-1,2.00000003E-1,2.00000003E-1,2.00000003E-1]
	movaps	.LCPI2_1(%rip), %xmm13          # xmm13 = [-3.00000012E-1,-3.00000012E-1,-3.00000012E-1,-3.00000012E-1]
	movaps	.LCPI2_2(%rip), %xmm9           # xmm9 = [4.00000006E-1,4.00000006E-1,4.00000006E-1,4.00000006E-1]
	movaps	.LCPI2_3(%rip), %xmm15          # xmm15 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
	movaps	.LCPI2_4(%rip), %xmm10          # xmm10 = [6.00000024E-1,6.00000024E-1,6.00000024E-1,6.00000024E-1]
	movq	%rdx, %rbp
	jmp	.LBB2_3
	.p2align	4, 0x90
.LBB2_10:                               #   in Loop: Header=BB2_3 Depth=1
	incq	%rax
	addq	$16384, %rbx                    # imm = 0x4000
	addq	$16384, %r14                    # imm = 0x4000
	addq	$16384, %rbp                    # imm = 0x4000
	addq	$16384, %r15                    # imm = 0x4000
	cmpq	%rdi, %r12
	je	.LBB2_11
.LBB2_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #     Child Loop BB2_9 Depth 2
	incq	%r12
	movl	$1, %r11d
	cmpq	$4, %r9
	jb	.LBB2_9
# %bb.4:                                #   in Loop: Header=BB2_3 Depth=1
	movq	%rax, %r13
	shlq	$14, %r13
	movq	-8(%rsp), %r8                   # 8-byte Reload
	leaq	(%r8,%r13), %r11
	addq	%rdx, %r11
	leaq	(%rcx,%r13), %r8
	addq	$16388, %r8                     # imm = 0x4004
	cmpq	%r11, %r8
	jae	.LBB2_6
# %bb.5:                                #   in Loop: Header=BB2_3 Depth=1
	leaq	(%rdx,%r13), %r8
	addq	%rcx, %r13
	addq	-16(%rsp), %r13                 # 8-byte Folded Reload
	movl	$1, %r11d
	cmpq	%r13, %r8
	jb	.LBB2_9
.LBB2_6:                                #   in Loop: Header=BB2_3 Depth=1
	xorl	%r11d, %r11d
	movaps	%xmm10, %xmm1
	movaps	%xmm9, %xmm10
	movaps	%xmm13, %xmm9
	.p2align	4, 0x90
.LBB2_7:                                #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-32776(%rbx,%r11,4), %xmm12
	movups	-32772(%rbx,%r11,4), %xmm13
	movups	-32768(%rbx,%r11,4), %xmm11
	mulps	%xmm14, %xmm12
	movaps	%xmm15, %xmm0
	movaps	%xmm14, %xmm15
	movups	-16392(%rbx,%r11,4), %xmm14
	mulps	%xmm9, %xmm14
	addps	%xmm12, %xmm14
	movups	-8(%rbx,%r11,4), %xmm12
	mulps	%xmm10, %xmm12
	addps	%xmm14, %xmm12
	movaps	%xmm15, %xmm14
	movaps	%xmm0, %xmm15
	mulps	%xmm0, %xmm13
	addps	%xmm12, %xmm13
	movups	-16388(%rbx,%r11,4), %xmm12
	mulps	%xmm1, %xmm12
	addps	%xmm13, %xmm12
	movups	-4(%rbx,%r11,4), %xmm13
	mulps	.LCPI2_5(%rip), %xmm13
	addps	%xmm12, %xmm13
	mulps	.LCPI2_6(%rip), %xmm11
	addps	%xmm13, %xmm11
	movups	-16384(%rbx,%r11,4), %xmm12
	mulps	.LCPI2_7(%rip), %xmm12
	addps	%xmm11, %xmm12
	movups	(%rbx,%r11,4), %xmm11
	mulps	.LCPI2_8(%rip), %xmm11
	addps	%xmm12, %xmm11
	movups	%xmm11, (%r14,%r11,4)
	addq	$4, %r11
	cmpq	%r11, %r10
	jne	.LBB2_7
# %bb.8:                                #   in Loop: Header=BB2_3 Depth=1
	movq	-24(%rsp), %r11                 # 8-byte Reload
	cmpq	%r10, %r9
	movaps	%xmm9, %xmm13
	movaps	%xmm10, %xmm9
	movss	.LCPI2_9(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movaps	%xmm1, %xmm10
	movss	.LCPI2_10(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	je	.LBB2_10
	.p2align	4, 0x90
.LBB2_9:                                #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movss	-4(%rbp,%r11,4), %xmm11         # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm0, %xmm11
	movss	16380(%rbp,%r11,4), %xmm12      # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm12
	addss	%xmm11, %xmm12
	movss	32764(%rbp,%r11,4), %xmm11      # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm11
	addss	%xmm12, %xmm11
	movss	(%rbp,%r11,4), %xmm12           # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm3, %xmm12
	addss	%xmm11, %xmm12
	movss	16384(%rbp,%r11,4), %xmm11      # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm4, %xmm11
	addss	%xmm12, %xmm11
	movss	32768(%rbp,%r11,4), %xmm12      # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm5, %xmm12
	addss	%xmm11, %xmm12
	movss	4(%rbp,%r11,4), %xmm11          # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm6, %xmm11
	addss	%xmm12, %xmm11
	movss	16388(%rbp,%r11,4), %xmm12      # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm7, %xmm12
	addss	%xmm11, %xmm12
	movss	32772(%rbp,%r11,4), %xmm11      # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm8, %xmm11
	addss	%xmm12, %xmm11
	movss	%xmm11, (%r15,%r11,4)
	leaq	1(%r11), %r8
	movq	%r8, %r11
	cmpq	%r8, %rsi
	jne	.LBB2_9
	jmp	.LBB2_10
.LBB2_11:
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
.Lfunc_end2:
	.size	_Z6conv2DiiPA4096_fS0_, .Lfunc_end2-_Z6conv2DiiPA4096_fS0_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z4initiiPA4096_f
.LCPI3_0:
	.long	0x30000000                      # float 4.65661287E-10
	.text
	.globl	_Z4initiiPA4096_f
	.p2align	4, 0x90
	.type	_Z4initiiPA4096_f,@function
_Z4initiiPA4096_f:                      # @_Z4initiiPA4096_f
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	testl	%edi, %edi
	jle	.LBB3_6
# %bb.1:
	testl	%esi, %esi
	jle	.LBB3_6
# %bb.2:
	movq	%rdx, %rbx
	movl	%edi, %r14d
	movl	%esi, %r15d
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB3_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB3_4:                                #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	rand
	movss	.LCPI3_0(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%rbx,%r13,4)
	incq	%r13
	cmpq	%r13, %r15
	jne	.LBB3_4
# %bb.5:                                #   in Loop: Header=BB3_3 Depth=1
	incq	%r12
	addq	$16384, %rbx                    # imm = 0x4000
	cmpq	%r14, %r12
	jne	.LBB3_3
.LBB3_6:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_Z4initiiPA4096_f, .Lfunc_end3-_Z4initiiPA4096_f
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z14compareResultsiiPA4096_fS0_
.LCPI4_0:
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
	.long	0x80000000                      # float -0
.LCPI4_1:
	.quad	0x3f847ae147ae147b              # double 0.01
	.quad	0x3f847ae147ae147b              # double 0.01
.LCPI4_2:
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
	.long	0x322bcc77                      # float 9.99999993E-9
.LCPI4_3:
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
	.long	0x42c80000                      # float 100
.LCPI4_4:
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI4_5:
	.quad	0x3f847ae147ae147b              # double 0.01
.LCPI4_8:
	.quad	0x3fa999999999999a              # double 0.050000000000000003
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI4_6:
	.long	0x322bcc77                      # float 9.99999993E-9
.LCPI4_7:
	.long	0x42c80000                      # float 100
	.text
	.globl	_Z14compareResultsiiPA4096_fS0_
	.p2align	4, 0x90
	.type	_Z14compareResultsiiPA4096_fS0_,@function
_Z14compareResultsiiPA4096_fS0_:        # @_Z14compareResultsiiPA4096_fS0_
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
                                        # kill: def $esi killed $esi def $rsi
                                        # kill: def $edi killed $edi def $rdi
	xorl	%eax, %eax
	cmpl	$3, %edi
	jl	.LBB4_13
# %bb.1:
	cmpl	$3, %esi
	jl	.LBB4_13
# %bb.2:
	decl	%edi
	decl	%esi
	leaq	-1(%rsi), %r8
	movq	%r8, %r9
	andq	$-8, %r9
	leaq	1(%r9), %r10
	leaq	16404(%rdx), %r11
	leaq	16404(%rcx), %rbx
	addq	$16384, %rdx                    # imm = 0x4000
	addq	$16384, %rcx                    # imm = 0x4000
	xorl	%eax, %eax
	movl	$1, %r14d
	movaps	.LCPI4_0(%rip), %xmm5           # xmm5 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	movsd	.LCPI4_5(%rip), %xmm11          # xmm11 = mem[0],zero
	movsd	.LCPI4_8(%rip), %xmm7           # xmm7 = mem[0],zero
	movd	.LCPI4_6(%rip), %xmm9           # xmm9 = mem[0],zero,zero,zero
	movss	.LCPI4_7(%rip), %xmm10          # xmm10 = mem[0],zero,zero,zero
	movapd	.LCPI4_1(%rip), %xmm1           # xmm1 = [1.0E-2,1.0E-2]
	movaps	.LCPI4_3(%rip), %xmm8           # xmm8 = [1.0E+2,1.0E+2,1.0E+2,1.0E+2]
	jmp	.LBB4_3
	.p2align	4, 0x90
.LBB4_12:                               #   in Loop: Header=BB4_3 Depth=1
	incq	%r14
	addq	$16384, %r11                    # imm = 0x4000
	addq	$16384, %rbx                    # imm = 0x4000
	addq	$16384, %rdx                    # imm = 0x4000
	addq	$16384, %rcx                    # imm = 0x4000
	cmpq	%rdi, %r14
	je	.LBB4_13
.LBB4_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_6 Depth 2
                                        #     Child Loop BB4_8 Depth 2
	cmpq	$8, %r8
	jae	.LBB4_5
# %bb.4:                                #   in Loop: Header=BB4_3 Depth=1
	movl	$1, %r15d
	jmp	.LBB4_8
	.p2align	4, 0x90
.LBB4_5:                                #   in Loop: Header=BB4_3 Depth=1
	movd	%eax, %xmm10
	pxor	%xmm9, %xmm9
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_6:                                #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-16(%r11,%rax,4), %xmm13
	movups	(%r11,%rax,4), %xmm12
	movups	-16(%rbx,%rax,4), %xmm2
	movups	(%rbx,%rax,4), %xmm6
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
	movaps	.LCPI4_2(%rip), %xmm2           # xmm2 = [9.99999993E-9,9.99999993E-9,9.99999993E-9,9.99999993E-9]
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
	movapd	.LCPI4_4(%rip), %xmm0           # xmm0 = [5.0000000000000003E-2,5.0000000000000003E-2]
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
	addq	$8, %rax
	cmpq	%rax, %r9
	jne	.LBB4_6
# %bb.7:                                #   in Loop: Header=BB4_3 Depth=1
	paddd	%xmm10, %xmm9
	pshufd	$238, %xmm9, %xmm2              # xmm2 = xmm9[2,3,2,3]
	paddd	%xmm9, %xmm2
	pshufd	$85, %xmm2, %xmm3               # xmm3 = xmm2[1,1,1,1]
	paddd	%xmm2, %xmm3
	movd	%xmm3, %eax
	movq	%r10, %r15
	cmpq	%r9, %r8
	movsd	.LCPI4_8(%rip), %xmm7           # xmm7 = mem[0],zero
	movd	.LCPI4_6(%rip), %xmm9           # xmm9 = mem[0],zero,zero,zero
	movss	.LCPI4_7(%rip), %xmm10          # xmm10 = mem[0],zero,zero,zero
	movsd	.LCPI4_5(%rip), %xmm11          # xmm11 = mem[0],zero
	jne	.LBB4_8
	jmp	.LBB4_12
	.p2align	4, 0x90
.LBB4_10:                               #   in Loop: Header=BB4_8 Depth=2
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
.LBB4_11:                               #   in Loop: Header=BB4_8 Depth=2
	xorps	%xmm2, %xmm2
	cvtss2sd	%xmm4, %xmm2
	xorl	%ebp, %ebp
	ucomisd	%xmm7, %xmm2
	seta	%bpl
	addl	%ebp, %eax
	incq	%r15
	cmpq	%r15, %rsi
	je	.LBB4_12
.LBB4_8:                                #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movss	(%rdx,%r15,4), %xmm2            # xmm2 = mem[0],zero,zero,zero
	movss	(%rcx,%r15,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	movaps	%xmm2, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm2, %xmm4
	cvtss2sd	%xmm4, %xmm4
	ucomisd	%xmm4, %xmm11
	jbe	.LBB4_10
# %bb.9:                                #   in Loop: Header=BB4_8 Depth=2
	movaps	%xmm3, %xmm4
	xorps	%xmm5, %xmm4
	maxss	%xmm3, %xmm4
	xorps	%xmm6, %xmm6
	cvtss2sd	%xmm4, %xmm6
	xorps	%xmm4, %xmm4
	ucomisd	%xmm6, %xmm11
	jbe	.LBB4_10
	jmp	.LBB4_11
.LBB4_13:
	movsd	.LCPI4_8(%rip), %xmm0           # xmm0 = mem[0],zero
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
.Lfunc_end4:
	.size	_Z14compareResultsiiPA4096_fS0_, .Lfunc_end4-_Z14compareResultsiiPA4096_fS0_
	.cfi_endproc
                                        # -- End function
	.globl	_Z13GPU_argv_initv              # -- Begin function _Z13GPU_argv_initv
	.p2align	4, 0x90
	.type	_Z13GPU_argv_initv,@function
_Z13GPU_argv_initv:                     # @_Z13GPU_argv_initv
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$800, %rsp                      # imm = 0x320
	.cfi_def_cfa_offset 816
	.cfi_offset %rbx, -16
	leaq	8(%rsp), %rbx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	hipGetDeviceProperties
	movl	$.L.str.1, %edi
	xorl	%esi, %esi
	movq	%rbx, %rdx
	xorl	%eax, %eax
	callq	printf
	xorl	%edi, %edi
	callq	hipSetDevice
	addq	$800, %rsp                      # imm = 0x320
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_Z13GPU_argv_initv, .Lfunc_end5-_Z13GPU_argv_initv
	.cfi_endproc
                                        # -- End function
	.globl	_Z35__device_stub__convolution2D_kerneliiPfS_ # -- Begin function _Z35__device_stub__convolution2D_kerneliiPfS_
	.p2align	4, 0x90
	.type	_Z35__device_stub__convolution2D_kerneliiPfS_,@function
_Z35__device_stub__convolution2D_kerneliiPfS_: # @_Z35__device_stub__convolution2D_kerneliiPfS_
	.cfi_startproc
# %bb.0:
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movl	%edi, 12(%rsp)
	movl	%esi, 8(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 104(%rsp)
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
	movl	$_Z20convolution2D_kerneliiPfS_, %edi
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$136, %rsp
	.cfi_adjust_cfa_offset -136
	retq
.Lfunc_end6:
	.size	_Z35__device_stub__convolution2D_kerneliiPfS_, .Lfunc_end6-_Z35__device_stub__convolution2D_kerneliiPfS_
	.cfi_endproc
                                        # -- End function
	.globl	_Z17convolution2DCudaiiPA4096_fS0_S0_ # -- Begin function _Z17convolution2DCudaiiPA4096_fS0_S0_
	.p2align	4, 0x90
	.type	_Z17convolution2DCudaiiPA4096_fS0_S0_,@function
_Z17convolution2DCudaiiPA4096_fS0_S0_:  # @_Z17convolution2DCudaiiPA4096_fS0_S0_
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
	subq	$152, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%r8, %rbx
	movq	%rdx, %r15
	movl	%esi, %ebp
	movl	%edi, %r14d
	leaq	24(%rsp), %rdi
	movl	$67108864, %esi                 # imm = 0x4000000
	callq	hipMalloc
	leaq	16(%rsp), %rdi
	movl	$67108864, %esi                 # imm = 0x4000000
	callq	hipMalloc
	movq	24(%rsp), %rdi
	movl	$67108864, %edx                 # imm = 0x4000000
	movq	%r15, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	leaq	40(%rsp), %rdi
	callq	hipEventCreate
	leaq	8(%rsp), %rdi
	callq	hipEventCreate
	movl	$1065353216, 4(%rsp)            # imm = 0x3F800000
	movq	40(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movabsq	$2199023255680, %rdi            # imm = 0x20000000080
	movabsq	$34359738400, %rdx              # imm = 0x800000020
	movl	$1, %esi
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB7_2
# %bb.1:
	movq	24(%rsp), %rax
	movq	16(%rsp), %rcx
	movl	%r14d, 36(%rsp)
	movl	%ebp, 32(%rsp)
	movq	%rax, 104(%rsp)
	movq	%rcx, 96(%rsp)
	leaq	36(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	80(%rsp), %rdi
	leaq	64(%rsp), %rsi
	leaq	56(%rsp), %rdx
	leaq	48(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	80(%rsp), %rsi
	movl	88(%rsp), %edx
	movq	64(%rsp), %rcx
	movl	72(%rsp), %r8d
	leaq	112(%rsp), %r9
	movl	$_Z20convolution2D_kerneliiPfS_, %edi
	pushq	48(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	64(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB7_2:
	movq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movq	8(%rsp), %rdi
	callq	hipEventSynchronize
	movq	40(%rsp), %rsi
	movq	8(%rsp), %rdx
	leaq	4(%rsp), %rdi
	callq	hipEventElapsedTime
	movss	4(%rsp), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.2, %edi
	movb	$1, %al
	callq	printf
	movq	16(%rsp), %rsi
	movl	$67108864, %edx                 # imm = 0x4000000
	movq	%rbx, %rdi
	movl	$2, %ecx
	callq	hipMemcpy
	movq	24(%rsp), %rdi
	callq	hipFree
	movq	16(%rsp), %rdi
	callq	hipFree
	addq	$152, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_Z17convolution2DCudaiiPA4096_fS0_S0_, .Lfunc_end7-_Z17convolution2DCudaiiPA4096_fS0_S0_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function main
.LCPI8_0:
	.long	0x30000000                      # float 4.65661287E-10
.LCPI8_10:
	.long	0x3e4ccccd                      # float 0.200000003
.LCPI8_11:
	.long	0xbe99999a                      # float -0.300000012
.LCPI8_12:
	.long	0x3ecccccd                      # float 0.400000006
.LCPI8_13:
	.long	0x3f000000                      # float 0.5
.LCPI8_14:
	.long	0x3f19999a                      # float 0.600000024
.LCPI8_15:
	.long	0x3f333333                      # float 0.699999988
.LCPI8_16:
	.long	0xbf4ccccd                      # float -0.800000011
.LCPI8_17:
	.long	0xbf666666                      # float -0.899999976
.LCPI8_18:
	.long	0x3dcccccd                      # float 0.100000001
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_1:
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
	.long	0x3e4ccccd                      # float 0.200000003
.LCPI8_2:
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
	.long	0xbe99999a                      # float -0.300000012
.LCPI8_3:
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
	.long	0x3ecccccd                      # float 0.400000006
.LCPI8_4:
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
	.long	0x3f000000                      # float 0.5
.LCPI8_5:
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
	.long	0x3f19999a                      # float 0.600000024
.LCPI8_6:
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
	.long	0x3f333333                      # float 0.699999988
.LCPI8_7:
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
	.long	0xbf4ccccd                      # float -0.800000011
.LCPI8_8:
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
	.long	0xbf666666                      # float -0.899999976
.LCPI8_9:
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
	.long	0x3dcccccd                      # float 0.100000001
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
	movl	$67108864, %edx                 # imm = 0x4000000
	callq	posix_memalign
	movq	(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB8_20
# %bb.1:
	testl	%eax, %eax
	jne	.LBB8_20
# %bb.2:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$67108864, %edx                 # imm = 0x4000000
	callq	posix_memalign
	movq	(%rsp), %r14
	testq	%r14, %r14
	je	.LBB8_20
# %bb.3:
	testl	%eax, %eax
	jne	.LBB8_20
# %bb.4:
	movq	$0, (%rsp)
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$67108864, %edx                 # imm = 0x4000000
	callq	posix_memalign
	movq	(%rsp), %r15
	testq	%r15, %r15
	je	.LBB8_20
# %bb.5:
	testl	%eax, %eax
	jne	.LBB8_20
# %bb.6:
	xorl	%r12d, %r12d
	movq	%rbx, %r13
	.p2align	4, 0x90
.LBB8_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_8 Depth 2
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB8_8:                                #   Parent Loop BB8_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	rand
	movss	.LCPI8_0(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	xorps	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%r13,%rbp,4)
	incq	%rbp
	cmpq	$4096, %rbp                     # imm = 0x1000
	jne	.LBB8_8
# %bb.9:                                #   in Loop: Header=BB8_7 Depth=1
	incq	%r12
	addq	$16384, %r13                    # imm = 0x4000
	cmpq	$4096, %r12                     # imm = 0x1000
	jne	.LBB8_7
# %bb.10:
	movq	%rsp, %r12
	xorl	%r13d, %r13d
	movq	%r12, %rdi
	xorl	%esi, %esi
	callq	hipGetDeviceProperties
	movl	$.L.str.1, %edi
	xorl	%esi, %esi
	movq	%r12, %rdx
	xorl	%eax, %eax
	callq	printf
	xorl	%edi, %edi
	callq	hipSetDevice
	movl	$4096, %edi                     # imm = 0x1000
	movl	$4096, %esi                     # imm = 0x1000
	movq	%rbx, %rdx
	movq	%r15, %r8
	callq	_Z17convolution2DCudaiiPA4096_fS0_S0_
	leaq	32776(%rbx), %rax
	leaq	16388(%r14), %rcx
	leaq	16384(%r14), %rdx
	leaq	16384(%rbx), %rsi
	movl	$1, %edi
	movss	.LCPI8_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI8_11(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	movss	.LCPI8_12(%rip), %xmm2          # xmm2 = mem[0],zero,zero,zero
	movss	.LCPI8_13(%rip), %xmm3          # xmm3 = mem[0],zero,zero,zero
	movss	.LCPI8_14(%rip), %xmm4          # xmm4 = mem[0],zero,zero,zero
	movss	.LCPI8_15(%rip), %xmm5          # xmm5 = mem[0],zero,zero,zero
	movss	.LCPI8_16(%rip), %xmm6          # xmm6 = mem[0],zero,zero,zero
	movss	.LCPI8_17(%rip), %xmm7          # xmm7 = mem[0],zero,zero,zero
	movss	.LCPI8_18(%rip), %xmm8          # xmm8 = mem[0],zero,zero,zero
	movaps	.LCPI8_1(%rip), %xmm14          # xmm14 = [2.00000003E-1,2.00000003E-1,2.00000003E-1,2.00000003E-1]
	movaps	.LCPI8_2(%rip), %xmm13          # xmm13 = [-3.00000012E-1,-3.00000012E-1,-3.00000012E-1,-3.00000012E-1]
	movaps	.LCPI8_3(%rip), %xmm9           # xmm9 = [4.00000006E-1,4.00000006E-1,4.00000006E-1,4.00000006E-1]
	movaps	.LCPI8_4(%rip), %xmm15          # xmm15 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
	movaps	.LCPI8_5(%rip), %xmm10          # xmm10 = [6.00000024E-1,6.00000024E-1,6.00000024E-1,6.00000024E-1]
	.p2align	4, 0x90
.LBB8_11:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_14 Depth 2
                                        #     Child Loop BB8_17 Depth 2
	movq	%r13, %r8
	shlq	$14, %r8
	leaq	(%rbx,%r8), %r9
	addq	$49152, %r9                     # imm = 0xC000
	leaq	(%r8,%r14), %r10
	addq	$16388, %r10                    # imm = 0x4004
	cmpq	%r9, %r10
	jae	.LBB8_13
# %bb.12:                               #   in Loop: Header=BB8_11 Depth=1
	leaq	(%rbx,%r8), %r9
	leaq	(%r8,%r14), %r10
	addq	$32764, %r10                    # imm = 0x7FFC
	movl	$1, %r8d
	cmpq	%r10, %r9
	jb	.LBB8_16
.LBB8_13:                               #   in Loop: Header=BB8_11 Depth=1
	xorl	%r8d, %r8d
	movaps	%xmm10, %xmm1
	movaps	%xmm9, %xmm10
	movaps	%xmm13, %xmm9
	movaps	.LCPI8_6(%rip), %xmm2           # xmm2 = [6.99999988E-1,6.99999988E-1,6.99999988E-1,6.99999988E-1]
	movaps	.LCPI8_7(%rip), %xmm3           # xmm3 = [-8.00000011E-1,-8.00000011E-1,-8.00000011E-1,-8.00000011E-1]
	movaps	.LCPI8_8(%rip), %xmm4           # xmm4 = [-8.99999976E-1,-8.99999976E-1,-8.99999976E-1,-8.99999976E-1]
	movaps	.LCPI8_9(%rip), %xmm5           # xmm5 = [1.00000001E-1,1.00000001E-1,1.00000001E-1,1.00000001E-1]
	.p2align	4, 0x90
.LBB8_14:                               #   Parent Loop BB8_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-32776(%rax,%r8,4), %xmm12
	movups	-32772(%rax,%r8,4), %xmm13
	movups	-32768(%rax,%r8,4), %xmm11
	mulps	%xmm14, %xmm12
	movaps	%xmm15, %xmm0
	movaps	%xmm14, %xmm15
	movups	-16392(%rax,%r8,4), %xmm14
	mulps	%xmm9, %xmm14
	addps	%xmm12, %xmm14
	movups	-8(%rax,%r8,4), %xmm12
	mulps	%xmm10, %xmm12
	addps	%xmm14, %xmm12
	movaps	%xmm15, %xmm14
	movaps	%xmm0, %xmm15
	mulps	%xmm0, %xmm13
	addps	%xmm12, %xmm13
	movups	-16388(%rax,%r8,4), %xmm12
	mulps	%xmm1, %xmm12
	addps	%xmm13, %xmm12
	movups	-4(%rax,%r8,4), %xmm13
	mulps	%xmm2, %xmm13
	addps	%xmm12, %xmm13
	mulps	%xmm3, %xmm11
	addps	%xmm13, %xmm11
	movups	-16384(%rax,%r8,4), %xmm12
	mulps	%xmm4, %xmm12
	addps	%xmm11, %xmm12
	movups	(%rax,%r8,4), %xmm11
	mulps	%xmm5, %xmm11
	addps	%xmm12, %xmm11
	movups	%xmm11, (%rcx,%r8,4)
	addq	$4, %r8
	cmpq	$4092, %r8                      # imm = 0xFFC
	jne	.LBB8_14
# %bb.15:                               #   in Loop: Header=BB8_11 Depth=1
	movl	$4093, %r8d                     # imm = 0xFFD
	movaps	%xmm9, %xmm13
	movaps	%xmm10, %xmm9
	movss	.LCPI8_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movaps	%xmm1, %xmm10
	movss	.LCPI8_11(%rip), %xmm1          # xmm1 = mem[0],zero,zero,zero
	movss	.LCPI8_12(%rip), %xmm2          # xmm2 = mem[0],zero,zero,zero
	movss	.LCPI8_13(%rip), %xmm3          # xmm3 = mem[0],zero,zero,zero
	movss	.LCPI8_14(%rip), %xmm4          # xmm4 = mem[0],zero,zero,zero
	movss	.LCPI8_15(%rip), %xmm5          # xmm5 = mem[0],zero,zero,zero
.LBB8_16:                               #   in Loop: Header=BB8_11 Depth=1
	incq	%rdi
	.p2align	4, 0x90
.LBB8_17:                               #   Parent Loop BB8_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movss	-16388(%rsi,%r8,4), %xmm11      # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm0, %xmm11
	movss	-4(%rsi,%r8,4), %xmm12          # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm12
	addss	%xmm11, %xmm12
	movss	16380(%rsi,%r8,4), %xmm11       # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm2, %xmm11
	addss	%xmm12, %xmm11
	movss	-16384(%rsi,%r8,4), %xmm12      # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm3, %xmm12
	addss	%xmm11, %xmm12
	movss	(%rsi,%r8,4), %xmm11            # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm4, %xmm11
	addss	%xmm12, %xmm11
	movss	16384(%rsi,%r8,4), %xmm12       # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm5, %xmm12
	addss	%xmm11, %xmm12
	movss	-16380(%rsi,%r8,4), %xmm11      # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm6, %xmm11
	addss	%xmm12, %xmm11
	movss	4(%rsi,%r8,4), %xmm12           # xmm12 = mem[0],zero,zero,zero
	mulss	%xmm7, %xmm12
	addss	%xmm11, %xmm12
	movss	16388(%rsi,%r8,4), %xmm11       # xmm11 = mem[0],zero,zero,zero
	mulss	%xmm8, %xmm11
	addss	%xmm12, %xmm11
	movss	%xmm11, (%rdx,%r8,4)
	leaq	1(%r8), %r9
	movq	%r9, %r8
	cmpq	$4095, %r9                      # imm = 0xFFF
	jne	.LBB8_17
# %bb.18:                               #   in Loop: Header=BB8_11 Depth=1
	incq	%r13
	addq	$16384, %rax                    # imm = 0x4000
	addq	$16384, %rcx                    # imm = 0x4000
	addq	$16384, %rdx                    # imm = 0x4000
	addq	$16384, %rsi                    # imm = 0x4000
	cmpq	$4095, %rdi                     # imm = 0xFFF
	jne	.LBB8_11
# %bb.19:
	movq	%rbx, %rdi
	callq	free
	movq	%r14, %rdi
	callq	free
	movq	%r15, %rdi
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
.LBB8_20:
	.cfi_def_cfa_offset 848
	movq	stderr(%rip), %rcx
	movl	$.L.str.7, %edi
	movl	$50, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
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
	je	.LBB9_3
# %bb.1:
	testl	%ecx, %ecx
	jne	.LBB9_3
# %bb.2:
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB9_3:
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.7, %edi
	movl	$50, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end9:
	.size	_Z20polybench_alloc_datayi, .Lfunc_end9-_Z20polybench_alloc_datayi
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_flush_cachev
.LCPI10_0:
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
.LBB10_1:                               # =>This Inner Loop Header: Depth=1
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
	jne	.LBB10_1
# %bb.2:
	movsd	.LCPI10_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB10_3
# %bb.4:
	movq	%rax, %rdi
	popq	%rax
	.cfi_def_cfa_offset 8
	jmp	free                            # TAILCALL
.LBB10_3:
	.cfi_def_cfa_offset 16
	movl	$.L.str.3, %edi
	movl	$.L.str.4, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end10:
	.size	_Z21polybench_flush_cachev, .Lfunc_end10-_Z21polybench_flush_cachev
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z29polybench_prepare_instrumentsv
.LCPI11_0:
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
.LBB11_1:                               # =>This Inner Loop Header: Depth=1
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
	jne	.LBB11_1
# %bb.2:
	movsd	.LCPI11_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB11_3
# %bb.4:
	movq	%rax, %rdi
	popq	%rax
	.cfi_def_cfa_offset 8
	jmp	free                            # TAILCALL
.LBB11_3:
	.cfi_def_cfa_offset 16
	movl	$.L.str.3, %edi
	movl	$.L.str.4, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end11:
	.size	_Z29polybench_prepare_instrumentsv, .Lfunc_end11-_Z29polybench_prepare_instrumentsv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_timer_startv
.LCPI12_0:
	.quad	0x4024000000000000              # double 10
.LCPI12_1:
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
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
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
	jne	.LBB12_1
# %bb.2:
	movsd	.LCPI12_0(%rip), %xmm1          # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jb	.LBB12_6
# %bb.3:
	movq	%rax, %rdi
	callq	free
	leaq	8(%rsp), %rdi
	xorl	%esi, %esi
	callq	gettimeofday
	testl	%eax, %eax
	je	.LBB12_5
# %bb.4:
	movl	$.L.str.6, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
.LBB12_5:
	xorps	%xmm0, %xmm0
	cvtsi2sdq	8(%rsp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdq	16(%rsp), %xmm1
	mulsd	.LCPI12_1(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, polybench_t_start(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB12_6:
	.cfi_def_cfa_offset 32
	movl	$.L.str.3, %edi
	movl	$.L.str.4, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end12:
	.size	_Z21polybench_timer_startv, .Lfunc_end12-_Z21polybench_timer_startv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z20polybench_timer_stopv
.LCPI13_0:
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
	je	.LBB13_2
# %bb.1:
	movl	$.L.str.6, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
.LBB13_2:
	cvtsi2sdq	8(%rsp), %xmm0
	cvtsi2sdq	16(%rsp), %xmm1
	mulsd	.LCPI13_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, polybench_t_end(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	_Z20polybench_timer_stopv, .Lfunc_end13-_Z20polybench_timer_stopv
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function _Z21polybench_timer_printv
.LCPI14_0:
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
	mulsd	.LCPI14_0(%rip), %xmm0
	movl	$.L.str.5, %edi
	movb	$1, %al
	jmp	printf                          # TAILCALL
.Lfunc_end14:
	.size	_Z21polybench_timer_printv, .Lfunc_end14-_Z21polybench_timer_printv
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	__hip_gpubin_handle(%rip), %rdi
	testq	%rdi, %rdi
	jne	.LBB15_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rdi
	movq	%rax, __hip_gpubin_handle(%rip)
.LBB15_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z20convolution2D_kerneliiPfS_, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	movl	$__hip_module_dtor, %edi
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	jmp	atexit                          # TAILCALL
.Lfunc_end15:
	.size	__hip_module_ctor, .Lfunc_end15-__hip_module_ctor
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
	je	.LBB16_2
# %bb.1:
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle(%rip)
.LBB16_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end16:
	.size	__hip_module_dtor, .Lfunc_end16-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Non-Matching CPU-GPU Outputs Beyond Error Threshold of %4.2f Percent: %d\n"
	.size	.L.str, 74

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"setting device %d with name %s\n"
	.size	.L.str.1, 32

	.type	_Z20convolution2D_kerneliiPfS_,@object # @_Z20convolution2D_kerneliiPfS_
	.section	.rodata,"a",@progbits
	.globl	_Z20convolution2D_kerneliiPfS_
	.p2align	3, 0x0
_Z20convolution2D_kerneliiPfS_:
	.quad	_Z35__device_stub__convolution2D_kerneliiPfS_
	.size	_Z20convolution2D_kerneliiPfS_, 8

	.type	.L.str.2,@object                # @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"kernel time (hipEventElapsedTime)=%6.3fms\n"
	.size	.L.str.2, 43

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

	.type	.L.str.3,@object                # @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"tmp <= 10.0"
	.size	.L.str.3, 12

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"../../src/../include/polybench.c"
	.size	.L.str.4, 33

	.type	.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev,@object # @__PRETTY_FUNCTION__._Z21polybench_flush_cachev
.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev:
	.asciz	"void polybench_flush_cache()"
	.size	.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, 29

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"%f ms\n"
	.size	.L.str.5, 7

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"Error return from gettimeofday: %d"
	.size	.L.str.6, 35

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"[PolyBench] posix_memalign: cannot allocate memory"
	.size	.L.str.7, 51

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z20convolution2D_kerneliiPfS_"
	.size	.L__unnamed_1, 31

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
	.addrsig_sym _Z35__device_stub__convolution2D_kerneliiPfS_
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Z20convolution2D_kerneliiPfS_
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
