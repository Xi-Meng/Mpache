	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.protected	_Z20needle_cuda_shared_1PiS_iiii ; -- Begin function _Z20needle_cuda_shared_1PiS_iiii
	.globl	_Z20needle_cuda_shared_1PiS_iiii
	.p2align	8
	.type	_Z20needle_cuda_shared_1PiS_iiii,@function
_Z20needle_cuda_shared_1PiS_iiii:       ; @_Z20needle_cuda_shared_1PiS_iiii
; %bb.0:
	s_load_dwordx8 s[16:23], s[4:5], 0x0
	s_not_b32 s0, s6
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_lshl_b32 s1, s6, 4
	s_waitcnt lgkmcnt(0)
	s_add_i32 s0, s0, s22
	s_mul_i32 s0, s20, s0
	s_lshl_b32 s0, s0, 4
	s_add_i32 s2, s0, s1
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB0_2
; %bb.1:
	s_ashr_i32 s3, s2, 31
	v_mov_b32_e32 v1, 0
	s_lshl_b64 s[4:5], s[2:3], 2
	s_add_u32 s4, s18, s4
	s_addc_u32 s5, s19, s5
	s_load_dword s1, s[4:5], 0x0
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v2, s1
	ds_write_b32 v1, v2
.LBB0_2:
	s_or_b32 exec_lo, exec_lo, s0
	v_add_nc_u32_e32 v33, s2, v0
	s_ashr_i32 s1, s20, 31
	s_mov_b32 s0, s20
	s_lshl_b64 s[22:23], s[0:1], 2
	v_add3_u32 v1, v33, s20, 1
	v_add3_u32 v3, s20, s20, v1
	v_ashrrev_i32_e32 v2, 31, v1
	v_add_nc_u32_e32 v5, s20, v3
	v_lshlrev_b64 v[9:10], 2, v[1:2]
	v_ashrrev_i32_e32 v4, 31, v3
	v_ashrrev_i32_e32 v6, 31, v5
	v_add_nc_u32_e32 v7, s20, v5
	v_add_co_u32 v17, s0, s16, v9
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	v_lshlrev_b64 v[1:2], 2, v[5:6]
	v_add_nc_u32_e32 v5, s20, v7
	v_add_co_ci_u32_e64 v18, s0, s17, v10, s0
	v_ashrrev_i32_e32 v8, 31, v7
	v_add_co_u32 v19, s0, v17, s22
	v_add_nc_u32_e32 v13, s20, v5
	v_ashrrev_i32_e32 v6, 31, v5
	v_add_co_ci_u32_e64 v20, s0, s23, v18, s0
	v_add_co_u32 v21, s0, s16, v3
	v_ashrrev_i32_e32 v14, 31, v13
	v_add_nc_u32_e32 v25, s20, v13
	v_lshlrev_b64 v[7:8], 2, v[7:8]
	v_add_co_ci_u32_e64 v22, s0, s17, v4, s0
	v_lshlrev_b64 v[15:16], 2, v[13:14]
	v_add_nc_u32_e32 v13, s20, v25
	v_add_co_u32 v23, s0, s16, v1
	v_lshlrev_b64 v[11:12], 2, v[5:6]
	v_ashrrev_i32_e32 v26, 31, v25
	v_add_co_ci_u32_e64 v24, s0, s17, v2, s0
	v_add_co_u32 v27, s0, s16, v7
	v_add_nc_u32_e32 v31, s20, v13
	v_add_co_ci_u32_e64 v28, s0, s17, v8, s0
	v_add_co_u32 v29, s0, s16, v11
	v_lshlrev_b64 v[5:6], 2, v[25:26]
	v_add_co_ci_u32_e64 v30, s0, s17, v12, s0
	v_add_co_u32 v25, s0, s16, v15
	v_add_nc_u32_e32 v36, s20, v31
	v_add_co_ci_u32_e64 v26, s0, s17, v16, s0
	v_add_co_u32 v34, s0, s16, v5
	v_add_co_ci_u32_e64 v35, s0, s17, v6, s0
	s_clause 0x7
global_load_dword v48, v[17:18], off glc slc
global_load_dword v49, v[19:20], off glc slc
global_load_dword v50, v[21:22], off glc slc
global_load_dword v51, v[23:24], off glc slc
global_load_dword v52, v[27:28], off glc slc
global_load_dword v53, v[29:30], off glc slc
global_load_dword v54, v[25:26], off glc slc
global_load_dword v55, v[34:35], off glc slc
	v_add_nc_u32_e32 v17, s20, v36
	v_ashrrev_i32_e32 v14, 31, v13
	v_ashrrev_i32_e32 v32, 31, v31
	v_ashrrev_i32_e32 v37, 31, v36
	v_add_nc_u32_e32 v23, s20, v17
	v_lshlrev_b64 v[13:14], 2, v[13:14]
	v_lshlrev_b64 v[19:20], 2, v[31:32]
	v_ashrrev_i32_e32 v18, 31, v17
	v_lshlrev_b64 v[21:22], 2, v[36:37]
	v_add_nc_u32_e32 v25, s20, v23
	v_ashrrev_i32_e32 v24, 31, v23
	v_add_co_u32 v31, s0, s16, v13
	v_add_co_ci_u32_e64 v32, s0, s17, v14, s0
	v_add_nc_u32_e32 v27, s20, v25
	v_add_co_u32 v34, s0, s16, v19
	v_lshlrev_b64 v[17:18], 2, v[17:18]
	v_ashrrev_i32_e32 v26, 31, v25
	v_add_co_ci_u32_e64 v35, s0, s17, v20, s0
	v_add_nc_u32_e32 v40, s20, v27
	v_add_co_u32 v36, s0, s16, v21
	v_lshlrev_b64 v[23:24], 2, v[23:24]
	v_ashrrev_i32_e32 v28, 31, v27
	v_add_co_ci_u32_e64 v37, s0, s17, v22, s0
	v_add_co_u32 v38, s0, s16, v17
	v_lshlrev_b64 v[25:26], 2, v[25:26]
	v_ashrrev_i32_e32 v41, 31, v40
	v_add_co_ci_u32_e64 v39, s0, s17, v18, s0
	v_add_co_u32 v42, s0, s16, v23
	v_lshlrev_b64 v[29:30], 2, v[27:28]
	v_add_co_ci_u32_e64 v43, s0, s17, v24, s0
	v_add_co_u32 v44, s0, s16, v25
	v_lshlrev_b64 v[27:28], 2, v[40:41]
	v_add_co_ci_u32_e64 v45, s0, s17, v26, s0
	v_add_co_u32 v40, s0, s16, v29
	v_add_co_ci_u32_e64 v41, s0, s17, v30, s0
	v_add_co_u32 v46, s0, s16, v27
	v_add_co_ci_u32_e64 v47, s0, s17, v28, s0
	s_clause 0x7
