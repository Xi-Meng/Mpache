	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.protected	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii ; -- Begin function _Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.globl	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
	.p2align	8
	.type	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii,@function
_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii: ; @_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
; %bb.0:
	s_clause 0x1
	s_load_dword s0, s[4:5], 0x2c
	s_load_dwordx2 s[2:3], s[4:5], 0x18
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0xffff
	v_mad_u64_u32 v[0:1], null, s6, s0, v[0:1]
	s_mov_b32 s0, exec_lo
	v_cmpx_gt_i32_e64 s2, v0
	s_cbranch_execz .LBB0_9
; %bb.1:
	s_load_dwordx2 s[0:1], s[4:5], 0x10
	s_cmp_lt_i32 s3, 1
	s_cbranch_scc1 .LBB0_4
; %bb.2:
	s_load_dwordx4 s[4:7], s[4:5], 0x0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 3, v[0:1]
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v0, vcc_lo, s4, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo
	s_add_u32 s4, s6, 4
	s_addc_u32 s5, s7, 0
global_load_dwordx2 v[1:2], v[0:1], off glc slc dlc
	v_mov_b32_e32 v0, 0x7f7fffff
.LBB0_3:                                ; =>This Inner Loop Header: Depth=1
	s_load_dwordx2 s[6:7], s[4:5], -0x4
	s_add_i32 s3, s3, -1
	s_add_u32 s4, s4, 8
	s_addc_u32 s5, s5, 0
	s_cmp_eq_u32 s3, 0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_subrev_f32_e32 v3, s7, v2
	v_subrev_f32_e32 v4, s6, v1
	v_mul_f32_e32 v3, v3, v3
	v_fmac_f32_e32 v3, v4, v4
	v_cmp_lt_f32_e32 vcc_lo, v3, v0
	v_cndmask_b32_e32 v0, v0, v3, vcc_lo
	s_cbranch_scc0 .LBB0_3
	s_branch .LBB0_5
.LBB0_4:
	v_mov_b32_e32 v0, 0x7f7fffff
.LBB0_5:
	s_waitcnt lgkmcnt(0)
	s_load_dword s2, s[0:1], 0x0
	v_mov_b32_e32 v2, 0
                                        ; implicit-def: $sgpr3
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v1, s2
	s_mov_b32 s2, 0
	s_branch .LBB0_7
	.p2align	6
.LBB0_6:                                ;   in Loop: Header=BB0_7 Depth=1
	s_or_b32 exec_lo, exec_lo, s4
	s_and_b32 s4, exec_lo, s3
	s_or_b32 s2, s4, s2
	s_andn2_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB0_9
.LBB0_7:                                ; =>This Inner Loop Header: Depth=1
	s_or_b32 s3, s3, exec_lo
	s_mov_b32 s4, exec_lo
	v_cmpx_gt_f32_e32 v0, v1
	s_cbranch_execz .LBB0_6
; %bb.8:                                ;   in Loop: Header=BB0_7 Depth=1
	global_atomic_cmpswap v3, v2, v[0:1], s[0:1] glc
	s_andn2_b32 s3, s3, exec_lo
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v3, v1
	v_mov_b32_e32 v1, v3
	s_and_b32 s5, vcc_lo, exec_lo
	s_or_b32 s3, s3, s5
	s_branch .LBB0_6
.LBB0_9:
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 288
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
		.amdhsa_next_free_vgpr 5
		.amdhsa_next_free_sgpr 8
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
	.size	_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii, .Lfunc_end0-_Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 316
; NumSgprs: 10
; NumVgprs: 5
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 1
; VGPRBlocks: 0
; NumSGPRsForWavesPerEU: 10
; NumVGPRsForWavesPerEU: 5
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
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockIdxE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI14__HIP_BlockDimE1xE
	.addrsig_sym _ZN17__HIP_CoordinatesI15__HIP_ThreadIdxE1xE
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .access:         read_only
        .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .access:         read_only
        .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
      - .offset:         32
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         36
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         40
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         44
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         46
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         48
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         50
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         52
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         54
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         80
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         88
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         96
        .size:           2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 288
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii
    .private_segment_fixed_size: 0
    .sgpr_count:     10
    .sgpr_spill_count: 0
    .symbol:         _Z15computeDistancePK15HIP_vector_typeIfLj2EES2_Pfii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     5
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
