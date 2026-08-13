	.text
	.file	"doitgen.hip"
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
	.globl	_Z10doitgenCPUPfS_S_            # -- Begin function _Z10doitgenCPUPfS_S_
	.p2align	4, 0x90
	.type	_Z10doitgenCPUPfS_S_,@function
_Z10doitgenCPUPfS_S_:                   # @_Z10doitgenCPUPfS_S_
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
	leaq	4(%rsi), %r12
	addq	$512, %rdx                      # imm = 0x200
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	leaq	12(%rsi), %r15
	leaq	12(%rdi), %r14
	xorl	%eax, %eax
	jmp	.LBB2_1
	.p2align	4, 0x90
.LBB2_9:                                #   in Loop: Header=BB2_1 Depth=1
	movq	-56(%rsp), %rax                 # 8-byte Reload
	incq	%rax
	movq	-32(%rsp), %r12                 # 8-byte Reload
	addq	$65536, %r12                    # imm = 0x10000
	movq	-40(%rsp), %r15                 # 8-byte Reload
	addq	$65536, %r15                    # imm = 0x10000
	movq	-48(%rsp), %r14                 # 8-byte Reload
	addq	$65536, %r14                    # imm = 0x10000
	cmpq	$128, %rax
	je	.LBB2_10
.LBB2_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_2 Depth 2
                                        #       Child Loop BB2_3 Depth 3
                                        #         Child Loop BB2_4 Depth 4
                                        #       Child Loop BB2_8 Depth 3
	movq	%rax, %r10
	shlq	$16, %r10
	leaq	(%r10,%rsi), %rcx
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	addq	%rdi, %r10
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	shlq	$14, %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%r14, -48(%rsp)                 # 8-byte Spill
	movq	%r15, -40(%rsp)                 # 8-byte Spill
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	xorl	%eax, %eax
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_11:                               #   in Loop: Header=BB2_2 Depth=2
	leaq	(,%r13,4), %rbp
	movups	(%rdi,%r13,4), %xmm0
	movups	16(%rdi,%r13,4), %xmm1
	movups	%xmm0, (%rsi,%r13,4)
	movups	%xmm1, 16(%rsi,%r13,4)
	movq	%rbp, %rcx
	orq	$32, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$64, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$96, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$128, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$160, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$192, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$224, %rcx
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$256, %rcx                      # imm = 0x100
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$288, %rcx                      # imm = 0x120
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$320, %rcx                      # imm = 0x140
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$352, %rcx                      # imm = 0x160
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$384, %rcx                      # imm = 0x180
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$416, %rcx                      # imm = 0x1A0
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	movq	%rbp, %rcx
	orq	$448, %rcx                      # imm = 0x1C0
	movups	(%rdi,%rcx), %xmm0
	movups	16(%rdi,%rcx), %xmm1
	movups	%xmm0, (%rsi,%rcx)
	movups	%xmm1, 16(%rsi,%rcx)
	orq	$480, %rbp                      # imm = 0x1E0
	movups	(%rdi,%rbp), %xmm0
	movups	16(%rdi,%rbp), %xmm1
	movups	%xmm0, (%rsi,%rbp)
	movups	%xmm1, 16(%rsi,%rbp)
.LBB2_12:                               #   in Loop: Header=BB2_2 Depth=2
	incq	%rax
	addq	$512, %r12                      # imm = 0x200
	addq	$512, %r15                      # imm = 0x200
	addq	$512, %r14                      # imm = 0x200
	cmpq	$128, %rax
	je	.LBB2_9