global_load_dword v31, v[31:32], off glc slc
global_load_dword v56, v[34:35], off glc slc
global_load_dword v36, v[36:37], off glc slc
global_load_dword v37, v[38:39], off glc slc
global_load_dword v38, v[42:43], off glc slc
global_load_dword v39, v[44:45], off glc slc
global_load_dword v40, v[40:41], off glc slc
global_load_dword v41, v[46:47], off glc slc
	v_add_nc_u32_e32 v32, 1, v0
	v_mad_u64_u32 v[34:35], null, v32, s20, s[2:3]
	v_lshlrev_b32_e32 v32, 2, v0
	v_add_nc_u32_e32 v42, 0x400, v32
	v_ashrrev_i32_e32 v35, 31, v34
	v_add_nc_u32_e32 v43, 0x800, v32
	s_waitcnt vmcnt(14)
	ds_write2_b32 v42, v48, v49 offset0:36 offset1:52
	s_waitcnt vmcnt(12)
	ds_write2_b32 v42, v50, v51 offset0:68 offset1:84
	s_waitcnt vmcnt(10)
	ds_write2_b32 v42, v52, v53 offset0:100 offset1:116
	s_waitcnt vmcnt(8)
	ds_write2_b32 v42, v54, v55 offset0:132 offset1:148
	s_waitcnt vmcnt(6)
	ds_write2_b32 v42, v31, v56 offset0:164 offset1:180
	s_waitcnt vmcnt(4)
	ds_write2_b32 v42, v36, v37 offset0:196 offset1:212
	s_waitcnt vmcnt(2)
	ds_write2_b32 v42, v38, v39 offset0:228 offset1:244
	s_waitcnt vmcnt(0)
	ds_write2_b32 v43, v40, v41 offset0:4 offset1:20
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	v_add_co_u32 v34, s0, s18, v34
	v_add_co_ci_u32_e64 v35, s0, s19, v35, s0
global_load_dword v31, v[34:35], off glc slc
	v_ashrrev_i32_e32 v34, 31, v33
	v_mul_u32_u24_e32 v35, 0x44, v0
	v_lshlrev_b64 v[33:34], 2, v[33:34]
	v_add_co_u32 v33, s0, s18, v33
	v_add_co_ci_u32_e64 v34, s0, s19, v34, s0
	s_waitcnt vmcnt(0)
	ds_write_b32 v35, v31 offset:68
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
global_load_dword v34, v[33:34], off offset:4 glc slc
	v_lshlrev_b32_e32 v33, 6, v0
	v_sub_nc_u32_e32 v31, 0, v33
	v_sub_nc_u32_e32 v36, v35, v33
	v_add_nc_u32_e32 v31, v35, v31
	s_waitcnt vmcnt(0)
	ds_write_b32 v36, v34 offset:4
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB0_4
; %bb.3:
	v_add_nc_u32_e32 v36, 0x490, v32
	ds_read_b32 v37, v31 offset:68
	ds_read2_b32 v[34:35], v31 offset1:1
	ds_read_b32 v36, v36
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v37, s21, v37
	s_waitcnt lgkmcnt(1)
	v_subrev_nc_u32_e32 v35, s21, v35
	s_waitcnt lgkmcnt(0)
	v_add_nc_u32_e32 v34, v36, v34
	v_max3_i32 v34, v34, v37, v35
	ds_write_b32 v31, v34 offset:72
.LBB0_4:
	s_or_b32 exec_lo, exec_lo, s0
	v_cmp_gt_u32_e64 s0, 2, v0
	v_sub_nc_u32_e32 v34, 0, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB0_6
; %bb.5:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:17 offset1:18
	ds_read_b32 v38, v38 offset:1232
	ds_read_b32 v39, v37 offset:136
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:140
.LBB0_6:
	s_or_b32 exec_lo, exec_lo, s1
	v_cmp_gt_u32_e64 s1, 3, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB0_8
; %bb.7:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:34 offset1:35
	ds_read_b32 v38, v38 offset:1296
	ds_read_b32 v39, v37 offset:204
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:208
.LBB0_8:
	s_or_b32 exec_lo, exec_lo, s2
	v_cmp_gt_u32_e64 s2, 4, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB0_10
; %bb.9:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:51 offset1:52
	ds_read_b32 v38, v38 offset:1360
	ds_read_b32 v39, v37 offset:272
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:276
.LBB0_10:
	s_or_b32 exec_lo, exec_lo, s3
	v_cmp_gt_u32_e64 s3, 5, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB0_12
; %bb.11:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:68 offset1:69
	ds_read_b32 v38, v38 offset:1424
	ds_read_b32 v39, v37 offset:340
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:344
.LBB0_12:
	s_or_b32 exec_lo, exec_lo, s4
	v_cmp_gt_u32_e64 s4, 6, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB0_14
; %bb.13:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:85 offset1:86
	ds_read_b32 v38, v38 offset:1488
	ds_read_b32 v39, v37 offset:408
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:412
.LBB0_14:
	s_or_b32 exec_lo, exec_lo, s5
	v_cmp_gt_u32_e64 s5, 7, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB0_16
; %bb.15:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:102 offset1:103
	ds_read_b32 v38, v38 offset:1552
	ds_read_b32 v39, v37 offset:476
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:480
.LBB0_16:
	s_or_b32 exec_lo, exec_lo, s6
	v_cmp_gt_u32_e64 s6, 8, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s7, s6
	s_cbranch_execz .LBB0_18
; %bb.17:
	v_mad_i32_i24 v37, 0x44, v34, v32
	v_sub_nc_u32_e32 v38, v32, v33
	ds_read2_b32 v[35:36], v37 offset0:119 offset1:120
	ds_read_b32 v38, v38 offset:1616
	ds_read_b32 v39, v37 offset:544
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:548
.LBB0_18:
	s_or_b32 exec_lo, exec_lo, s7
	v_cmp_gt_u32_e64 s7, 9, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB0_20
