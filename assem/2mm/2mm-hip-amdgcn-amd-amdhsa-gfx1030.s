	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.protected	_Z11mm2_kernel1iiiiffPfS_S_ ; -- Begin function _Z11mm2_kernel1iiiiffPfS_S_
	.globl	_Z11mm2_kernel1iiiiffPfS_S_
	.p2align	8
	.type	_Z11mm2_kernel1iiiiffPfS_S_,@function
_Z11mm2_kernel1iiiiffPfS_S_:            ; @_Z11mm2_kernel1iiiiffPfS_S_
; %bb.0:
	s_clause 0x1
	s_load_dword s8, s[4:5], 0x3c
	s_load_dwordx4 s[0:3], s[4:5], 0x0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s3, s8, 16
	s_and_b32 s8, s8, 0xffff
	v_mad_u64_u32 v[2:3], null, s7, s3, v[1:2]
	v_mad_u64_u32 v[0:1], null, s6, s8, v[0:1]
	v_cmp_gt_i32_e32 vcc_lo, s0, v2
	v_cmp_gt_i32_e64 s0, s1, v0
	s_and_b32 s0, vcc_lo, s0
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB0_4
; %bb.1:
	v_lshlrev_b32_e32 v4, 10, v2
	s_load_dwordx4 s[8:11], s[4:5], 0x18
	v_mov_b32_e32 v6, 0
	s_cmp_lt_i32 s2, 1
	v_add_nc_u32_e32 v1, v4, v0
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[2:3], 2, v[1:2]
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v2, vcc_lo, s8, v2
	v_add_co_ci_u32_e32 v3, vcc_lo, s9, v3, vcc_lo
	global_store_dword v[2:3], v6, off glc
	s_cbranch_scc1 .LBB0_4
; %bb.2:
	s_clause 0x1
	s_load_dwordx2 s[0:1], s[4:5], 0x28
	s_load_dword s3, s[4:5], 0x10
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshlrev_b64 v[4:5], 2, v[4:5]
	v_add_co_u32 v4, vcc_lo, s10, v4
	v_add_co_ci_u32_e32 v5, vcc_lo, s11, v5, vcc_lo
	.p2align	6
.LBB0_3:                                ; =>This Inner Loop Header: Depth=1
	v_ashrrev_i32_e32 v1, 31, v0
	s_add_i32 s2, s2, -1
	s_cmp_lg_u32 s2, 0
	v_lshlrev_b64 v[7:8], 2, v[0:1]
	global_load_dword v1, v[4:5], off glc
	v_add_nc_u32_e32 v0, 0x400, v0
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v7, vcc_lo, s0, v7
	v_add_co_ci_u32_e32 v8, vcc_lo, s1, v8, vcc_lo
	v_add_co_u32 v4, vcc_lo, v4, 4
	v_add_co_ci_u32_e32 v5, vcc_lo, 0, v5, vcc_lo
	global_load_dword v7, v[7:8], off glc
	s_waitcnt vmcnt(1)
	v_mul_f32_e32 v1, s3, v1
	s_waitcnt vmcnt(0)
	v_fmac_f32_e32 v6, v1, v7
	global_store_dword v[2:3], v6, off glc
	s_cbranch_scc1 .LBB0_3
.LBB0_4:
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z11mm2_kernel1iiiiffPfS_S_
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 304
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
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 9
		.amdhsa_next_free_sgpr 12
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
	.size	_Z11mm2_kernel1iiiiffPfS_S_, .Lfunc_end0-_Z11mm2_kernel1iiiiffPfS_S_
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 312
; NumSgprs: 14
; NumVgprs: 9
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 1
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 14
; NumVGPRsForWavesPerEU: 9
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 6
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.text
	.protected	_Z11mm2_kernel2iiiiffPfS_S_ ; -- Begin function _Z11mm2_kernel2iiiiffPfS_S_
	.globl	_Z11mm2_kernel2iiiiffPfS_S_
	.p2align	8
	.type	_Z11mm2_kernel2iiiiffPfS_S_,@function