.LBB2_2:                                #   Parent Loop BB2_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_3 Depth 3
                                        #         Child Loop BB2_4 Depth 4
                                        #       Child Loop BB2_8 Depth 3
	movq	%rax, %rbp
	shlq	$9, %rbp
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	addq	%rbp, %rcx
	addq	%r10, %rbp
	movq	%rax, %r13
	shlq	$7, %r13
	addq	-16(%rsp), %r13                 # 8-byte Folded Reload
	movq	-24(%rsp), %r11                 # 8-byte Reload
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_3:                                #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_2 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_4 Depth 4
	leaq	(%r9,%r13), %r8
	movl	$0, (%rdi,%r8,4)
	xorps	%xmm0, %xmm0
	movq	%r11, %rdx
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_4:                                #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_2 Depth=2
                                        #       Parent Loop BB2_3 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movss	-4(%r12,%rbx,4), %xmm1          # xmm1 = mem[0],zero,zero,zero
	mulss	-512(%rdx), %xmm1
	addss	%xmm0, %xmm1
	movss	%xmm1, (%rdi,%r8,4)
	movss	(%r12,%rbx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	mulss	(%rdx), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, (%rdi,%r8,4)
	addq	$2, %rbx
	addq	$1024, %rdx                     # imm = 0x400
	cmpq	$128, %rbx
	jne	.LBB2_4
# %bb.5:                                #   in Loop: Header=BB2_3 Depth=3
	incq	%r9
	addq	$4, %r11
	cmpq	$128, %r9
	jne	.LBB2_3
# %bb.6:                                #   in Loop: Header=BB2_2 Depth=2
	subq	%rbp, %rcx
	cmpq	$31, %rcx
	ja	.LBB2_11
# %bb.7:                                #   in Loop: Header=BB2_2 Depth=2
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_8:                                #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	-12(%r14,%rcx,4), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -12(%r15,%rcx,4)
	movss	-8(%r14,%rcx,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -8(%r15,%rcx,4)
	movss	-4(%r14,%rcx,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, -4(%r15,%rcx,4)
	movss	(%r14,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, (%r15,%rcx,4)
	addq	$4, %rcx
	cmpq	$128, %rcx
	jne	.LBB2_8
	jmp	.LBB2_12
.LBB2_10:
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
	.size	_Z10doitgenCPUPfS_S_, .Lfunc_end2-_Z10doitgenCPUPfS_S_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z10init_arrayPfS_
.LCPI3_0:
	.long	0x00000000                      # float 0
	.long	0x3f800000                      # float 1
	.long	0x40000000                      # float 2
	.long	0x40400000                      # float 3
.LCPI3_1:
	.long	0x40800000                      # float 4
	.long	0x40a00000                      # float 5
	.long	0x40c00000                      # float 6
	.long	0x40e00000                      # float 7
.LCPI3_2:
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
.LCPI3_3:
	.long	0x41000000                      # float 8
	.long	0x41100000                      # float 9
	.long	0x41200000                      # float 10
	.long	0x41300000                      # float 11
.LCPI3_4:
	.long	0x41400000                      # float 12
	.long	0x41500000                      # float 13
	.long	0x41600000                      # float 14
	.long	0x41700000                      # float 15
.LCPI3_5:
	.long	0x41800000                      # float 16
	.long	0x41880000                      # float 17
	.long	0x41900000                      # float 18
	.long	0x41980000                      # float 19
.LCPI3_6:
	.long	0x41a00000                      # float 20
	.long	0x41a80000                      # float 21
	.long	0x41b00000                      # float 22
	.long	0x41b80000                      # float 23
.LCPI3_7:
	.long	0x41c00000                      # float 24
	.long	0x41c80000                      # float 25
	.long	0x41d00000                      # float 26
	.long	0x41d80000                      # float 27
.LCPI3_8:
	.long	0x41e00000                      # float 28
	.long	0x41e80000                      # float 29
	.long	0x41f00000                      # float 30
	.long	0x41f80000                      # float 31
.LCPI3_9:
	.long	0x42000000                      # float 32
	.long	0x42040000                      # float 33
	.long	0x42080000                      # float 34
	.long	0x420c0000                      # float 35
.LCPI3_10:
	.long	0x42100000                      # float 36
	.long	0x42140000                      # float 37
	.long	0x42180000                      # float 38
	.long	0x421c0000                      # float 39
.LCPI3_11:
	.long	0x42200000                      # float 40
	.long	0x42240000                      # float 41
	.long	0x42280000                      # float 42
	.long	0x422c0000                      # float 43
.LCPI3_12:
	.long	0x42300000                      # float 44
	.long	0x42340000                      # float 45
	.long	0x42380000                      # float 46
	.long	0x423c0000                      # float 47
.LCPI3_13:
	.long	0x42400000                      # float 48
	.long	0x42440000                      # float 49
	.long	0x42480000                      # float 50
	.long	0x424c0000                      # float 51
.LCPI3_14:
	.long	0x42500000                      # float 52
	.long	0x42540000                      # float 53
	.long	0x42580000                      # float 54
	.long	0x425c0000                      # float 55
.LCPI3_15:
	.long	0x42600000                      # float 56
	.long	0x42640000                      # float 57
	.long	0x42680000                      # float 58
	.long	0x426c0000                      # float 59
.LCPI3_16:
	.long	0x42700000                      # float 60
	.long	0x42740000                      # float 61
	.long	0x42780000                      # float 62
	.long	0x427c0000                      # float 63
.LCPI3_17:
	.long	0x42800000                      # float 64
	.long	0x42820000                      # float 65
	.long	0x42840000                      # float 66
	.long	0x42860000                      # float 67
.LCPI3_18:
	.long	0x42880000                      # float 68
	.long	0x428a0000                      # float 69
	.long	0x428c0000                      # float 70
	.long	0x428e0000                      # float 71
.LCPI3_19:
	.long	0x42900000                      # float 72
	.long	0x42920000                      # float 73
	.long	0x42940000                      # float 74
	.long	0x42960000                      # float 75
.LCPI3_20:
	.long	0x42980000                      # float 76
	.long	0x429a0000                      # float 77
	.long	0x429c0000                      # float 78
	.long	0x429e0000                      # float 79
.LCPI3_21:
	.long	0x42a00000                      # float 80
	.long	0x42a20000                      # float 81
	.long	0x42a40000                      # float 82
	.long	0x42a60000                      # float 83
.LCPI3_22:
	.long	0x42a80000                      # float 84
	.long	0x42aa0000                      # float 85
	.long	0x42ac0000                      # float 86
	.long	0x42ae0000                      # float 87
.LCPI3_23:
	.long	0x42b00000                      # float 88
	.long	0x42b20000                      # float 89
	.long	0x42b40000                      # float 90
	.long	0x42b60000                      # float 91
.LCPI3_24:
	.long	0x42b80000                      # float 92
	.long	0x42ba0000                      # float 93
	.long	0x42bc0000                      # float 94
	.long	0x42be0000                      # float 95
.LCPI3_25:
	.long	0x42c00000                      # float 96
	.long	0x42c20000                      # float 97
	.long	0x42c40000                      # float 98
	.long	0x42c60000                      # float 99
.LCPI3_26:
	.long	0x42c80000                      # float 100
	.long	0x42ca0000                      # float 101
	.long	0x42cc0000                      # float 102
	.long	0x42ce0000                      # float 103
.LCPI3_27:
	.long	0x42d00000                      # float 104
	.long	0x42d20000                      # float 105
	.long	0x42d40000                      # float 106
	.long	0x42d60000                      # float 107
.LCPI3_28:
	.long	0x42d80000                      # float 108
	.long	0x42da0000                      # float 109
	.long	0x42dc0000                      # float 110
	.long	0x42de0000                      # float 111
.LCPI3_29:
	.long	0x42e00000                      # float 112
	.long	0x42e20000                      # float 113
	.long	0x42e40000                      # float 114
	.long	0x42e60000                      # float 115
.LCPI3_30:
	.long	0x42e80000                      # float 116
	.long	0x42ea0000                      # float 117
	.long	0x42ec0000                      # float 118
	.long	0x42ee0000                      # float 119
.LCPI3_31:
	.long	0x42f00000                      # float 120
	.long	0x42f20000                      # float 121
	.long	0x42f40000                      # float 122
	.long	0x42f60000                      # float 123
.LCPI3_32:
	.long	0x42f80000                      # float 124
	.long	0x42fa0000                      # float 125
	.long	0x42fc0000                      # float 126
	.long	0x42fe0000                      # float 127
	.text
	.globl	_Z10init_arrayPfS_
	.p2align	4, 0x90
	.type	_Z10init_arrayPfS_,@function
_Z10init_arrayPfS_:                     # @_Z10init_arrayPfS_
	.cfi_startproc
# %bb.0:
	addq	$496, %rdi                      # imm = 0x1F0
	xorl	%eax, %eax
	movaps	.LCPI3_2(%rip), %xmm2           # xmm2 = [7.8125E-3,7.8125E-3,7.8125E-3,7.8125E-3]
	movaps	.LCPI3_32(%rip), %xmm4          # xmm4 = [1.24E+2,1.25E+2,1.26E+2,1.27E+2]
	movaps	.LCPI3_20(%rip), %xmm13         # xmm13 = [7.6E+1,7.7E+1,7.8E+1,7.9E+1]
	movaps	.LCPI3_21(%rip), %xmm14         # xmm14 = [8.0E+1,8.1E+1,8.2E+1,8.3E+1]
	movaps	.LCPI3_22(%rip), %xmm15         # xmm15 = [8.4E+1,8.5E+1,8.6E+1,8.7E+1]
	movaps	.LCPI3_24(%rip), %xmm1          # xmm1 = [9.2E+1,9.3E+1,9.4E+1,9.5E+1]
	movaps	.LCPI3_25(%rip), %xmm6          # xmm6 = [9.6E+1,9.7E+1,9.8E+1,9.9E+1]
	movaps	.LCPI3_26(%rip), %xmm7          # xmm7 = [1.0E+2,1.01E+2,1.02E+2,1.03E+2]
	movaps	.LCPI3_27(%rip), %xmm8          # xmm8 = [1.04E+2,1.05E+2,1.06E+2,1.07E+2]
	movaps	.LCPI3_28(%rip), %xmm9          # xmm9 = [1.08E+2,1.09E+2,1.1E+2,1.11E+2]
	movaps	.LCPI3_29(%rip), %xmm10         # xmm10 = [1.12E+2,1.13E+2,1.14E+2,1.15E+2]
	movaps	.LCPI3_30(%rip), %xmm11         # xmm11 = [1.16E+2,1.17E+2,1.18E+2,1.19E+2]
	movaps	.LCPI3_31(%rip), %xmm12         # xmm12 = [1.2E+2,1.21E+2,1.22E+2,1.23E+2]
	.p2align	4, 0x90
.LBB3_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_2 Depth 2
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, -4(%rsp)                 # 4-byte Spill
	movq	%rdi, %rcx
	xorl	%edx, %edx
	movaps	.LCPI3_23(%rip), %xmm0          # xmm0 = [8.8E+1,8.9E+1,9.0E+1,9.1E+1]
	.p2align	4, 0x90
.LBB3_2:                                #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorps	%xmm5, %xmm5
	cvtsi2ss	%edx, %xmm5
	mulss	-4(%rsp), %xmm5                 # 4-byte Folded Reload
	shufps	$0, %xmm5, %xmm5                # xmm5 = xmm5[0,0,0,0]
	movaps	%xmm4, %xmm3
	movaps	%xmm5, %xmm4
	addps	.LCPI3_0(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -496(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_1(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -480(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_3(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -464(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_4(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -448(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_5(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -432(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_6(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -416(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_7(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -400(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_8(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -384(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_9(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -368(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_10(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -352(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_11(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -336(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_12(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -320(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_13(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -304(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_14(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -288(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_15(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -272(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_16(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -256(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_17(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -240(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_18(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -224(%rcx)
	movaps	%xmm5, %xmm4
	addps	.LCPI3_19(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -208(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm13, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -192(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm14, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -176(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm15, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -160(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm0, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -144(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm1, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -128(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm6, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -112(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm7, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -96(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm8, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -80(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm9, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -64(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm10, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -48(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm11, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -32(%rcx)
	movaps	%xmm5, %xmm4
	addps	%xmm12, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -16(%rcx)
	movaps	%xmm3, %xmm4
	addps	%xmm3, %xmm5
	mulps	%xmm2, %xmm5
	movups	%xmm5, (%rcx)
	incq	%rdx
	addq	$512, %rcx                      # imm = 0x200
	cmpq	$128, %rdx
	jne	.LBB3_2
# %bb.3:                                #   in Loop: Header=BB3_1 Depth=1
	incq	%rax
	addq	$65536, %rdi                    # imm = 0x10000
	cmpq	$128, %rax
	jne	.LBB3_1
# %bb.4:
	addq	$496, %rsi                      # imm = 0x1F0
	xorl	%eax, %eax
	movaps	.LCPI3_20(%rip), %xmm11         # xmm11 = [7.6E+1,7.7E+1,7.8E+1,7.9E+1]
	movaps	.LCPI3_21(%rip), %xmm12         # xmm12 = [8.0E+1,8.1E+1,8.2E+1,8.3E+1]
	movaps	.LCPI3_22(%rip), %xmm13         # xmm13 = [8.4E+1,8.5E+1,8.6E+1,8.7E+1]
	movaps	.LCPI3_23(%rip), %xmm14         # xmm14 = [8.8E+1,8.9E+1,9.0E+1,9.1E+1]
	movaps	.LCPI3_24(%rip), %xmm0          # xmm0 = [9.2E+1,9.3E+1,9.4E+1,9.5E+1]
	movaps	.LCPI3_25(%rip), %xmm1          # xmm1 = [9.6E+1,9.7E+1,9.8E+1,9.9E+1]
	movaps	.LCPI3_26(%rip), %xmm15         # xmm15 = [1.0E+2,1.01E+2,1.02E+2,1.03E+2]
	movaps	.LCPI3_27(%rip), %xmm5          # xmm5 = [1.04E+2,1.05E+2,1.06E+2,1.07E+2]
	movaps	.LCPI3_28(%rip), %xmm6          # xmm6 = [1.08E+2,1.09E+2,1.1E+2,1.11E+2]
	movaps	.LCPI3_29(%rip), %xmm7          # xmm7 = [1.12E+2,1.13E+2,1.14E+2,1.15E+2]
	movaps	.LCPI3_30(%rip), %xmm8          # xmm8 = [1.16E+2,1.17E+2,1.18E+2,1.19E+2]
	movaps	.LCPI3_31(%rip), %xmm9          # xmm9 = [1.2E+2,1.21E+2,1.22E+2,1.23E+2]
	.p2align	4, 0x90
.LBB3_5:                                # =>This Inner Loop Header: Depth=1
	xorps	%xmm10, %xmm10
	cvtsi2ss	%eax, %xmm10
	shufps	$0, %xmm10, %xmm10              # xmm10 = xmm10[0,0,0,0]
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_0(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -496(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_1(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -480(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_3(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -464(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_4(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -448(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_5(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -432(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_6(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -416(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_7(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -400(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_8(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -384(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_9(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -368(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_10(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -352(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_11(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -336(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_12(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -320(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_13(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -304(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_14(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -288(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_15(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -272(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_16(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -256(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_17(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -240(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_18(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -224(%rsi)
	movaps	%xmm10, %xmm4
	mulps	.LCPI3_19(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -208(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm11, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -192(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm12, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -176(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm13, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -160(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm14, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -144(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm0, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -128(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm1, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -112(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm15, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -96(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm5, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -80(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm6, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -64(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm7, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -48(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm8, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -32(%rsi)
	movaps	%xmm10, %xmm4
	mulps	%xmm9, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -16(%rsi)
	movaps	%xmm3, %xmm4
	mulps	%xmm3, %xmm10
	mulps	%xmm2, %xmm10
	movups	%xmm10, (%rsi)
	incq	%rax
	addq	$512, %rsi                      # imm = 0x200
	cmpq	$128, %rax
	jne	.LBB3_5
# %bb.6:
	retq
.Lfunc_end3:
	.size	_Z10init_arrayPfS_, .Lfunc_end3-_Z10init_arrayPfS_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _Z14compareResultsPfS_
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
	.text
	.globl	_Z14compareResultsPfS_
	.p2align	4, 0x90
	.type	_Z14compareResultsPfS_,@function
_Z14compareResultsPfS_:                 # @_Z14compareResultsPfS_
	.cfi_startproc
# %bb.0:
	addq	$16, %rsi
	addq	$16, %rdi
	xorl	%ecx, %ecx
	movaps	.LCPI4_0(%rip), %xmm1           # xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	movapd	.LCPI4_1(%rip), %xmm4           # xmm4 = [1.0E-2,1.0E-2]
	movaps	.LCPI4_3(%rip), %xmm3           # xmm3 = [1.0E+2,1.0E+2,1.0E+2,1.0E+2]
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_2 Depth 2
                                        #       Child Loop BB4_3 Depth 3
	movq	%rdi, %rdx
	movq	%rsi, %r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB4_2:                                #   Parent Loop BB4_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_3 Depth 3
	movd	%eax, %xmm6
	pxor	%xmm5, %xmm5
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_3:                                #   Parent Loop BB4_1 Depth=1
                                        #     Parent Loop BB4_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movups	-16(%rdx,%rax,4), %xmm9
	movups	(%rdx,%rax,4), %xmm8
	movups	-16(%r8,%rax,4), %xmm14
	movups	(%r8,%rax,4), %xmm13
	movaps	%xmm9, %xmm10
	xorps	%xmm1, %xmm10
	movaps	%xmm8, %xmm7
	xorps	%xmm1, %xmm7
	maxps	%xmm9, %xmm10
	maxps	%xmm8, %xmm7
	cvtps2pd	%xmm10, %xmm12
	movhlps	%xmm10, %xmm10                  # xmm10 = xmm10[1,1]
	movaps	%xmm14, %xmm11
	cvtps2pd	%xmm7, %xmm2
	xorps	%xmm1, %xmm11
	maxps	%xmm14, %xmm11
	cvtps2pd	%xmm10, %xmm15
	cvtps2pd	%xmm11, %xmm10
	movhlps	%xmm11, %xmm11                  # xmm11 = xmm11[1,1]
	cmpltpd	%xmm4, %xmm15
	cvtps2pd	%xmm11, %xmm11
	cmpltpd	%xmm4, %xmm11
	andpd	%xmm15, %xmm11
	movaps	%xmm13, %xmm15
	xorps	%xmm1, %xmm15
	maxps	%xmm13, %xmm15
	cmpltpd	%xmm4, %xmm12
	cmpltpd	%xmm4, %xmm10
	andpd	%xmm12, %xmm10
	cvtps2pd	%xmm15, %xmm12
	cmpltpd	%xmm4, %xmm2
	cmpltpd	%xmm4, %xmm12
	andpd	%xmm2, %xmm12
	movaps	%xmm9, %xmm2
	subps	%xmm14, %xmm2
	movaps	%xmm8, %xmm14
	subps	%xmm13, %xmm14
	movaps	%xmm2, %xmm13
	xorps	%xmm1, %xmm13
	maxps	%xmm2, %xmm13
	movaps	%xmm14, %xmm2
	xorps	%xmm1, %xmm2
	maxps	%xmm14, %xmm2
	movaps	.LCPI4_2(%rip), %xmm0           # xmm0 = [9.99999993E-9,9.99999993E-9,9.99999993E-9,9.99999993E-9]
	addps	%xmm0, %xmm9
	movaps	%xmm9, %xmm14
	xorps	%xmm1, %xmm14
	maxps	%xmm9, %xmm14
	addps	%xmm0, %xmm8
	divps	%xmm14, %xmm13
	movaps	%xmm8, %xmm9
	xorps	%xmm1, %xmm9
	maxps	%xmm8, %xmm9
	divps	%xmm9, %xmm2
	movaps	%xmm13, %xmm8
	xorps	%xmm1, %xmm8
	maxps	%xmm13, %xmm8
	movapd	.LCPI4_4(%rip), %xmm0           # xmm0 = [5.0000000000000003E-2,5.0000000000000003E-2]
	movaps	%xmm2, %xmm9
	xorps	%xmm1, %xmm9
	maxps	%xmm2, %xmm9
	movhlps	%xmm7, %xmm7                    # xmm7 = xmm7[1,1]
	cvtps2pd	%xmm7, %xmm2
	movhlps	%xmm15, %xmm15                  # xmm15 = xmm15[1,1]
	cvtps2pd	%xmm15, %xmm7
	cmpltpd	%xmm4, %xmm2
	cmpltpd	%xmm4, %xmm7
	mulps	%xmm3, %xmm8
	mulps	%xmm3, %xmm9
	andpd	%xmm2, %xmm7
	cvtps2pd	%xmm8, %xmm2
	movhlps	%xmm8, %xmm8                    # xmm8 = xmm8[1,1]
	andnpd	%xmm2, %xmm10
	cvtps2pd	%xmm9, %xmm2
	cvtps2pd	%xmm8, %xmm8
	andnpd	%xmm8, %xmm11
	movhlps	%xmm9, %xmm9                    # xmm9 = xmm9[1,1]
	cvtps2pd	%xmm9, %xmm8
	andnpd	%xmm2, %xmm12
	andnpd	%xmm8, %xmm7
	movapd	%xmm0, %xmm2
	cmpltpd	%xmm10, %xmm2
	movapd	%xmm0, %xmm8
	cmpltpd	%xmm11, %xmm8
	packssdw	%xmm8, %xmm2
	movapd	%xmm0, %xmm8
	cmpltpd	%xmm12, %xmm8
	movapd	%xmm0, %xmm9
	cmpltpd	%xmm7, %xmm9
	psubd	%xmm2, %xmm6
	packssdw	%xmm9, %xmm8
	psubd	%xmm8, %xmm5
	addq	$8, %rax
	cmpq	$128, %rax
	jne	.LBB4_3
# %bb.4:                                #   in Loop: Header=BB4_2 Depth=2
	paddd	%xmm6, %xmm5
	pshufd	$238, %xmm5, %xmm2              # xmm2 = xmm5[2,3,2,3]
	paddd	%xmm5, %xmm2
	pshufd	$85, %xmm2, %xmm5               # xmm5 = xmm2[1,1,1,1]
	paddd	%xmm2, %xmm5
	movd	%xmm5, %eax
	incq	%r9
	addq	$512, %r8                       # imm = 0x200
	addq	$512, %rdx                      # imm = 0x200
	cmpq	$128, %r9
	jne	.LBB4_2
# %bb.5:                                #   in Loop: Header=BB4_1 Depth=1
	incq	%rcx
	addq	$65536, %rsi                    # imm = 0x10000
	addq	$65536, %rdi                    # imm = 0x10000
	cmpq	$128, %rcx
	jne	.LBB4_1
# %bb.6:
	movl	$.L.str, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	jmp	printf                          # TAILCALL
.Lfunc_end4:
	.size	_Z14compareResultsPfS_, .Lfunc_end4-_Z14compareResultsPfS_
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
	.globl	_Z30__device_stub__doitgen_kernel1PfS_S_i # -- Begin function _Z30__device_stub__doitgen_kernel1PfS_S_i
	.p2align	4, 0x90
	.type	_Z30__device_stub__doitgen_kernel1PfS_S_i,@function
_Z30__device_stub__doitgen_kernel1PfS_S_i: # @_Z30__device_stub__doitgen_kernel1PfS_S_i
	.cfi_startproc
# %bb.0:
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movq	%rdx, 56(%rsp)
	movl	%ecx, 4(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 104(%rsp)
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
	movl	$_Z15doitgen_kernel1PfS_S_i, %edi
	pushq	8(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	24(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$136, %rsp
	.cfi_adjust_cfa_offset -136
	retq
.Lfunc_end6:
	.size	_Z30__device_stub__doitgen_kernel1PfS_S_i, .Lfunc_end6-_Z30__device_stub__doitgen_kernel1PfS_S_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z30__device_stub__doitgen_kernel2PfS_S_i # -- Begin function _Z30__device_stub__doitgen_kernel2PfS_S_i
	.p2align	4, 0x90
	.type	_Z30__device_stub__doitgen_kernel2PfS_S_i,@function
_Z30__device_stub__doitgen_kernel2PfS_S_i: # @_Z30__device_stub__doitgen_kernel2PfS_S_i
	.cfi_startproc
# %bb.0:
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movq	%rdx, 56(%rsp)
	movl	%ecx, 4(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 104(%rsp)
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
	movl	$_Z15doitgen_kernel2PfS_S_i, %edi
	pushq	8(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	24(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$136, %rsp
	.cfi_adjust_cfa_offset -136
	retq
.Lfunc_end7:
	.size	_Z30__device_stub__doitgen_kernel2PfS_S_i, .Lfunc_end7-_Z30__device_stub__doitgen_kernel2PfS_S_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z11doitgenCudaPfS_S_S_         # -- Begin function _Z11doitgenCudaPfS_S_S_
	.p2align	4, 0x90
	.type	_Z11doitgenCudaPfS_S_S_,@function
_Z11doitgenCudaPfS_S_S_:                # @_Z11doitgenCudaPfS_S_S_
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
	subq	$168, %rsp
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 160(%rsp)                 # 8-byte Spill
	movq	%rdx, %rbx
	movq	%rsi, %r12
	movq	%rdi, %r13
	movabsq	$68719476740, %r14              # imm = 0x1000000004
	movabsq	$34359738400, %r15              # imm = 0x800000020
	leaq	32(%rsp), %rdi
	movl	$8388608, %esi                  # imm = 0x800000
	callq	hipMalloc
	leaq	24(%rsp), %rdi
	movl	$65536, %esi                    # imm = 0x10000
	callq	hipMalloc
	leaq	8(%rsp), %rdi
	movl	$8388608, %esi                  # imm = 0x800000
	callq	hipMalloc
	movq	32(%rsp), %rdi
	movl	$8388608, %edx                  # imm = 0x800000
	movq	%r13, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	24(%rsp), %rdi
	movl	$65536, %edx                    # imm = 0x10000
	movq	%r12, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	movq	8(%rsp), %rdi
	movl	$8388608, %edx                  # imm = 0x800000
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	hipMemcpy
	leaq	104(%rsp), %rdi
	callq	hipEventCreate
	leaq	40(%rsp), %rdi
	callq	hipEventCreate
	movl	$1065353216, 20(%rsp)           # imm = 0x3F800000
	movq	104(%rsp), %rdi
	xorl	%r13d, %r13d
	xorl	%esi, %esi
	callq	hipEventRecord
	leaq	120(%rsp), %rbp
	leaq	112(%rsp), %rbx
	leaq	128(%rsp), %r12
	jmp	.LBB8_1
	.p2align	4, 0x90
.LBB8_5:                                #   in Loop: Header=BB8_1 Depth=1
	incl	%r13d
	cmpl	$128, %r13d
	je	.LBB8_6
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	movq	%r14, %rdi
	movl	$1, %esi
	movq	%r15, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB8_3
# %bb.2:                                #   in Loop: Header=BB8_1 Depth=1
	movq	8(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 96(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rdx, 80(%rsp)
	movl	%r13d, 4(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	movl	$_Z15doitgen_kernel1PfS_S_i, %edi
	movq	%r12, %r9
	pushq	112(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	128(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB8_3:                                #   in Loop: Header=BB8_1 Depth=1
	movq	%r14, %rdi
	movl	$1, %esi
	movq	%r15, %rdx
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB8_5
# %bb.4:                                #   in Loop: Header=BB8_1 Depth=1
	movq	8(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 96(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rdx, 80(%rsp)
	movl	%r13d, 4(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	4(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	64(%rsp), %rdi
	leaq	48(%rsp), %rsi
	movq	%rbp, %rdx
	movq	%rbx, %rcx
	callq	__hipPopCallConfiguration
	movq	64(%rsp), %rsi
	movl	72(%rsp), %edx
	movq	48(%rsp), %rcx
	movl	56(%rsp), %r8d
	movl	$_Z15doitgen_kernel2PfS_S_i, %edi
	movq	%r12, %r9
	pushq	112(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	128(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	jmp	.LBB8_5
.LBB8_6:
	movq	40(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipEventRecord
	movq	40(%rsp), %rdi
	callq	hipEventSynchronize
	movq	104(%rsp), %rsi
	movq	40(%rsp), %rdx
	leaq	20(%rsp), %rdi
	callq	hipEventElapsedTime
	movss	20(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.2, %edi
	movb	$1, %al
	callq	printf
	movq	8(%rsp), %rsi
	movl	$8388608, %edx                  # imm = 0x800000
	movq	160(%rsp), %rdi                 # 8-byte Reload
	movl	$2, %ecx
	callq	hipMemcpy
	movq	32(%rsp), %rdi
	callq	hipFree
	movq	24(%rsp), %rdi
	callq	hipFree
	movq	8(%rsp), %rdi
	callq	hipFree
	addq	$168, %rsp
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
	.size	_Z11doitgenCudaPfS_S_S_, .Lfunc_end8-_Z11doitgenCudaPfS_S_S_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function main
.LCPI9_0:
	.long	0x00000000                      # float 0
	.long	0x3f800000                      # float 1
	.long	0x40000000                      # float 2
	.long	0x40400000                      # float 3
.LCPI9_1:
	.long	0x40800000                      # float 4
	.long	0x40a00000                      # float 5
	.long	0x40c00000                      # float 6
	.long	0x40e00000                      # float 7
.LCPI9_2:
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
	.long	0x3c000000                      # float 0.0078125
.LCPI9_3:
	.long	0x41000000                      # float 8
	.long	0x41100000                      # float 9
	.long	0x41200000                      # float 10
	.long	0x41300000                      # float 11
.LCPI9_4:
	.long	0x41400000                      # float 12
	.long	0x41500000                      # float 13
	.long	0x41600000                      # float 14
	.long	0x41700000                      # float 15
.LCPI9_5:
	.long	0x41800000                      # float 16
	.long	0x41880000                      # float 17
	.long	0x41900000                      # float 18
	.long	0x41980000                      # float 19
.LCPI9_6:
	.long	0x41a00000                      # float 20
	.long	0x41a80000                      # float 21
	.long	0x41b00000                      # float 22
	.long	0x41b80000                      # float 23
.LCPI9_7:
	.long	0x41c00000                      # float 24
	.long	0x41c80000                      # float 25
	.long	0x41d00000                      # float 26
	.long	0x41d80000                      # float 27
.LCPI9_8:
	.long	0x41e00000                      # float 28
	.long	0x41e80000                      # float 29
	.long	0x41f00000                      # float 30
	.long	0x41f80000                      # float 31
.LCPI9_9:
	.long	0x42000000                      # float 32
	.long	0x42040000                      # float 33
	.long	0x42080000                      # float 34
	.long	0x420c0000                      # float 35
.LCPI9_10:
	.long	0x42100000                      # float 36
	.long	0x42140000                      # float 37
	.long	0x42180000                      # float 38
	.long	0x421c0000                      # float 39
.LCPI9_11:
	.long	0x42200000                      # float 40
	.long	0x42240000                      # float 41
	.long	0x42280000                      # float 42
	.long	0x422c0000                      # float 43
.LCPI9_12:
	.long	0x42300000                      # float 44
	.long	0x42340000                      # float 45
	.long	0x42380000                      # float 46
	.long	0x423c0000                      # float 47
.LCPI9_13:
	.long	0x42400000                      # float 48
	.long	0x42440000                      # float 49
	.long	0x42480000                      # float 50
	.long	0x424c0000                      # float 51
.LCPI9_14:
	.long	0x42500000                      # float 52
	.long	0x42540000                      # float 53
	.long	0x42580000                      # float 54
	.long	0x425c0000                      # float 55
.LCPI9_15:
	.long	0x42600000                      # float 56
	.long	0x42640000                      # float 57
	.long	0x42680000                      # float 58
	.long	0x426c0000                      # float 59
.LCPI9_16:
	.long	0x42700000                      # float 60
	.long	0x42740000                      # float 61
	.long	0x42780000                      # float 62
	.long	0x427c0000                      # float 63
.LCPI9_17:
	.long	0x42800000                      # float 64
	.long	0x42820000                      # float 65
	.long	0x42840000                      # float 66
	.long	0x42860000                      # float 67
.LCPI9_18:
	.long	0x42880000                      # float 68
	.long	0x428a0000                      # float 69
	.long	0x428c0000                      # float 70
	.long	0x428e0000                      # float 71
.LCPI9_19:
	.long	0x42900000                      # float 72
	.long	0x42920000                      # float 73
	.long	0x42940000                      # float 74
	.long	0x42960000                      # float 75
.LCPI9_20:
	.long	0x42980000                      # float 76
	.long	0x429a0000                      # float 77
	.long	0x429c0000                      # float 78
	.long	0x429e0000                      # float 79
.LCPI9_21:
	.long	0x42a00000                      # float 80
	.long	0x42a20000                      # float 81
	.long	0x42a40000                      # float 82
	.long	0x42a60000                      # float 83
.LCPI9_22:
	.long	0x42a80000                      # float 84
	.long	0x42aa0000                      # float 85
	.long	0x42ac0000                      # float 86
	.long	0x42ae0000                      # float 87
.LCPI9_23:
	.long	0x42b00000                      # float 88
	.long	0x42b20000                      # float 89
	.long	0x42b40000                      # float 90
	.long	0x42b60000                      # float 91
.LCPI9_24:
	.long	0x42b80000                      # float 92
	.long	0x42ba0000                      # float 93
	.long	0x42bc0000                      # float 94
	.long	0x42be0000                      # float 95
.LCPI9_25:
	.long	0x42c00000                      # float 96
	.long	0x42c20000                      # float 97
	.long	0x42c40000                      # float 98
	.long	0x42c60000                      # float 99
.LCPI9_26:
	.long	0x42c80000                      # float 100
	.long	0x42ca0000                      # float 101
	.long	0x42cc0000                      # float 102
	.long	0x42ce0000                      # float 103
.LCPI9_27:
	.long	0x42d00000                      # float 104
	.long	0x42d20000                      # float 105
	.long	0x42d40000                      # float 106
	.long	0x42d60000                      # float 107
.LCPI9_28:
	.long	0x42d80000                      # float 108
	.long	0x42da0000                      # float 109
	.long	0x42dc0000                      # float 110
	.long	0x42de0000                      # float 111
.LCPI9_29:
	.long	0x42e00000                      # float 112
	.long	0x42e20000                      # float 113
	.long	0x42e40000                      # float 114
	.long	0x42e60000                      # float 115
.LCPI9_30:
	.long	0x42e80000                      # float 116
	.long	0x42ea0000                      # float 117
	.long	0x42ec0000                      # float 118
	.long	0x42ee0000                      # float 119
.LCPI9_31:
	.long	0x42f00000                      # float 120
	.long	0x42f20000                      # float 121
	.long	0x42f40000                      # float 122
	.long	0x42f60000                      # float 123
.LCPI9_32:
	.long	0x42f80000                      # float 124
	.long	0x42fa0000                      # float 125
	.long	0x42fc0000                      # float 126
	.long	0x42fe0000                      # float 127
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %rbx
	movl	$65536, %edi                    # imm = 0x10000
	callq	malloc
	movq	%rax, %r14
	movq	%rax, (%rsp)                    # 8-byte Spill
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %r15
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	leaq	496(%rbx), %rdi
	xorl	%ecx, %ecx
	movaps	.LCPI9_2(%rip), %xmm2           # xmm2 = [7.8125E-3,7.8125E-3,7.8125E-3,7.8125E-3]
	movaps	.LCPI9_32(%rip), %xmm4          # xmm4 = [1.24E+2,1.25E+2,1.26E+2,1.27E+2]
	movaps	.LCPI9_20(%rip), %xmm13         # xmm13 = [7.6E+1,7.7E+1,7.8E+1,7.9E+1]
	movaps	.LCPI9_21(%rip), %xmm14         # xmm14 = [8.0E+1,8.1E+1,8.2E+1,8.3E+1]
	movaps	.LCPI9_22(%rip), %xmm15         # xmm15 = [8.4E+1,8.5E+1,8.6E+1,8.7E+1]
	movaps	.LCPI9_24(%rip), %xmm1          # xmm1 = [9.2E+1,9.3E+1,9.4E+1,9.5E+1]
	movaps	.LCPI9_25(%rip), %xmm6          # xmm6 = [9.6E+1,9.7E+1,9.8E+1,9.9E+1]
	movaps	.LCPI9_26(%rip), %xmm7          # xmm7 = [1.0E+2,1.01E+2,1.02E+2,1.03E+2]
	movaps	.LCPI9_27(%rip), %xmm8          # xmm8 = [1.04E+2,1.05E+2,1.06E+2,1.07E+2]
	movaps	.LCPI9_28(%rip), %xmm9          # xmm9 = [1.08E+2,1.09E+2,1.1E+2,1.11E+2]
	movaps	.LCPI9_29(%rip), %xmm10         # xmm10 = [1.12E+2,1.13E+2,1.14E+2,1.15E+2]
	movaps	.LCPI9_30(%rip), %xmm11         # xmm11 = [1.16E+2,1.17E+2,1.18E+2,1.19E+2]
	movaps	.LCPI9_31(%rip), %xmm12         # xmm12 = [1.2E+2,1.21E+2,1.22E+2,1.23E+2]
	.p2align	4, 0x90
.LBB9_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB9_2 Depth 2
	cvtsi2ss	%ecx, %xmm0
	movss	%xmm0, 16(%rsp)                 # 4-byte Spill
	movq	%rdi, %rdx
	xorl	%esi, %esi
	movaps	.LCPI9_23(%rip), %xmm0          # xmm0 = [8.8E+1,8.9E+1,9.0E+1,9.1E+1]
	.p2align	4, 0x90
.LBB9_2:                                #   Parent Loop BB9_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorps	%xmm5, %xmm5
	cvtsi2ss	%esi, %xmm5
	mulss	16(%rsp), %xmm5                 # 4-byte Folded Reload
	shufps	$0, %xmm5, %xmm5                # xmm5 = xmm5[0,0,0,0]
	movaps	%xmm4, %xmm3
	movaps	%xmm5, %xmm4
	addps	.LCPI9_0(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -496(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_1(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -480(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_3(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -464(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_4(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -448(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_5(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -432(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_6(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -416(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_7(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -400(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_8(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -384(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_9(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -368(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_10(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -352(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_11(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -336(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_12(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -320(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_13(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -304(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_14(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -288(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_15(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -272(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_16(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -256(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_17(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -240(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_18(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -224(%rdx)
	movaps	%xmm5, %xmm4
	addps	.LCPI9_19(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -208(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm13, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -192(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm14, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -176(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm15, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -160(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm0, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -144(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm1, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -128(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm6, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -112(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm7, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -96(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm8, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -80(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm9, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -64(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm10, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -48(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm11, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -32(%rdx)
	movaps	%xmm5, %xmm4
	addps	%xmm12, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -16(%rdx)
	movaps	%xmm3, %xmm4
	addps	%xmm3, %xmm5
	mulps	%xmm2, %xmm5
	movups	%xmm5, (%rdx)
	incq	%rsi
	addq	$512, %rdx                      # imm = 0x200
	cmpq	$128, %rsi
	jne	.LBB9_2
# %bb.3:                                #   in Loop: Header=BB9_1 Depth=1
	incq	%rcx
	addq	$65536, %rdi                    # imm = 0x10000
	cmpq	$128, %rcx
	jne	.LBB9_1
# %bb.4:
	movq	(%rsp), %rcx                    # 8-byte Reload
	leaq	496(%rcx), %rdx
	xorl	%ecx, %ecx
	movaps	.LCPI9_20(%rip), %xmm11         # xmm11 = [7.6E+1,7.7E+1,7.8E+1,7.9E+1]
	movaps	.LCPI9_21(%rip), %xmm12         # xmm12 = [8.0E+1,8.1E+1,8.2E+1,8.3E+1]
	movaps	.LCPI9_22(%rip), %xmm13         # xmm13 = [8.4E+1,8.5E+1,8.6E+1,8.7E+1]
	movaps	.LCPI9_23(%rip), %xmm14         # xmm14 = [8.8E+1,8.9E+1,9.0E+1,9.1E+1]
	movaps	.LCPI9_24(%rip), %xmm0          # xmm0 = [9.2E+1,9.3E+1,9.4E+1,9.5E+1]
	movaps	.LCPI9_25(%rip), %xmm1          # xmm1 = [9.6E+1,9.7E+1,9.8E+1,9.9E+1]
	movaps	.LCPI9_26(%rip), %xmm15         # xmm15 = [1.0E+2,1.01E+2,1.02E+2,1.03E+2]
	movaps	.LCPI9_27(%rip), %xmm5          # xmm5 = [1.04E+2,1.05E+2,1.06E+2,1.07E+2]
	movaps	.LCPI9_28(%rip), %xmm6          # xmm6 = [1.08E+2,1.09E+2,1.1E+2,1.11E+2]
	movaps	.LCPI9_29(%rip), %xmm7          # xmm7 = [1.12E+2,1.13E+2,1.14E+2,1.15E+2]
	movaps	.LCPI9_30(%rip), %xmm8          # xmm8 = [1.16E+2,1.17E+2,1.18E+2,1.19E+2]
	movaps	.LCPI9_31(%rip), %xmm9          # xmm9 = [1.2E+2,1.21E+2,1.22E+2,1.23E+2]
	.p2align	4, 0x90
.LBB9_5:                                # =>This Inner Loop Header: Depth=1
	xorps	%xmm10, %xmm10
	cvtsi2ss	%ecx, %xmm10
	shufps	$0, %xmm10, %xmm10              # xmm10 = xmm10[0,0,0,0]
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_0(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -496(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_1(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -480(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_3(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -464(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_4(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -448(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_5(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -432(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_6(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -416(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_7(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -400(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_8(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -384(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_9(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -368(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_10(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -352(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_11(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -336(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_12(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -320(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_13(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -304(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_14(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -288(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_15(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -272(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_16(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -256(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_17(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -240(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_18(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -224(%rdx)
	movaps	%xmm10, %xmm4
	mulps	.LCPI9_19(%rip), %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -208(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm11, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -192(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm12, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -176(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm13, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -160(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm14, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -144(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm0, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -128(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm1, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -112(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm15, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -96(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm5, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -80(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm6, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -64(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm7, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -48(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm8, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -32(%rdx)
	movaps	%xmm10, %xmm4
	mulps	%xmm9, %xmm4
	mulps	%xmm2, %xmm4
	movups	%xmm4, -16(%rdx)
	movaps	%xmm3, %xmm4
	mulps	%xmm3, %xmm10
	mulps	%xmm2, %xmm10
	movups	%xmm10, (%rdx)
	incq	%rcx
	addq	$512, %rdx                      # imm = 0x200
	cmpq	$128, %rcx
	jne	.LBB9_5
# %bb.6:
	movq	8(%rsp), %rbx                   # 8-byte Reload
	movq	%rbx, %rdi
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	movq	%r14, %rsi
	movq	%r15, %rdx
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rax, %rcx
	callq	_Z11doitgenCudaPfS_S_S_
	addq	$4, %rbx
	addq	$512, (%rsp)                    # 8-byte Folded Spill
                                        # imm = 0x200
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB9_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB9_8 Depth 2
                                        #       Child Loop BB9_9 Depth 3
                                        #         Child Loop BB9_10 Depth 4
	movq	%rbp, %r14
	shlq	$16, %r14
	movq	%rbp, %r12
	shlq	$14, %r12
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB9_8:                                #   Parent Loop BB9_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB9_9 Depth 3
                                        #         Child Loop BB9_10 Depth 4
	movq	%r13, %rsi
	shlq	$9, %rsi
	addq	%r14, %rsi
	movq	8(%rsp), %rax                   # 8-byte Reload
	leaq	(%rax,%rsi), %rdi
	addq	%r15, %rsi
	movq	%r13, %rax
	shlq	$7, %rax
	addq	%r12, %rax
	movq	(%rsp), %rcx                    # 8-byte Reload
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB9_9:                                #   Parent Loop BB9_7 Depth=1
                                        #     Parent Loop BB9_8 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB9_10 Depth 4
	leaq	(%rdx,%rax), %r8
	xorps	%xmm0, %xmm0
	movq	%rcx, %r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_10:                               #   Parent Loop BB9_7 Depth=1
                                        #     Parent Loop BB9_8 Depth=2
                                        #       Parent Loop BB9_9 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movss	-4(%rbx,%r10,4), %xmm1          # xmm1 = mem[0],zero,zero,zero
	mulss	-512(%r9), %xmm1
	addss	%xmm0, %xmm1
	movss	(%rbx,%r10,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	mulss	(%r9), %xmm0
	addss	%xmm1, %xmm0
	addq	$2, %r10
	addq	$1024, %r9                      # imm = 0x400
	cmpq	$128, %r10
	jne	.LBB9_10
# %bb.11:                               #   in Loop: Header=BB9_9 Depth=3
	movss	%xmm0, (%r15,%r8,4)
	incq	%rdx
	addq	$4, %rcx
	cmpq	$128, %rdx
	jne	.LBB9_9
# %bb.12:                               #   in Loop: Header=BB9_8 Depth=2
	movl	$512, %edx                      # imm = 0x200
	callq	memcpy@PLT
	incq	%r13
	addq	$512, %rbx                      # imm = 0x200
	cmpq	$128, %r13
	jne	.LBB9_8
# %bb.13:                               #   in Loop: Header=BB9_7 Depth=1
	incq	%rbp
	movq	16(%rsp), %rbx                  # 8-byte Reload
	addq	$65536, %rbx                    # imm = 0x10000
	cmpq	$128, %rbp
	jne	.LBB9_7
# %bb.14:
	movq	8(%rsp), %rdi                   # 8-byte Reload
	callq	free
	movq	32(%rsp), %rdi                  # 8-byte Reload
	callq	free
	movq	%r15, %rdi
	callq	free
	movq	24(%rsp), %rdi                  # 8-byte Reload
	callq	free
	xorl	%eax, %eax
	addq	$40, %rsp
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
.Lfunc_end9:
	.size	main, .Lfunc_end9-main
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
	.text
	.globl	_Z21polybench_timer_startv
	.p2align	4, 0x90
	.type	_Z21polybench_timer_startv,@function
_Z21polybench_timer_startv:             # @_Z21polybench_timer_startv
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
	jb	.LBB12_4
# %bb.3:
	movq	%rax, %rdi
	callq	free
	movq	$0, polybench_t_start(%rip)
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.LBB12_4:
	.cfi_def_cfa_offset 16
	movl	$.L.str.3, %edi
	movl	$.L.str.4, %esi
	movl	$.L__PRETTY_FUNCTION__._Z21polybench_flush_cachev, %ecx
	movl	$96, %edx
	callq	__assert_fail
.Lfunc_end12:
	.size	_Z21polybench_timer_startv, .Lfunc_end12-_Z21polybench_timer_startv
	.cfi_endproc
                                        # -- End function
	.globl	_Z20polybench_timer_stopv       # -- Begin function _Z20polybench_timer_stopv
	.p2align	4, 0x90
	.type	_Z20polybench_timer_stopv,@function
_Z20polybench_timer_stopv:              # @_Z20polybench_timer_stopv
	.cfi_startproc
# %bb.0:
	movq	$0, polybench_t_end(%rip)
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
	je	.LBB15_3
# %bb.1:
	testl	%ecx, %ecx
	jne	.LBB15_3
# %bb.2:
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB15_3:
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.6, %edi
	movl	$50, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %edi
	callq	exit
.Lfunc_end15:
	.size	_Z20polybench_alloc_datayi, .Lfunc_end15-_Z20polybench_alloc_datayi
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
	movl	$_Z15doitgen_kernel1PfS_S_i, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movq	%rbx, %rdi
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z15doitgen_kernel2PfS_S_i, %esi
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
	.asciz	"Number of misses: %d\n"
	.size	.L.str, 22

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"setting device %d with name %s\n"
	.size	.L.str.1, 32

	.type	_Z15doitgen_kernel1PfS_S_i,@object # @_Z15doitgen_kernel1PfS_S_i
	.section	.rodata,"a",@progbits
	.globl	_Z15doitgen_kernel1PfS_S_i
	.p2align	3, 0x0
_Z15doitgen_kernel1PfS_S_i:
	.quad	_Z30__device_stub__doitgen_kernel1PfS_S_i
	.size	_Z15doitgen_kernel1PfS_S_i, 8

	.type	_Z15doitgen_kernel2PfS_S_i,@object # @_Z15doitgen_kernel2PfS_S_i
	.globl	_Z15doitgen_kernel2PfS_S_i
	.p2align	3, 0x0
_Z15doitgen_kernel2PfS_S_i:
	.quad	_Z30__device_stub__doitgen_kernel2PfS_S_i
	.size	_Z15doitgen_kernel2PfS_S_i, 8

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
	.asciz	"[PolyBench] posix_memalign: cannot allocate memory"
	.size	.L.str.6, 51

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z15doitgen_kernel1PfS_S_i"
	.size	.L__unnamed_1, 27

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"_Z15doitgen_kernel2PfS_S_i"
	.size	.L__unnamed_2, 27

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
	.addrsig_sym _Z30__device_stub__doitgen_kernel1PfS_S_i
	.addrsig_sym _Z30__device_stub__doitgen_kernel2PfS_S_i
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Z15doitgen_kernel1PfS_S_i
	.addrsig_sym _Z15doitgen_kernel2PfS_S_i
	.addrsig_sym __hip_fatbin
	.addrsig_sym __hip_fatbin_wrapper