; %bb.19:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:1680
	ds_read2_b32 v[35:36], v37 offset0:136 offset1:137
	ds_read_b32 v39, v37 offset:612
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:616
.LBB0_20:
	s_or_b32 exec_lo, exec_lo, s8
	v_cmp_gt_u32_e64 s8, 10, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB0_22
; %bb.21:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:1744
	ds_read2_b32 v[35:36], v37 offset0:153 offset1:154
	ds_read_b32 v39, v37 offset:680
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:684
.LBB0_22:
	s_or_b32 exec_lo, exec_lo, s9
	v_cmp_gt_u32_e64 s9, 11, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s10, s9
	s_cbranch_execz .LBB0_24
; %bb.23:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:1808
	ds_read2_b32 v[35:36], v37 offset0:170 offset1:171
	ds_read_b32 v39, v37 offset:748
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:752
.LBB0_24:
	s_or_b32 exec_lo, exec_lo, s10
	v_cmp_gt_u32_e64 s10, 12, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s11, s10
	s_cbranch_execz .LBB0_26
; %bb.25:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:1872
	ds_read2_b32 v[35:36], v37 offset0:187 offset1:188
	ds_read_b32 v39, v37 offset:816
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:820
.LBB0_26:
	s_or_b32 exec_lo, exec_lo, s11
	v_cmp_gt_u32_e64 s11, 13, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s12, s11
	s_cbranch_execz .LBB0_28
; %bb.27:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:1936
	ds_read2_b32 v[35:36], v37 offset0:204 offset1:205
	ds_read_b32 v39, v37 offset:884
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:888
.LBB0_28:
	s_or_b32 exec_lo, exec_lo, s12
	v_cmp_gt_u32_e64 s12, 14, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s13, s12
	s_cbranch_execz .LBB0_30
; %bb.29:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:2000
	ds_read2_b32 v[35:36], v37 offset0:221 offset1:222
	ds_read_b32 v39, v37 offset:952
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:956
.LBB0_30:
	s_or_b32 exec_lo, exec_lo, s13
	v_cmp_gt_u32_e64 s13, 15, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s14, s13
	s_cbranch_execz .LBB0_32
; %bb.31:
	v_sub_nc_u32_e32 v35, v32, v33
	v_mad_i32_i24 v37, 0x44, v34, v32
	ds_read_b32 v38, v35 offset:2064
	ds_read2_b32 v[35:36], v37 offset0:238 offset1:239
	ds_read_b32 v39, v37 offset:1020
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:1024
.LBB0_32:
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s15, exec_lo
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	v_cmpx_gt_u32_e32 16, v0
	s_cbranch_execz .LBB0_34
; %bb.33:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x3fc, v0
	ds_read_b32 v37, v35 offset:2128
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1088
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1092
.LBB0_34:
	s_or_b32 exec_lo, exec_lo, s15
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s14, s13
	s_cbranch_execz .LBB0_36
; %bb.35:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x400, v0
	ds_read_b32 v37, v35 offset:2132
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1092
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1096
.LBB0_36:
	s_or_b32 exec_lo, exec_lo, s14
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s13, s12
	s_cbranch_execz .LBB0_38
; %bb.37:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x404, v0
	ds_read_b32 v37, v35 offset:2136
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1096
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1100
.LBB0_38:
	s_or_b32 exec_lo, exec_lo, s13
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s12, s11
	s_cbranch_execz .LBB0_40
; %bb.39:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x408, v0
	ds_read_b32 v37, v35 offset:2140
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1100
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1104
.LBB0_40:
	s_or_b32 exec_lo, exec_lo, s12
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s11, s10
	s_cbranch_execz .LBB0_42
; %bb.41:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x40c, v0
	ds_read_b32 v37, v35 offset:2144
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1104
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1108
.LBB0_42:
	s_or_b32 exec_lo, exec_lo, s11
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s10, s9
	s_cbranch_execz .LBB0_44
; %bb.43:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x410, v0
	ds_read_b32 v37, v35 offset:2148
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1108
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1112
.LBB0_44:
	s_or_b32 exec_lo, exec_lo, s10
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB0_46
; %bb.45:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x414, v0
	ds_read_b32 v37, v35 offset:2152
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1112
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1116
.LBB0_46:
	s_or_b32 exec_lo, exec_lo, s9
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB0_48
; %bb.47:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x418, v0
	ds_read_b32 v37, v35 offset:2156
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1116
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1120
.LBB0_48:
	s_or_b32 exec_lo, exec_lo, s8
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s7, s6
	s_cbranch_execz .LBB0_50
; %bb.49:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x41c, v0
	ds_read_b32 v37, v35 offset:2160
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1120
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1124
.LBB0_50:
	s_or_b32 exec_lo, exec_lo, s7
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB0_52
; %bb.51:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x420, v0
	ds_read_b32 v37, v35 offset:2164
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1124
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1128
.LBB0_52:
	s_or_b32 exec_lo, exec_lo, s6
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB0_54
; %bb.53:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x424, v0
	ds_read_b32 v37, v35 offset:2168
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1128
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1132
.LBB0_54:
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB0_56
; %bb.55:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x428, v0
	ds_read_b32 v37, v35 offset:2172
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1132
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1136
.LBB0_56:
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB0_58
; %bb.57:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x42c, v0
	ds_read_b32 v37, v35 offset:2176
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1136
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1140
.LBB0_58:
	s_or_b32 exec_lo, exec_lo, s3
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB0_60
; %bb.59:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v35, v32, v33
	v_add_nc_u32_e32 v36, 0x430, v0
	ds_read_b32 v37, v35 offset:2180
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1140
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1144
.LBB0_60:
	s_or_b32 exec_lo, exec_lo, s2
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB0_62
; %bb.61:
	v_mad_i32_i24 v0, 0x44, v34, v32
	v_sub_nc_u32_e32 v32, v32, v33
	v_add_nc_u32_e32 v33, 0x434, v0
	ds_read_b32 v34, v32 offset:2184
	ds_read2_b32 v[32:33], v33 offset1:1
	ds_read_b32 v35, v0 offset:1144
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v32, v34, v32
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v34, s21, v35
	v_subrev_nc_u32_e32 v33, s21, v33
	v_max3_i32 v32, v32, v34, v33
	ds_write_b32 v0, v32 offset:1148
