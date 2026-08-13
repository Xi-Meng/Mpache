	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.protected	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i ; -- Begin function _Z8spmv_jdsPfPKfPKiS3_S1_S3_i
	.globl	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i
	.p2align	8
	.type	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i,@function
_Z8spmv_jdsPfPKfPKiS3_S1_S3_i:          ; @_Z8spmv_jdsPfPKfPKiS3_S1_S3_i
; %bb.0:
	s_clause 0x1
	s_load_dword s0, s[4:5], 0x44
	s_load_dword s1, s[4:5], 0x30
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0xffff
	v_mad_u64_u32 v[0:1], null, s6, s0, v[0:1]
	s_mov_b32 s0, exec_lo
	v_cmpx_gt_i32_e64 s1, v0
	s_cbranch_execz .LBB0_8
; %bb.1:
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, jds_ptr_int@rel32@lo+4
	s_addc_u32 s1, s1, jds_ptr_int@rel32@hi+12
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, sh_zcnt_int@rel32@lo+4
	s_addc_u32 s3, s3, sh_zcnt_int@rel32@hi+12
	s_load_dword s0, s[0:1], 0x0
	s_load_dwordx8 s[8:15], s[4:5], 0x0
	s_waitcnt lgkmcnt(0)
	v_add_nc_u32_e32 v1, s0, v0
	s_load_dwordx2 s[0:1], s[4:5], 0x20
	s_mov_b32 s4, exec_lo
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	v_add_co_u32 v3, vcc_lo, s12, v1
	v_add_co_ci_u32_e32 v4, vcc_lo, s13, v2, vcc_lo
global_load_dword v5, v[3:4], off glc
	v_ashrrev_i32_e32 v3, 5, v0
	v_ashrrev_i32_e32 v4, 31, v3
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	v_add_co_u32 v3, vcc_lo, v3, s2
	v_add_co_ci_u32_e32 v4, vcc_lo, s3, v4, vcc_lo
	v_add_co_u32 v1, vcc_lo, s10, v1
	v_add_co_ci_u32_e32 v2, vcc_lo, s11, v2, vcc_lo