_Z11mm2_kernel2iiiiffPfS_S_:            ; @_Z11mm2_kernel2iiiiffPfS_S_
; %bb.0:
	s_clause 0x2
	s_load_dword s0, s[4:5], 0x3c
	s_load_dwordx2 s[8:9], s[4:5], 0x0
	s_load_dword s1, s[4:5], 0xc
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s2, s0, 16
	s_and_b32 s0, s0, 0xffff
	v_mad_u64_u32 v[2:3], null, s7, s2, v[1:2]
	v_mad_u64_u32 v[0:1], null, s6, s0, v[0:1]
	v_cmp_gt_i32_e32 vcc_lo, s8, v2
	v_cmp_gt_i32_e64 s0, s1, v0
	s_and_b32 s0, vcc_lo, s0
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB1_4
; %bb.1:
	v_lshlrev_b32_e32 v4, 10, v2
	s_load_dwordx2 s[0:1], s[4:5], 0x28
	s_cmp_lt_i32 s9, 1
	v_add_nc_u32_e32 v1, v4, v0
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[2:3], 2, v[1:2]
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v2, vcc_lo, s0, v2
	v_add_co_ci_u32_e32 v3, vcc_lo, s1, v3, vcc_lo
	s_load_dword s0, s[4:5], 0x14
	global_load_dword v1, v[2:3], off glc
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_mul_f32_e32 v6, s0, v1
	global_store_dword v[2:3], v6, off glc
	s_cbranch_scc1 .LBB1_4
; %bb.2:
	s_load_dwordx4 s[0:3], s[4:5], 0x18
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshlrev_b64 v[4:5], 2, v[4:5]
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v4, vcc_lo, s0, v4
	v_add_co_ci_u32_e32 v5, vcc_lo, s1, v5, vcc_lo
	.p2align	6
.LBB1_3:                                ; =>This Inner Loop Header: Depth=1
	v_ashrrev_i32_e32 v1, 31, v0
	s_add_i32 s9, s9, -1
	s_cmp_lg_u32 s9, 0
	v_lshlrev_b64 v[7:8], 2, v[0:1]
	v_add_nc_u32_e32 v0, 0x400, v0
	v_add_co_u32 v7, vcc_lo, s2, v7
	v_add_co_ci_u32_e32 v8, vcc_lo, s3, v8, vcc_lo
	global_load_dword v1, v[4:5], off glc
	global_load_dword v7, v[7:8], off glc
	v_add_co_u32 v4, vcc_lo, v4, 4
	v_add_co_ci_u32_e32 v5, vcc_lo, 0, v5, vcc_lo
	s_waitcnt vmcnt(0)
	v_fmac_f32_e32 v6, v1, v7
	global_store_dword v[2:3], v6, off glc
	s_cbranch_scc1 .LBB1_3
.LBB1_4:
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z11mm2_kernel2iiiiffPfS_S_
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 304
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
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 9
		.amdhsa_next_free_sgpr 10
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
.Lfunc_end1:
	.size	_Z11mm2_kernel2iiiiffPfS_S_, .Lfunc_end1-_Z11mm2_kernel2iiiiffPfS_S_
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 320
; NumSgprs: 12
; NumVgprs: 9
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 1
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 12
; NumVGPRsForWavesPerEU: 9
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 6
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.text
	.p2alignl 6, 3214868480
	.fill 48, 4, 3214868480
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

	.protected	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE ; @_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE
	.type	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE,#alloc
	.weak	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE
_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE, 1

	.protected	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE ; @_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE
	.type	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE,#alloc
	.weak	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE
_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE, 1

	.protected	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE ; @_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE
	.type	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE,@object
	.section	.rodata._ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE,#alloc
	.weak	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE
_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE:
	.zero	1
	.size	_ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE, 1

	.ident	"AMD clang version 17.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.7.0 23352 d1e13c532a947d0cbfc94759c00dcf152294aa13)"
	.section	".note.GNU-stack"
	.addrsig
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1yE
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockDimE1yE
	.addrsig_sym _ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1yE
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .offset:         0
        .size:           4
        .value_kind:     by_value
      - .offset:         4
        .size:           4
        .value_kind:     by_value
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .offset:         12
        .size:           4
        .value_kind:     by_value
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
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
        .value_kind:     hidden_block_count_x
      - .offset:         52
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         60
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         62
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         64
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         66
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         68
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         70
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         112
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 304
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z11mm2_kernel1iiiiffPfS_S_
    .private_segment_fixed_size: 0
    .sgpr_count:     14
    .sgpr_spill_count: 0
    .symbol:         _Z11mm2_kernel1iiiiffPfS_S_.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     9
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .offset:         0
        .size:           4
        .value_kind:     by_value
      - .offset:         4
        .size:           4
        .value_kind:     by_value
      - .offset:         8
        .size:           4
        .value_kind:     by_value
      - .offset:         12
        .size:           4
        .value_kind:     by_value
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
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
        .value_kind:     hidden_block_count_x
      - .offset:         52
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         56
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         60
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         62
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         64
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         66
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         68
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         70
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         96
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         104
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         112
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 304
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z11mm2_kernel2iiiiffPfS_S_
    .private_segment_fixed_size: 0
    .sgpr_count:     12
    .sgpr_spill_count: 0
    .symbol:         _Z11mm2_kernel2iiiiffPfS_S_.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     9
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