.LBB0_62:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB0_64
; %bb.63:
	v_mov_b32_e32 v0, 0
	ds_read_b64 v[32:33], v0 offset:1080
	ds_read_b32 v34, v0 offset:2188
	ds_read_b32 v35, v0 offset:1148
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v33, s21, v33
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v32, v34, v32
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v34, s21, v35
	v_max3_i32 v32, v32, v34, v33
	ds_write_b32 v0, v32 offset:1152
.LBB0_64:
	s_or_b32 exec_lo, exec_lo, s0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	ds_read2_b32 v[32:33], v31 offset0:18 offset1:35
	ds_read2_b32 v[34:35], v31 offset0:52 offset1:69
	v_add_co_u32 v9, vcc_lo, s18, v9
	ds_read2_b32 v[36:37], v31 offset0:86 offset1:103
	v_add_co_ci_u32_e32 v10, vcc_lo, s19, v10, vcc_lo
	v_add_co_u32 v3, vcc_lo, s18, v3
	v_add_co_ci_u32_e32 v4, vcc_lo, s19, v4, vcc_lo
	v_add_co_u32 v38, vcc_lo, v9, s22
	v_add_co_ci_u32_e32 v39, vcc_lo, s23, v10, vcc_lo
	v_add_co_u32 v0, vcc_lo, s18, v1
	v_add_co_ci_u32_e32 v1, vcc_lo, s19, v2, vcc_lo
	v_add_co_u32 v7, vcc_lo, s18, v7
	v_add_co_ci_u32_e32 v8, vcc_lo, s19, v8, vcc_lo
	s_waitcnt lgkmcnt(2)
global_store_dword v[9:10], v32, off glc slc
	v_add_co_u32 v9, vcc_lo, s18, v11
	v_add_co_ci_u32_e32 v10, vcc_lo, s19, v12, vcc_lo
global_store_dword v[38:39], v33, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[3:4], v34, off glc slc
global_store_dword v[0:1], v35, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[7:8], v36, off glc slc
global_store_dword v[9:10], v37, off glc slc
	ds_read2_b32 v[0:1], v31 offset0:120 offset1:137
	ds_read2_b32 v[7:8], v31 offset0:154 offset1:171
	ds_read2_b32 v[9:10], v31 offset0:188 offset1:205
	v_add_co_u32 v2, vcc_lo, s18, v15
	v_add_co_ci_u32_e32 v3, vcc_lo, s19, v16, vcc_lo
	v_add_co_u32 v4, vcc_lo, s18, v5
	v_add_co_ci_u32_e32 v5, vcc_lo, s19, v6, vcc_lo
	v_add_co_u32 v11, vcc_lo, s18, v13
	v_add_co_ci_u32_e32 v12, vcc_lo, s19, v14, vcc_lo
	v_add_co_u32 v13, vcc_lo, s18, v19
	v_add_co_ci_u32_e32 v14, vcc_lo, s19, v20, vcc_lo
	v_add_co_u32 v15, vcc_lo, s18, v21
	v_add_co_ci_u32_e32 v16, vcc_lo, s19, v22, vcc_lo
	s_waitcnt lgkmcnt(2)
global_store_dword v[2:3], v0, off glc slc
global_store_dword v[4:5], v1, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[11:12], v7, off glc slc
global_store_dword v[13:14], v8, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[15:16], v9, off glc slc
	v_add_nc_u32_e32 v4, 0x400, v31
	ds_read2_b32 v[0:1], v31 offset0:222 offset1:239
	v_add_co_u32 v2, vcc_lo, s18, v17
	v_add_co_ci_u32_e32 v3, vcc_lo, s19, v18, vcc_lo
	ds_read2_b32 v[4:5], v4 offset1:17
	v_add_co_u32 v6, vcc_lo, s18, v23
	v_add_co_ci_u32_e32 v7, vcc_lo, s19, v24, vcc_lo
	v_add_co_u32 v8, vcc_lo, s18, v25
	v_add_co_ci_u32_e32 v9, vcc_lo, s19, v26, vcc_lo
	v_add_co_u32 v11, vcc_lo, s18, v29
	v_add_co_ci_u32_e32 v12, vcc_lo, s19, v30, vcc_lo
	v_add_co_u32 v13, vcc_lo, s18, v27
	v_add_co_ci_u32_e32 v14, vcc_lo, s19, v28, vcc_lo
global_store_dword v[2:3], v10, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[6:7], v0, off glc slc
global_store_dword v[8:9], v1, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[11:12], v4, off glc slc
global_store_dword v[13:14], v5, off glc slc
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z20needle_cuda_shared_1PiS_iiii
		.amdhsa_group_segment_fixed_size 2192
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 32
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
		.amdhsa_next_free_vgpr 57
		.amdhsa_next_free_sgpr 24
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
	.size	_Z20needle_cuda_shared_1PiS_iiii, .Lfunc_end0-_Z20needle_cuda_shared_1PiS_iiii
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 5576
; NumSgprs: 26
; NumVgprs: 57
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 2192 bytes/workgroup (compile time only)
; SGPRBlocks: 3
; VGPRBlocks: 7
; NumSGPRsForWavesPerEU: 26
; NumVGPRsForWavesPerEU: 57
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
	.protected	_Z20needle_cuda_shared_2PiS_iiii ; -- Begin function _Z20needle_cuda_shared_2PiS_iiii
	.globl	_Z20needle_cuda_shared_2PiS_iiii
	.p2align	8
	.type	_Z20needle_cuda_shared_2PiS_iiii,@function