global_load_dword v4, v[3:4], off glc
	s_waitcnt vmcnt(1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v5, vcc_lo, s0, v5
	v_add_co_ci_u32_e32 v6, vcc_lo, s1, v6, vcc_lo
global_load_dword v7, v[1:2], off glc
global_load_dword v5, v[5:6], off glc
	v_mov_b32_e32 v6, 0
	s_waitcnt vmcnt(2)
	v_cmpx_lt_i32_e32 1, v4
	s_cbranch_execz .LBB0_7
; %bb.2:
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, jds_ptr_int@rel32@lo+8
	s_addc_u32 s3, s3, jds_ptr_int@rel32@hi+16
	v_mov_b32_e32 v6, 0
	s_load_dword s2, s[2:3], 0x0
	s_mov_b32 s5, exec_lo
	s_waitcnt lgkmcnt(0)
	v_add_nc_u32_e32 v1, s2, v0
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[8:9], 2, v[1:2]
	v_add_co_u32 v8, vcc_lo, s12, v8
	v_add_co_ci_u32_e32 v9, vcc_lo, s13, v9, vcc_lo
global_load_dword v3, v[8:9], off glc
	v_cmpx_ne_u32_e32 2, v4
	s_cbranch_execz .LBB0_6
; %bb.3:
	v_add_nc_u32_e32 v8, -2, v4
	v_mov_b32_e32 v6, 0
	s_mov_b32 s6, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, jds_ptr_int@rel32@lo+12
	s_addc_u32 s3, s3, jds_ptr_int@rel32@hi+20
	s_inst_prefetch 0x1
	s_waitcnt vmcnt(0)
	.p2align	6
.LBB0_4:                                ; =>This Inner Loop Header: Depth=1
	s_load_dword s7, s[2:3], 0x0
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	s_waitcnt vmcnt(0)
	v_ashrrev_i32_e32 v4, 31, v3
	v_mov_b32_e32 v13, v5
	v_add_nc_u32_e32 v8, -1, v8
	s_add_u32 s2, s2, 4
	s_addc_u32 s3, s3, 0
	v_lshlrev_b64 v[9:10], 2, v[3:4]
	v_add_co_u32 v3, vcc_lo, s10, v1
	v_add_co_ci_u32_e32 v4, vcc_lo, s11, v2, vcc_lo
	v_fmac_f32_e32 v6, v7, v13
	v_add_co_u32 v9, vcc_lo, s0, v9
	v_add_co_ci_u32_e32 v10, vcc_lo, s1, v10, vcc_lo
global_load_dword v4, v[3:4], off glc
	s_waitcnt lgkmcnt(0)
	v_add_nc_u32_e32 v1, s7, v0
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[11:12], 2, v[1:2]
	v_add_co_u32 v11, vcc_lo, s12, v11
	v_add_co_ci_u32_e32 v12, vcc_lo, s13, v12, vcc_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v8
global_load_dword v5, v[9:10], off glc
global_load_dword v3, v[11:12], off glc
	s_or_b32 s6, vcc_lo, s6
	s_waitcnt vmcnt(2)
	v_mov_b32_e32 v7, v4
	s_andn2_b32 exec_lo, exec_lo, s6
	s_cbranch_execnz .LBB0_4
; %bb.5:
	s_inst_prefetch 0x2
	s_or_b32 exec_lo, exec_lo, s6
	v_mov_b32_e32 v7, v4
.LBB0_6:
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_ashrrev_i32_e32 v4, 31, v3
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	v_fmac_f32_e32 v6, v7, v5
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	v_add_co_u32 v3, vcc_lo, s0, v3
	v_add_co_ci_u32_e32 v4, vcc_lo, s1, v4, vcc_lo
	v_add_co_u32 v1, vcc_lo, s10, v1
	v_add_co_ci_u32_e32 v2, vcc_lo, s11, v2, vcc_lo
global_load_dword v3, v[3:4], off glc
global_load_dword v1, v[1:2], off glc
	s_waitcnt vmcnt(1)
	v_mov_b32_e32 v5, v3
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v7, v1
.LBB0_7:
	s_or_b32 exec_lo, exec_lo, s4
	v_ashrrev_i32_e32 v1, 31, v0
	s_waitcnt vmcnt(0)
	v_fmac_f32_e32 v6, v7, v5
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s14, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, s15, v1, vcc_lo
global_load_dword v0, v[0:1], off glc
	s_waitcnt vmcnt(0)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s8, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, s9, v1, vcc_lo
global_store_dword v[0:1], v6, off glc
.LBB0_8:
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z8spmv_jdsPfPKfPKiS3_S1_S3_i
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 312
		.amdhsa_user_sgpr_count 6
		.amdhsa_user_sgpr_private_segment_buffer 1
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_flat_scratch_init 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_system_sgpr_private_segment_wavefront_offset 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 14
		.amdhsa_next_free_sgpr 16
		.amdhsa_reserve_flat_scratch 0
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 0
		.amdhsa_shared_vgpr_count 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end0:
	.size	_Z8spmv_jdsPfPKfPKiS3_S1_S3_i, .Lfunc_end0-_Z8spmv_jdsPfPKfPKiS3_S1_S3_i
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 792
; NumSgprs: 18
; NumVgprs: 14
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 2
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 14
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 6
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 6, 3214868480
	.fill 48, 4, 3214868480
	.protected	jds_ptr_int             ; @jds_ptr_int
	.type	jds_ptr_int,@object
	.section	.bss,#alloc,#write
	.globl	jds_ptr_int
	.p2align	4, 0x0
jds_ptr_int:
	.zero	20000
	.size	jds_ptr_int, 20000

	.protected	sh_zcnt_int             ; @sh_zcnt_int
	.type	sh_zcnt_int,@object
	.globl	sh_zcnt_int
	.p2align	4, 0x0
sh_zcnt_int:
	.zero	20000
	.size	sh_zcnt_int, 20000

	.protected	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE ; @_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE
	.type	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE,#alloc
	.weak	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE
_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE, 1

	.protected	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE ; @_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE
	.type	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE,#alloc
	.weak	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE
_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE, 1

	.protected	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE ; @_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE
	.type	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE,#alloc
	.weak	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE
_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE, 1

	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack"
	.addrsig
	.addrsig_sym jds_ptr_int
	.addrsig_sym sh_zcnt_int
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         32
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         40
        .size:           8
        .value_kind:     global_buffer
      - .offset:         48
        .size:           4
        .value_kind:     by_value
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         60
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         64
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         68
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         70
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         72
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         74
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         76
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         78
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         112
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         120
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 312
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z8spmv_jdsPfPKfPKiS3_S1_S3_i
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z8spmv_jdsPfPKfPKiS3_S1_S3_i.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     14
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