_Z20needle_cuda_shared_2PiS_iiii:       ; @_Z20needle_cuda_shared_2PiS_iiii
; %bb.0:
	s_load_dwordx8 s[16:23], s[4:5], 0x0
	s_not_b32 s0, s6
	s_waitcnt lgkmcnt(0)
	s_add_i32 s0, s0, s23
	s_sub_i32 s1, s6, s22
	s_mul_i32 s0, s20, s0
	s_add_i32 s1, s1, s23
	s_lshl_b32 s0, s0, 4
	s_lshl_b32 s1, s1, 4
	s_ashr_i32 s3, s20, 31
	s_add_i32 s0, s0, s1
	s_mov_b32 s2, s20
	v_add_nc_u32_e32 v31, s0, v0
	s_lshl_b64 s[22:23], s[2:3], 2
	v_add3_u32 v1, v31, s20, 1
	v_add3_u32 v3, s20, s20, v1
	v_ashrrev_i32_e32 v2, 31, v1
	v_add_nc_u32_e32 v5, s20, v3
	v_lshlrev_b64 v[7:8], 2, v[1:2]
	v_ashrrev_i32_e32 v4, 31, v3
	v_add_nc_u32_e32 v9, s20, v5
	v_ashrrev_i32_e32 v6, 31, v5
	v_add_co_u32 v19, vcc_lo, s16, v7
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	v_ashrrev_i32_e32 v10, 31, v9
	v_add_nc_u32_e32 v11, s20, v9
	v_lshlrev_b64 v[1:2], 2, v[5:6]
	v_add_co_ci_u32_e32 v20, vcc_lo, s17, v8, vcc_lo
	v_lshlrev_b64 v[5:6], 2, v[9:10]
	v_add_nc_u32_e32 v9, s20, v11
	v_add_co_u32 v21, vcc_lo, v19, s22
	v_ashrrev_i32_e32 v12, 31, v11
	v_add_co_ci_u32_e32 v22, vcc_lo, s23, v20, vcc_lo
	v_add_nc_u32_e32 v13, s20, v9
	v_add_co_u32 v23, vcc_lo, s16, v3
	v_ashrrev_i32_e32 v10, 31, v9
	v_add_co_ci_u32_e32 v24, vcc_lo, s17, v4, vcc_lo
	v_add_nc_u32_e32 v17, s20, v13
	v_add_co_u32 v25, vcc_lo, s16, v1
	v_lshlrev_b64 v[11:12], 2, v[11:12]
	v_ashrrev_i32_e32 v14, 31, v13
	v_add_nc_u32_e32 v32, s20, v17
	v_add_co_ci_u32_e32 v26, vcc_lo, s17, v2, vcc_lo
	v_add_co_u32 v27, vcc_lo, s16, v5
	v_lshlrev_b64 v[15:16], 2, v[9:10]
	v_ashrrev_i32_e32 v18, 31, v17
	v_ashrrev_i32_e32 v33, 31, v32
	v_add_nc_u32_e32 v36, s20, v32
	v_add_co_ci_u32_e32 v28, vcc_lo, s17, v6, vcc_lo
	v_add_co_u32 v29, vcc_lo, s16, v11
	v_lshlrev_b64 v[9:10], 2, v[13:14]
	v_add_co_ci_u32_e32 v30, vcc_lo, s17, v12, vcc_lo
	v_add_co_u32 v34, vcc_lo, s16, v15
	v_lshlrev_b64 v[13:14], 2, v[17:18]
	v_lshlrev_b64 v[17:18], 2, v[32:33]
	v_add_nc_u32_e32 v32, s20, v36
	v_add_co_ci_u32_e32 v35, vcc_lo, s17, v16, vcc_lo
	v_add_co_u32 v38, vcc_lo, s16, v9
	v_add_co_ci_u32_e32 v39, vcc_lo, s17, v10, vcc_lo
	s_clause 0x7
global_load_dword v48, v[19:20], off glc slc
global_load_dword v49, v[21:22], off glc slc
global_load_dword v50, v[23:24], off glc slc
global_load_dword v51, v[25:26], off glc slc
global_load_dword v52, v[27:28], off glc slc
global_load_dword v53, v[29:30], off glc slc
global_load_dword v54, v[34:35], off glc slc
global_load_dword v55, v[38:39], off glc slc
	v_add_nc_u32_e32 v21, s20, v32
	v_ashrrev_i32_e32 v37, 31, v36
	v_ashrrev_i32_e32 v33, 31, v32
	v_add_co_u32 v34, vcc_lo, s16, v13
	v_add_nc_u32_e32 v25, s20, v21
	v_lshlrev_b64 v[23:24], 2, v[36:37]
	v_ashrrev_i32_e32 v22, 31, v21
	v_add_co_ci_u32_e32 v35, vcc_lo, s17, v14, vcc_lo
	v_add_nc_u32_e32 v27, s20, v25
	v_add_co_u32 v36, vcc_lo, s16, v17
	v_lshlrev_b64 v[19:20], 2, v[32:33]
	v_ashrrev_i32_e32 v26, 31, v25
	v_add_co_ci_u32_e32 v37, vcc_lo, s17, v18, vcc_lo
	v_add_nc_u32_e32 v40, s20, v27
	v_add_co_u32 v32, vcc_lo, s16, v23
	v_lshlrev_b64 v[21:22], 2, v[21:22]
	v_ashrrev_i32_e32 v28, 31, v27
	v_add_co_ci_u32_e32 v33, vcc_lo, s17, v24, vcc_lo
	v_add_co_u32 v38, vcc_lo, s16, v19
	v_lshlrev_b64 v[25:26], 2, v[25:26]
	v_ashrrev_i32_e32 v41, 31, v40
	v_add_co_ci_u32_e32 v39, vcc_lo, s17, v20, vcc_lo
	v_add_co_u32 v42, vcc_lo, s16, v21
	v_lshlrev_b64 v[29:30], 2, v[27:28]
	v_add_co_ci_u32_e32 v43, vcc_lo, s17, v22, vcc_lo
	v_add_co_u32 v44, vcc_lo, s16, v25
	v_lshlrev_b64 v[27:28], 2, v[40:41]
	v_add_co_ci_u32_e32 v45, vcc_lo, s17, v26, vcc_lo
	v_add_co_u32 v40, vcc_lo, s16, v29
	v_add_co_ci_u32_e32 v41, vcc_lo, s17, v30, vcc_lo
	v_add_co_u32 v46, vcc_lo, s16, v27
	v_add_co_ci_u32_e32 v47, vcc_lo, s17, v28, vcc_lo
	s_clause 0x7
global_load_dword v34, v[34:35], off glc slc
global_load_dword v35, v[36:37], off glc slc
global_load_dword v32, v[32:33], off glc slc
global_load_dword v36, v[38:39], off glc slc
global_load_dword v37, v[42:43], off glc slc
global_load_dword v38, v[44:45], off glc slc
global_load_dword v39, v[40:41], off glc slc
global_load_dword v40, v[46:47], off glc slc
	v_lshlrev_b32_e32 v33, 2, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	v_add_nc_u32_e32 v41, 0x400, v33
	v_add_nc_u32_e32 v42, 0x800, v33
	s_waitcnt vmcnt(14)
	ds_write2_b32 v41, v48, v49 offset0:36 offset1:52
	s_waitcnt vmcnt(12)
	ds_write2_b32 v41, v50, v51 offset0:68 offset1:84
	s_waitcnt vmcnt(10)
	ds_write2_b32 v41, v52, v53 offset0:100 offset1:116
	s_waitcnt vmcnt(8)
	ds_write2_b32 v41, v54, v55 offset0:132 offset1:148
	s_waitcnt vmcnt(6)
	ds_write2_b32 v41, v34, v35 offset0:164 offset1:180
	s_waitcnt vmcnt(4)
	ds_write2_b32 v41, v32, v36 offset0:196 offset1:212
	s_waitcnt vmcnt(2)
	ds_write2_b32 v41, v37, v38 offset0:228 offset1:244
	s_waitcnt vmcnt(0)
	ds_write2_b32 v42, v39, v40 offset0:4 offset1:20
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s3, vcc_lo
	s_cbranch_execz .LBB1_2
; %bb.1:
	s_ashr_i32 s1, s0, 31
	v_mov_b32_e32 v32, 0
	s_lshl_b64 s[4:5], s[0:1], 2
	s_add_u32 s4, s18, s4
	s_addc_u32 s5, s19, s5
	s_load_dword s1, s[4:5], 0x0
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v34, s1
	ds_write_b32 v32, v34
.LBB1_2:
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v32, 1, v0
	v_mad_u64_u32 v[34:35], null, v32, s2, s[0:1]
	v_ashrrev_i32_e32 v32, 31, v31
	v_lshlrev_b64 v[31:32], 2, v[31:32]
	v_ashrrev_i32_e32 v35, 31, v34
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	v_add_co_u32 v34, s0, s18, v34
	v_add_co_ci_u32_e64 v35, s0, s19, v35, s0
	v_add_co_u32 v31, s0, s18, v31
	v_add_co_ci_u32_e64 v32, s0, s19, v32, s0
global_load_dword v34, v[34:35], off glc slc
	v_mul_u32_u24_e32 v35, 0x44, v0
	s_waitcnt vmcnt(0)
	ds_write_b32 v35, v34 offset:68
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
global_load_dword v34, v[31:32], off offset:4 glc slc
	v_lshlrev_b32_e32 v32, 6, v0
	v_sub_nc_u32_e32 v31, 0, v32
	v_sub_nc_u32_e32 v36, v35, v32
	v_add_nc_u32_e32 v31, v35, v31
	s_waitcnt vmcnt(0)
	ds_write_b32 v36, v34 offset:4
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB1_4
; %bb.3:
	v_add_nc_u32_e32 v36, 0x490, v33
	ds_read_b32 v37, v31 offset:68
	ds_read2_b32 v[34:35], v31 offset1:1
	ds_read_b32 v36, v36
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v37, s21, v37
	s_waitcnt lgkmcnt(1)
	v_subrev_nc_u32_e32 v35, s21, v35
	s_waitcnt lgkmcnt(0)
	v_add_nc_u32_e32 v34, v36, v34
	v_max3_i32 v34, v34, v37, v35
	ds_write_b32 v31, v34 offset:72
.LBB1_4:
	s_or_b32 exec_lo, exec_lo, s0
	v_cmp_gt_u32_e64 s0, 2, v0
	v_sub_nc_u32_e32 v34, 0, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB1_6
; %bb.5:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:17 offset1:18
	ds_read_b32 v38, v38 offset:1232
	ds_read_b32 v39, v37 offset:136
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:140
.LBB1_6:
	s_or_b32 exec_lo, exec_lo, s1
	v_cmp_gt_u32_e64 s1, 3, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB1_8
; %bb.7:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:34 offset1:35
	ds_read_b32 v38, v38 offset:1296
	ds_read_b32 v39, v37 offset:204
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:208
.LBB1_8:
	s_or_b32 exec_lo, exec_lo, s2
	v_cmp_gt_u32_e64 s2, 4, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB1_10
; %bb.9:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:51 offset1:52
	ds_read_b32 v38, v38 offset:1360
	ds_read_b32 v39, v37 offset:272
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:276
.LBB1_10:
	s_or_b32 exec_lo, exec_lo, s3
	v_cmp_gt_u32_e64 s3, 5, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB1_12
; %bb.11:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:68 offset1:69
	ds_read_b32 v38, v38 offset:1424
	ds_read_b32 v39, v37 offset:340
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:344
.LBB1_12:
	s_or_b32 exec_lo, exec_lo, s4
	v_cmp_gt_u32_e64 s4, 6, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB1_14
; %bb.13:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:85 offset1:86
	ds_read_b32 v38, v38 offset:1488
	ds_read_b32 v39, v37 offset:408
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:412
.LBB1_14:
	s_or_b32 exec_lo, exec_lo, s5
	v_cmp_gt_u32_e64 s5, 7, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB1_16
; %bb.15:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:102 offset1:103
	ds_read_b32 v38, v38 offset:1552
	ds_read_b32 v39, v37 offset:476
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:480
.LBB1_16:
	s_or_b32 exec_lo, exec_lo, s6
	v_cmp_gt_u32_e64 s6, 8, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s7, s6
	s_cbranch_execz .LBB1_18
; %bb.17:
	v_mad_i32_i24 v37, 0x44, v34, v33
	v_sub_nc_u32_e32 v38, v33, v32
	ds_read2_b32 v[35:36], v37 offset0:119 offset1:120
	ds_read_b32 v38, v38 offset:1616
	ds_read_b32 v39, v37 offset:544
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v36, s21, v36
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:548
.LBB1_18:
	s_or_b32 exec_lo, exec_lo, s7
	v_cmp_gt_u32_e64 s7, 9, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB1_20
; %bb.19:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:1680
	ds_read2_b32 v[35:36], v37 offset0:136 offset1:137
	ds_read_b32 v39, v37 offset:612
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:616
.LBB1_20:
	s_or_b32 exec_lo, exec_lo, s8
	v_cmp_gt_u32_e64 s8, 10, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB1_22
; %bb.21:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:1744
	ds_read2_b32 v[35:36], v37 offset0:153 offset1:154
	ds_read_b32 v39, v37 offset:680
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:684
.LBB1_22:
	s_or_b32 exec_lo, exec_lo, s9
	v_cmp_gt_u32_e64 s9, 11, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s10, s9
	s_cbranch_execz .LBB1_24
; %bb.23:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:1808
	ds_read2_b32 v[35:36], v37 offset0:170 offset1:171
	ds_read_b32 v39, v37 offset:748
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:752
.LBB1_24:
	s_or_b32 exec_lo, exec_lo, s10
	v_cmp_gt_u32_e64 s10, 12, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s11, s10
	s_cbranch_execz .LBB1_26
; %bb.25:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:1872
	ds_read2_b32 v[35:36], v37 offset0:187 offset1:188
	ds_read_b32 v39, v37 offset:816
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:820
.LBB1_26:
	s_or_b32 exec_lo, exec_lo, s11
	v_cmp_gt_u32_e64 s11, 13, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s12, s11
	s_cbranch_execz .LBB1_28
; %bb.27:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:1936
	ds_read2_b32 v[35:36], v37 offset0:204 offset1:205
	ds_read_b32 v39, v37 offset:884
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:888
.LBB1_28:
	s_or_b32 exec_lo, exec_lo, s12
	v_cmp_gt_u32_e64 s12, 14, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s13, s12
	s_cbranch_execz .LBB1_30
; %bb.29:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:2000
	ds_read2_b32 v[35:36], v37 offset0:221 offset1:222
	ds_read_b32 v39, v37 offset:952
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:956
.LBB1_30:
	s_or_b32 exec_lo, exec_lo, s13
	v_cmp_gt_u32_e64 s13, 15, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s14, s13
	s_cbranch_execz .LBB1_32
; %bb.31:
	v_sub_nc_u32_e32 v35, v33, v32
	v_mad_i32_i24 v37, 0x44, v34, v33
	ds_read_b32 v38, v35 offset:2064
	ds_read2_b32 v[35:36], v37 offset0:238 offset1:239
	ds_read_b32 v39, v37 offset:1020
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v38, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v38, s21, v39
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v38, v36
	ds_write_b32 v37, v35 offset:1024
.LBB1_32:
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s15, exec_lo
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	v_cmpx_gt_u32_e32 16, v0
	s_cbranch_execz .LBB1_34
; %bb.33:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x3fc, v0
	ds_read_b32 v37, v35 offset:2128
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1088
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1092
.LBB1_34:
	s_or_b32 exec_lo, exec_lo, s15
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s14, s13
	s_cbranch_execz .LBB1_36
; %bb.35:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x400, v0
	ds_read_b32 v37, v35 offset:2132
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1092
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1096
.LBB1_36:
	s_or_b32 exec_lo, exec_lo, s14
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s13, s12
	s_cbranch_execz .LBB1_38
; %bb.37:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x404, v0
	ds_read_b32 v37, v35 offset:2136
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1096
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1100
.LBB1_38:
	s_or_b32 exec_lo, exec_lo, s13
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s12, s11
	s_cbranch_execz .LBB1_40
; %bb.39:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x408, v0
	ds_read_b32 v37, v35 offset:2140
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1100
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1104
.LBB1_40:
	s_or_b32 exec_lo, exec_lo, s12
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s11, s10
	s_cbranch_execz .LBB1_42
; %bb.41:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x40c, v0
	ds_read_b32 v37, v35 offset:2144
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1104
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1108
.LBB1_42:
	s_or_b32 exec_lo, exec_lo, s11
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s10, s9
	s_cbranch_execz .LBB1_44
; %bb.43:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x410, v0
	ds_read_b32 v37, v35 offset:2148
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1108
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1112
.LBB1_44:
	s_or_b32 exec_lo, exec_lo, s10
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB1_46
; %bb.45:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x414, v0
	ds_read_b32 v37, v35 offset:2152
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1112
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1116
.LBB1_46:
	s_or_b32 exec_lo, exec_lo, s9
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB1_48
; %bb.47:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x418, v0
	ds_read_b32 v37, v35 offset:2156
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1116
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1120
.LBB1_48:
	s_or_b32 exec_lo, exec_lo, s8
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s7, s6
	s_cbranch_execz .LBB1_50
; %bb.49:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x41c, v0
	ds_read_b32 v37, v35 offset:2160
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1120
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1124
.LBB1_50:
	s_or_b32 exec_lo, exec_lo, s7
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB1_52
; %bb.51:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x420, v0
	ds_read_b32 v37, v35 offset:2164
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1124
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1128
.LBB1_52:
	s_or_b32 exec_lo, exec_lo, s6
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB1_54
; %bb.53:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x424, v0
	ds_read_b32 v37, v35 offset:2168
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1128
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1132
.LBB1_54:
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB1_56
; %bb.55:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x428, v0
	ds_read_b32 v37, v35 offset:2172
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1132
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1136
.LBB1_56:
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB1_58
; %bb.57:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x42c, v0
	ds_read_b32 v37, v35 offset:2176
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1136
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1140
.LBB1_58:
	s_or_b32 exec_lo, exec_lo, s3
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB1_60
; %bb.59:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v35, v33, v32
	v_add_nc_u32_e32 v36, 0x430, v0
	ds_read_b32 v37, v35 offset:2180
	ds_read2_b32 v[35:36], v36 offset1:1
	ds_read_b32 v38, v0 offset:1140
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v35, v37, v35
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v37, s21, v38
	v_subrev_nc_u32_e32 v36, s21, v36
	v_max3_i32 v35, v35, v37, v36
	ds_write_b32 v0, v35 offset:1144
.LBB1_60:
	s_or_b32 exec_lo, exec_lo, s2
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB1_62
; %bb.61:
	v_mad_i32_i24 v0, 0x44, v34, v33
	v_sub_nc_u32_e32 v32, v33, v32
	v_add_nc_u32_e32 v33, 0x434, v0
	ds_read_b32 v34, v32 offset:2184
	ds_read2_b32 v[32:33], v33 offset1:1
	ds_read_b32 v35, v0 offset:1144
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v32, v34, v32
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v34, s21, v35
	v_subrev_nc_u32_e32 v33, s21, v33
	v_max3_i32 v32, v32, v34, v33
	ds_write_b32 v0, v32 offset:1148
.LBB1_62:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB1_64
; %bb.63:
	v_mov_b32_e32 v0, 0
	ds_read_b64 v[32:33], v0 offset:1080
	ds_read_b32 v34, v0 offset:2188
	ds_read_b32 v35, v0 offset:1148
	s_waitcnt lgkmcnt(2)
	v_subrev_nc_u32_e32 v33, s21, v33
	s_waitcnt lgkmcnt(1)
	v_add_nc_u32_e32 v32, v34, v32
	s_waitcnt lgkmcnt(0)
	v_subrev_nc_u32_e32 v34, s21, v35
	v_max3_i32 v32, v32, v34, v33
	ds_write_b32 v0, v32 offset:1152
.LBB1_64:
	s_or_b32 exec_lo, exec_lo, s0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	ds_read2_b32 v[32:33], v31 offset0:18 offset1:35
	ds_read2_b32 v[34:35], v31 offset0:52 offset1:69
	v_add_co_u32 v7, vcc_lo, s18, v7
	ds_read2_b32 v[36:37], v31 offset0:86 offset1:103
	v_add_co_ci_u32_e32 v8, vcc_lo, s19, v8, vcc_lo
	v_add_co_u32 v3, vcc_lo, s18, v3
	v_add_co_ci_u32_e32 v4, vcc_lo, s19, v4, vcc_lo
	v_add_co_u32 v38, vcc_lo, v7, s22
	v_add_co_ci_u32_e32 v39, vcc_lo, s23, v8, vcc_lo
	v_add_co_u32 v0, vcc_lo, s18, v1
	v_add_co_ci_u32_e32 v1, vcc_lo, s19, v2, vcc_lo
	v_add_co_u32 v5, vcc_lo, s18, v5
	v_add_co_ci_u32_e32 v6, vcc_lo, s19, v6, vcc_lo
	s_waitcnt lgkmcnt(2)
global_store_dword v[7:8], v32, off glc slc
	v_add_co_u32 v7, vcc_lo, s18, v11
	v_add_co_ci_u32_e32 v8, vcc_lo, s19, v12, vcc_lo
global_store_dword v[38:39], v33, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[3:4], v34, off glc slc
global_store_dword v[0:1], v35, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[5:6], v36, off glc slc
global_store_dword v[7:8], v37, off glc slc
	ds_read2_b32 v[0:1], v31 offset0:120 offset1:137
	ds_read2_b32 v[4:5], v31 offset0:154 offset1:171
	ds_read2_b32 v[6:7], v31 offset0:188 offset1:205
	v_add_co_u32 v2, vcc_lo, s18, v15
	v_add_co_ci_u32_e32 v3, vcc_lo, s19, v16, vcc_lo
	v_add_co_u32 v8, vcc_lo, s18, v9
	v_add_co_ci_u32_e32 v9, vcc_lo, s19, v10, vcc_lo
	v_add_co_u32 v10, vcc_lo, s18, v13
	v_add_co_ci_u32_e32 v11, vcc_lo, s19, v14, vcc_lo
	v_add_co_u32 v12, vcc_lo, s18, v17
	v_add_co_ci_u32_e32 v13, vcc_lo, s19, v18, vcc_lo
	v_add_co_u32 v14, vcc_lo, s18, v23
	v_add_co_ci_u32_e32 v15, vcc_lo, s19, v24, vcc_lo
	s_waitcnt lgkmcnt(2)
global_store_dword v[2:3], v0, off glc slc
global_store_dword v[8:9], v1, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[10:11], v4, off glc slc
global_store_dword v[12:13], v5, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[14:15], v6, off glc slc
	v_add_nc_u32_e32 v4, 0x400, v31
	ds_read2_b32 v[0:1], v31 offset0:222 offset1:239
	v_add_co_u32 v2, vcc_lo, s18, v19
	v_add_co_ci_u32_e32 v3, vcc_lo, s19, v20, vcc_lo
	ds_read2_b32 v[4:5], v4 offset1:17
	v_add_co_u32 v8, vcc_lo, s18, v21
	v_add_co_ci_u32_e32 v9, vcc_lo, s19, v22, vcc_lo
	v_add_co_u32 v10, vcc_lo, s18, v25
	v_add_co_ci_u32_e32 v11, vcc_lo, s19, v26, vcc_lo
	v_add_co_u32 v12, vcc_lo, s18, v29
	v_add_co_ci_u32_e32 v13, vcc_lo, s19, v30, vcc_lo
	v_add_co_u32 v14, vcc_lo, s18, v27
	v_add_co_ci_u32_e32 v15, vcc_lo, s19, v28, vcc_lo
global_store_dword v[2:3], v7, off glc slc
	s_waitcnt lgkmcnt(1)
global_store_dword v[8:9], v0, off glc slc
global_store_dword v[10:11], v1, off glc slc
	s_waitcnt lgkmcnt(0)
global_store_dword v[12:13], v4, off glc slc
global_store_dword v[14:15], v5, off glc slc
	s_endpgm
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z20needle_cuda_shared_2PiS_iiii
		.amdhsa_group_segment_fixed_size 2192
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 32
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
		.amdhsa_next_free_vgpr 56
		.amdhsa_next_free_sgpr 24
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
	.size	_Z20needle_cuda_shared_2PiS_iiii, .Lfunc_end1-_Z20needle_cuda_shared_2PiS_iiii
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 5456
; NumSgprs: 26
; NumVgprs: 56
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 2192 bytes/workgroup (compile time only)
; SGPRBlocks: 3
; VGPRBlocks: 6
; NumSGPRsForWavesPerEU: 26
; NumVGPRsForWavesPerEU: 56
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
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 2192
    .kernarg_segment_align: 8
    .kernarg_segment_size: 32
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z20needle_cuda_shared_1PiS_iiii
    .private_segment_fixed_size: 0
    .sgpr_count:     26
    .sgpr_spill_count: 0
    .symbol:         _Z20needle_cuda_shared_1PiS_iiii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     57
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .offset:         16
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
      - .offset:         24
        .size:           4
        .value_kind:     by_value
      - .offset:         28
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 2192
    .kernarg_segment_align: 8
    .kernarg_segment_size: 32
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z20needle_cuda_shared_2PiS_iiii
    .private_segment_fixed_size: 0
    .sgpr_count:     26
    .sgpr_spill_count: 0
    .symbol:         _Z20needle_cuda_shared_2PiS_iiii.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     56
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
