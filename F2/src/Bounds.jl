include("Types.jl")
using GLPK
# ----------------------------------------------------------------------------------- #
# Copyright (c) 2016 Varnerlab
# School of Chemical Engineering Purdue University
# W. Lafayette IN 46907 USA

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

# Species vector -
# 1	M_maltose_c
# 2	M_h2o_c
# 3	M_glc_D_c
# 4	M_pep_c
# 5	M_g6p_c
# 6	M_pyr_c
# 7	M_atp_c
# 8	M_adp_c
# 9	M_h_c
# 10	M_utp_c
# 11	M_udp_c
# 12	M_ctp_c
# 13	M_cdp_c
# 14	M_gtp_c
# 15	M_gdp_c
# 16	M_f6p_c
# 17	M_fdp_c
# 18	M_pi_c
# 19	M_dhap_c
# 20	M_g3p_c
# 21	M_nad_c
# 22	M_13dpg_c
# 23	M_nadh_c
# 24	M_3pg_c
# 25	M_2pg_c
# 26	M_oaa_c
# 27	M_co2_c
# 28	M_coa_c
# 29	M_accoa_c
# 30	M_amp_c
# 31	M_nadp_c
# 32	M_6pgl_c
# 33	M_nadph_c
# 34	M_6pgc_c
# 35	M_ru5p_D_c
# 36	M_xu5p_D_c
# 37	M_r5p_c
# 38	M_s7p_c
# 39	M_e4p_c
# 40	M_2ddg6p_c
# 41	M_cit_c
# 42	M_icit_c
# 43	M_akg_c
# 44	M_succoa_c
# 45	M_succ_c
# 46	M_q8_c
# 47	M_fum_c
# 48	M_q8h2_c
# 49	M_mql8_c
# 50	M_mqn8_c
# 51	M_mal_L_c
# 52	M_glx_c
# 53	M_actp_c
# 54	M_ac_c
# 55	M_ppi_c
# 56	M_etoh_c
# 57	M_lac_D_c
# 58	M_for_c
# 59	M_o2_c
# 60	M_h_e
# 61	M_chor_c
# 62	M_gln_L_c
# 63	M_gly_L_c
# 64	M_gar_c
# 65	M_glu_L_c
# 66	M_10fthf_c
# 67	M_air_c
# 68	M_thf_c
# 69	M_asp_L_c
# 70	M_hco3_c
# 71	M_aicar_c
# 72	M_imp_c
# 73	M_methf_c
# 74	M_mlthf_c
# 75	M_5mthf_c
# 76	M_gmp_c
# 77	M_ump_c
# 78	M_cmp_c
# 79	M_ala_L_c
# 80	M_arg_L_c
# 81	M_nh4_c
# 82	M_asn_L_c
# 83	M_ser_L_c
# 84	M_h2s_c
# 85	M_cys_L_c
# 86	M_his_L_c
# 87	M_thr_L_c
# 88	M_ile_L_c
# 89	M_leu_L_c
# 90	M_lys_L_c
# 91	M_met_L_c
# 92	M_phe_L_c
# 93	M_pro_L_c
# 94	M_trp_L_c
# 95	M_tyr_L_c
# 96	M_val_L_c
# 97	M_urea_c
# 98	M_h2o2_c
# 99	M_mglx_c
# 100	M_prop_c
# 101	M_indole_c
# 102	M_cadav_c
# 103	M_gaba_c
# 104	GENE_F2
# 105	RNAP
# 106	OPEN_GENE_F2
# 107	mRNA_F2
# 108	RIBOSOME
# 109	RIBOSOME_START_F2
# 110	M_ala_L_c_tRNA
# 111	M_arg_L_c_tRNA
# 112	M_asn_L_c_tRNA
# 113	M_asp_L_c_tRNA
# 114	M_cys_L_c_tRNA
# 115	M_glu_L_c_tRNA
# 116	M_gln_L_c_tRNA
# 117	M_gly_L_c_tRNA
# 118	M_his_L_c_tRNA
# 119	M_ile_L_c_tRNA
# 120	M_leu_L_c_tRNA
# 121	M_lys_L_c_tRNA
# 122	M_met_L_c_tRNA
# 123	M_phe_L_c_tRNA
# 124	M_pro_L_c_tRNA
# 125	M_ser_L_c_tRNA
# 126	M_thr_L_c_tRNA
# 127	M_trp_L_c_tRNA
# 128	M_tyr_L_c_tRNA
# 129	M_val_L_c_tRNA
# 130	PROTEIN_F2
# 131	tRNA

# Reaction model vector -
# 1	R_malS	 => 	R_malS: M_maltose_c+M_h2o_c -([])-> 2*M_glc_D_c
# 2	R_PTS	 => 	R_PTS: M_pep_c+M_glc_D_c -([])-> M_g6p_c+M_pyr_c
# 3	R_glk_atp	 => 	R_glk_atp: M_atp_c+M_glc_D_c -([])-> M_adp_c+M_g6p_c+M_h_c
# 4	R_glk_utp	 => 	R_glk_utp: M_utp_c+M_glc_D_c -([])-> M_udp_c+M_g6p_c+M_h_c
# 5	R_glk_ctp	 => 	R_glk_ctp: M_ctp_c+M_glc_D_c -([])-> M_cdp_c+M_g6p_c+M_h_c
# 6	R_glk_gtp	 => 	R_glk_gtp: M_gtp_c+M_glc_D_c -([])-> M_gdp_c+M_g6p_c+M_h_c
# 7	R_pgi	 => 	R_pgi: M_g6p_c -([])-> M_f6p_c
# 8	R_pgi_reverse	 => 	-1*(R_pgi: M_g6p_c -([])-> M_f6p_c)
# 9	R_pfk	 => 	R_pfk: M_atp_c+M_f6p_c -([])-> M_adp_c+M_fdp_c+M_h_c
# 10	R_fdp	 => 	R_fdp: M_fdp_c+M_h2o_c -([])-> M_f6p_c+M_pi_c
# 11	R_fbaA	 => 	R_fbaA: M_fdp_c -([])-> M_dhap_c+M_g3p_c
# 12	R_fbaA_reverse	 => 	-1*(R_fbaA: M_fdp_c -([])-> M_dhap_c+M_g3p_c)
# 13	R_tpiA	 => 	R_tpiA: M_dhap_c -([])-> M_g3p_c
# 14	R_tpiA_reverse	 => 	-1*(R_tpiA: M_dhap_c -([])-> M_g3p_c)
# 15	R_gapA	 => 	R_gapA: M_g3p_c+M_nad_c+M_pi_c -([])-> M_13dpg_c+M_h_c+M_nadh_c
# 16	R_gapA_reverse	 => 	-1*(R_gapA: M_g3p_c+M_nad_c+M_pi_c -([])-> M_13dpg_c+M_h_c+M_nadh_c)
# 17	R_pgk	 => 	R_pgk: M_13dpg_c+M_adp_c -([])-> M_3pg_c+M_atp_c
# 18	R_pgk_reverse	 => 	-1*(R_pgk: M_13dpg_c+M_adp_c -([])-> M_3pg_c+M_atp_c)
# 19	R_gpm	 => 	R_gpm: M_3pg_c -([])-> M_2pg_c
# 20	R_gpm_reverse	 => 	-1*(R_gpm: M_3pg_c -([])-> M_2pg_c)
# 21	R_eno	 => 	R_eno: M_2pg_c -([])-> M_h2o_c+M_pep_c
# 22	R_eno_reverse	 => 	-1*(R_eno: M_2pg_c -([])-> M_h2o_c+M_pep_c)
# 23	R_pyk	 => 	R_pyk: M_adp_c+M_h_c+M_pep_c -([])-> M_atp_c+M_pyr_c
# 24	R_pck	 => 	R_pck: M_atp_c+M_oaa_c -([])-> M_adp_c+M_co2_c+M_pep_c
# 25	R_ppc	 => 	R_ppc: M_co2_c+M_h2o_c+M_pep_c -([])-> M_h_c+M_oaa_c+M_pi_c
# 26	R_pdh	 => 	R_pdh: M_coa_c+M_nad_c+M_pyr_c -([])-> M_accoa_c+M_co2_c+M_nadh_c
# 27	R_pps	 => 	R_pps: M_atp_c+M_h2o_c+M_pyr_c -([])-> M_amp_c+2*M_h_c+M_pep_c+M_pi_c
# 28	R_zwf	 => 	R_zwf: M_g6p_c+M_nadp_c -([])-> M_6pgl_c+M_h_c+M_nadph_c
# 29	R_zwf_reverse	 => 	-1*(R_zwf: M_g6p_c+M_nadp_c -([])-> M_6pgl_c+M_h_c+M_nadph_c)
# 30	R_pgl	 => 	R_pgl: M_6pgl_c+M_h2o_c -([])-> M_6pgc_c+M_h_c
# 31	R_gnd	 => 	R_gnd: M_6pgc_c+M_nadp_c -([])-> M_co2_c+M_nadph_c+M_ru5p_D_c
# 32	R_rpe	 => 	R_rpe: M_ru5p_D_c -([])-> M_xu5p_D_c
# 33	R_rpe_reverse	 => 	-1*(R_rpe: M_ru5p_D_c -([])-> M_xu5p_D_c)
# 34	R_rpi	 => 	R_rpi: M_r5p_c -([])-> M_ru5p_D_c
# 35	R_rpi_reverse	 => 	-1*(R_rpi: M_r5p_c -([])-> M_ru5p_D_c)
# 36	R_talAB	 => 	R_talAB: M_g3p_c+M_s7p_c -([])-> M_e4p_c+M_f6p_c
# 37	R_talAB_reverse	 => 	-1*(R_talAB: M_g3p_c+M_s7p_c -([])-> M_e4p_c+M_f6p_c)
# 38	R_tkt1	 => 	R_tkt1: M_r5p_c+M_xu5p_D_c -([])-> M_g3p_c+M_s7p_c
# 39	R_tkt1_reverse	 => 	-1*(R_tkt1: M_r5p_c+M_xu5p_D_c -([])-> M_g3p_c+M_s7p_c)
# 40	R_tkt2	 => 	R_tkt2: M_e4p_c+M_xu5p_D_c -([])-> M_f6p_c+M_g3p_c
# 41	R_tkt2_reverse	 => 	-1*(R_tkt2: M_e4p_c+M_xu5p_D_c -([])-> M_f6p_c+M_g3p_c)
# 42	R_edd	 => 	R_edd: M_6pgc_c -([])-> M_2ddg6p_c+M_h2o_c
# 43	R_eda	 => 	R_eda: M_2ddg6p_c -([])-> M_g3p_c+M_pyr_c
# 44	R_gltA	 => 	R_gltA: M_accoa_c+M_h2o_c+M_oaa_c -([])-> M_cit_c+M_coa_c+M_h_c
# 45	R_acn	 => 	R_acn: M_cit_c -([])-> M_icit_c
# 46	R_acn_reverse	 => 	-1*(R_acn: M_cit_c -([])-> M_icit_c)
# 47	R_icd	 => 	R_icd: M_icit_c+M_nadp_c -([])-> M_akg_c+M_co2_c+M_nadph_c
# 48	R_icd_reverse	 => 	-1*(R_icd: M_icit_c+M_nadp_c -([])-> M_akg_c+M_co2_c+M_nadph_c)
# 49	R_sucAB	 => 	R_sucAB: M_akg_c+M_coa_c+M_nad_c -([])-> M_co2_c+M_nadh_c+M_succoa_c
# 50	R_sucCD	 => 	R_sucCD: M_atp_c+M_coa_c+M_succ_c -([])-> M_adp_c+M_pi_c+M_succoa_c
# 51	R_sucCD_reverse	 => 	-1*(R_sucCD: M_atp_c+M_coa_c+M_succ_c -([])-> M_adp_c+M_pi_c+M_succoa_c)
# 52	R_sdh	 => 	R_sdh: M_q8_c+M_succ_c -([])-> M_fum_c+M_q8h2_c
# 53	R_frd	 => 	R_frd: M_fum_c+M_mql8_c -([])-> M_mqn8_c+M_succ_c
# 54	R_fum	 => 	R_fum: M_fum_c+M_h2o_c -([])-> M_mal_L_c
# 55	R_fum_reverse	 => 	-1*(R_fum: M_fum_c+M_h2o_c -([])-> M_mal_L_c)
# 56	R_mdh	 => 	R_mdh: M_mal_L_c+M_nad_c -([])-> M_oaa_c+M_h_c+M_nadh_c
# 57	R_mdh_reverse	 => 	-1*(R_mdh: M_mal_L_c+M_nad_c -([])-> M_oaa_c+M_h_c+M_nadh_c)
# 58	R_aceA	 => 	R_aceA: M_icit_c -([])-> M_glx_c+M_succ_c
# 59	R_aceB	 => 	R_aceB: M_accoa_c+M_glx_c+M_h2o_c -([])-> M_coa_c+M_h_c+M_mal_L_c
# 60	R_maeA	 => 	R_maeA: M_mal_L_c+M_nad_c -([])-> M_co2_c+M_nadh_c+M_pyr_c
# 61	R_maeB	 => 	R_maeB: M_mal_L_c+M_nadp_c -([])-> M_co2_c+M_nadph_c+M_pyr_c
# 62	R_pta	 => 	R_pta: M_accoa_c+M_pi_c -([])-> M_actp_c+M_coa_c
# 63	R_pta_reverse	 => 	-1*(R_pta: M_accoa_c+M_pi_c -([])-> M_actp_c+M_coa_c)
# 64	R_ackA	 => 	R_ackA: M_actp_c+M_adp_c -([])-> M_ac_c+M_atp_c
# 65	R_ackA_reverse	 => 	-1*(R_ackA: M_actp_c+M_adp_c -([])-> M_ac_c+M_atp_c)
# 66	R_acs	 => 	R_acs: M_ac_c+M_atp_c+M_coa_c -([])-> M_accoa_c+M_amp_c+M_ppi_c
# 67	R_adhE	 => 	R_adhE: M_accoa_c+2*M_h_c+2*M_nadh_c -([])-> M_coa_c+M_etoh_c+2*M_nad_c
# 68	R_adhE_reverse	 => 	-1*(R_adhE: M_accoa_c+2*M_h_c+2*M_nadh_c -([])-> M_coa_c+M_etoh_c+2*M_nad_c)
# 69	R_ldh_f	 => 	R_ldh_f: M_pyr_c+M_nadh_c+M_h_c -([])-> M_lac_D_c+M_nad_c
# 70	R_ldh_r	 => 	R_ldh_r: M_lac_D_c+M_nad_c -([])-> M_pyr_c+M_nadh_c+M_h_c
# 71	R_pflAB	 => 	R_pflAB: M_coa_c+M_pyr_c -([])-> M_accoa_c+M_for_c
# 72	R_cyd	 => 	R_cyd: 2*M_h_c+0.5*M_o2_c+M_q8h2_c -([])-> M_h2o_c+M_q8_c+2*M_h_e
# 73	R_app	 => 	R_app: 2*M_h_c+M_mql8_c+0.5*M_o2_c -([])-> M_h2o_c+M_mqn8_c+2*M_h_e
# 74	R_atp	 => 	R_atp: M_adp_c+M_pi_c+4*M_h_e -([])-> M_atp_c+3*M_h_c+M_h2o_c
# 75	R_nuo	 => 	R_nuo: 3*M_h_c+M_nadh_c+M_q8_c -([])-> M_nad_c+M_q8h2_c+2*M_h_e
# 76	R_pnt1	 => 	R_pnt1: M_nad_c+M_nadph_c -([])-> M_nadh_c+M_nadp_c
# 77	R_pnt2	 => 	R_pnt2: M_nadh_c+M_nadp_c+2*M_h_e -([])-> 2*M_h_c+M_nad_c+M_nadph_c
# 78	R_ndh1	 => 	R_ndh1: M_h_c+M_nadh_c+M_q8_c -([])-> M_nad_c+M_q8h2_c
# 79	R_ndh2	 => 	R_ndh2: M_h_c+M_mqn8_c+M_nadh_c -([])-> M_mql8_c+M_nad_c
# 80	R_hack1	 => 	R_hack1: M_atp_c+M_h2o_c -([])-> M_adp_c+M_h_c+M_pi_c
# 81	R_ppk	 => 	R_ppk: M_atp_c+M_pi_c -([])-> M_adp_c+M_ppi_c
# 82	R_ppa	 => 	R_ppa: M_ppi_c+M_h2o_c -([])-> 2*M_pi_c+M_h_c
# 83	R_chor	 => 	R_chor: M_e4p_c+2*M_pep_c+M_nadph_c+M_atp_c -([])-> M_chor_c+M_nadp_c+M_adp_c+4*M_pi_c
# 84	R_gar	 => 	R_gar: M_r5p_c+M_gln_L_c+M_gly_L_c+2*M_atp_c+M_h2o_c -([])-> M_gar_c+M_glu_L_c+M_adp_c+M_amp_c+M_pi_c+M_ppi_c+7*M_h_c
# 85	R_air	 => 	R_air: M_gar_c+M_10fthf_c+M_gln_L_c+2*M_atp_c+M_h2o_c -([])-> M_air_c+M_thf_c+M_glu_L_c+2*M_adp_c+2*M_pi_c+3*M_h_c
# 86	R_aicar	 => 	R_aicar: M_air_c+M_asp_L_c+2*M_atp_c+M_hco3_c -([])-> M_aicar_c+M_fum_c+2*M_adp_c+2*M_h_c+2*M_pi_c
# 87	R_imp	 => 	R_imp: M_aicar_c+M_10fthf_c -([])-> M_imp_c+M_thf_c+M_h2o_c
# 88	R_mthfc	 => 	R_mthfc: M_h2o_c+M_methf_c -([])-> M_10fthf_c
# 89	R_mthfc_reverse	 => 	-1*(R_mthfc: M_h2o_c+M_methf_c -([])-> M_10fthf_c)
# 90	R_mthfd	 => 	R_mthfd: M_mlthf_c+M_nadp_c -([])-> M_h_c+M_methf_c+M_nadph_c
# 91	R_mthfd_reverse	 => 	-1*(R_mthfd: M_mlthf_c+M_nadp_c -([])-> M_h_c+M_methf_c+M_nadph_c)
# 92	R_mthfr2	 => 	R_mthfr2: M_mlthf_c+M_h_c+M_nadh_c -([])-> M_5mthf_c+M_nad_c
# 93	R_gmp	 => 	R_gmp: M_imp_c+M_atp_c+M_gln_L_c+M_nad_c+2*M_h2o_c -([])-> M_gmp_c+M_amp_c+M_glu_L_c+M_nadh_c+3*M_h_c+M_ppi_c
# 94	R_gdp	 => 	R_gdp: M_gmp_c+M_atp_c -([])-> M_gdp_c+M_adp_c
# 95	R_gtp	 => 	R_gtp: M_gdp_c+M_atp_c -([])-> M_gtp_c+M_adp_c
# 96	R_amp	 => 	R_amp: M_asp_L_c+M_imp_c+M_gtp_c -([])-> M_amp_c+M_gdp_c+M_pi_c+2*M_h_c+M_fum_c
# 97	R_adk	 => 	R_adk: M_amp_c+M_atp_c -([])-> 2*M_adp_c
# 98	R_adk_reverse	 => 	-1*(R_adk: M_amp_c+M_atp_c -([])-> 2*M_adp_c)
# 99	R_ump	 => 	R_ump: M_gln_L_c+M_asp_L_c+M_r5p_c+M_q8_c+3*M_atp_c+M_hco3_c -([])-> M_ump_c+M_glu_L_c+M_q8h2_c+2*M_h_c+2*M_adp_c+M_amp_c+2*M_pi_c+M_ppi_c+M_co2_c
# 100	R_udp	 => 	R_udp: M_ump_c+M_atp_c -([])-> M_udp_c+M_adp_c
# 101	R_utp	 => 	R_utp: M_udp_c+M_atp_c -([])-> M_utp_c+M_adp_c
# 102	R_ctp	 => 	R_ctp: M_utp_c+M_gln_L_c+M_atp_c+M_h2o_c -([])-> M_ctp_c+M_glu_L_c+M_adp_c+M_pi_c+3*M_h_c
# 103	R_cdp	 => 	R_cdp: M_ctp_c+M_h2o_c -([])-> M_cdp_c+M_pi_c+M_h_c
# 104	R_cmp	 => 	R_cmp: M_cdp_c+M_h2o_c -([])-> M_cmp_c+M_pi_c+M_h_c
# 105	R_alaAC	 => 	R_alaAC: M_pyr_c+M_glu_L_c -([])-> M_ala_L_c+M_akg_c
# 106	R_arg	 => 	R_arg: M_glu_L_c+M_accoa_c+4*M_atp_c+M_nadph_c+3*M_h2o_c+M_gln_L_c+M_asp_L_c+M_co2_c -([])-> M_arg_L_c+M_coa_c+5*M_h_c+3*M_adp_c+3*M_pi_c+M_nadp_c+M_akg_c+M_ac_c+M_amp_c+M_ppi_c+M_fum_c
# 107	R_aspA	 => 	R_aspA: M_fum_c+M_nh4_c -([])-> M_asp_L_c
# 108	R_aspA_reverse	 => 	-1*(R_aspA: M_fum_c+M_nh4_c -([])-> M_asp_L_c)
# 109	R_aspC	 => 	R_aspC: M_glu_L_c+M_oaa_c -([])-> M_asp_L_c+M_akg_c
# 110	R_asnB	 => 	R_asnB: M_asp_L_c+M_gln_L_c+M_h2o_c+M_atp_c -([])-> M_asn_L_c+M_glu_L_c+M_h_c+M_ppi_c+M_amp_c
# 111	R_asnA	 => 	R_asnA: M_asp_L_c+M_atp_c+M_nh4_c -([])-> M_asn_L_c+M_h_c+M_ppi_c+M_amp_c
# 112	R_cysEMK	 => 	R_cysEMK: M_ser_L_c+M_accoa_c+M_h2s_c -([])-> M_cys_L_c+M_coa_c+M_h_c+M_ac_c
# 113	R_gltBD	 => 	R_gltBD: M_gln_L_c+M_akg_c+M_nadph_c+M_h_c -([])-> 2*M_glu_L_c+M_nadp_c
# 114	R_gdhA	 => 	R_gdhA: M_akg_c+M_nadph_c+M_nh4_c+M_h_c -([])-> M_glu_L_c+M_h2o_c+M_nadp_c
# 115	R_glnA	 => 	R_glnA: M_glu_L_c+M_atp_c+M_nh4_c -([])-> M_gln_L_c+M_h_c+M_adp_c+M_pi_c
# 116	R_glyA	 => 	R_glyA: M_ser_L_c+M_thf_c -([])-> M_gly_L_c+M_h2o_c+M_mlthf_c
# 117	R_his	 => 	R_his: M_gln_L_c+M_r5p_c+3*M_atp_c+2*M_nad_c+3*M_h2o_c -([])-> M_his_L_c+M_akg_c+M_aicar_c+2*M_adp_c+2*M_nadh_c+M_pi_c+2*M_ppi_c+6*M_h_c
# 118	R_ile	 => 	R_ile: M_thr_L_c+2*M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c -([])-> M_ile_L_c+M_h2o_c+M_nh4_c+M_co2_c+M_nadp_c+M_akg_c
# 119	R_leu	 => 	R_leu: 2*M_pyr_c+M_glu_L_c+M_h_c+M_nad_c+M_nadph_c+M_accoa_c -([])-> M_leu_L_c+2*M_co2_c+M_nadp_c+M_coa_c+M_nadh_c+M_akg_c
# 120	R_lys	 => 	R_lys: M_asp_L_c+M_atp_c+2*M_nadph_c+2*M_h_c+M_pyr_c+M_succoa_c+M_glu_L_c -([])-> M_lys_L_c+M_adp_c+M_pi_c+2*M_nadp_c+M_coa_c+M_akg_c+M_succ_c+M_co2_c
# 121	R_met	 => 	R_met: M_asp_L_c+M_cys_L_c+M_succoa_c+M_atp_c+2*M_nadph_c+M_5mthf_c -([])-> M_met_L_c+M_coa_c+M_succ_c+M_adp_c+M_pi_c+2*M_nadp_c+M_thf_c+M_nh4_c+M_pyr_c
# 122	R_phe	 => 	R_phe: M_chor_c+M_h_c+M_glu_L_c -([])-> M_phe_L_c+M_co2_c+M_h2o_c+M_akg_c
# 123	R_pro	 => 	R_pro: M_glu_L_c+M_atp_c+2*M_h_c+2*M_nadph_c -([])-> M_pro_L_c+M_adp_c+2*M_nadp_c+M_pi_c+M_h2o_c
# 124	R_serABC	 => 	R_serABC: M_3pg_c+M_nad_c+M_glu_L_c+M_h2o_c -([])-> M_ser_L_c+M_nadh_c+M_h_c+M_akg_c+M_pi_c
# 125	R_thr	 => 	R_thr: M_asp_L_c+2*M_atp_c+2*M_nadph_c+M_h_c+M_h2o_c -([])-> M_thr_L_c+2*M_adp_c+2*M_pi_c+2*M_nadp_c
# 126	R_trp	 => 	R_trp: M_chor_c+M_gln_L_c+M_ser_L_c+M_r5p_c+2*M_atp_c -([])-> M_trp_L_c+M_glu_L_c+M_pyr_c+M_ppi_c+2*M_h2o_c+M_co2_c+M_g3p_c+2*M_adp_c+M_h_c
# 127	R_tyr	 => 	R_tyr: M_chor_c+M_glu_L_c+M_nad_c -([])-> M_tyr_L_c+M_akg_c+M_nadh_c+M_co2_c
# 128	R_val	 => 	R_val: 2*M_pyr_c+2*M_h_c+M_nadph_c+M_glu_L_c -([])-> M_val_L_c+M_co2_c+M_nadp_c+M_h2o_c+M_akg_c
# 129	R_arg_deg1	 => 	R_arg_deg1: M_arg_L_c+5.0*M_h2o_c+M_atp_c+M_o2_c+2.0*M_nad_c+M_akg_c -([])-> 4.0*M_h_c+M_co2_c+M_urea_c+M_glu_L_c+M_pi_c+M_adp_c+M_nh4_c+M_h2o2_c+2.0*M_nadh_c+M_succ_c
# 130	R_arg_deg2	 => 	R_arg_deg2: M_arg_L_c+5.0*M_h2o_c+M_atp_c+M_o2_c+M_nad_c+M_nadp_c+M_akg_c -([])-> 4.0*M_h_c+M_co2_c+M_urea_c+M_glu_L_c+M_pi_c+M_adp_c+M_nh4_c+M_h2o2_c+M_nadh_c+M_nadph_c+M_succ_c
# 131	R_arg_deg3	 => 	R_arg_deg3: M_arg_L_c+5.0*M_h2o_c+M_atp_c+M_o2_c+2.0*M_nadp_c+M_akg_c -([])-> 4.0*M_h_c+M_co2_c+M_urea_c+M_glu_L_c+M_pi_c+M_adp_c+M_nh4_c+M_h2o2_c+2.0*M_nadph_c+M_succ_c
# 132	R_arg_deg4	 => 	R_arg_deg4: M_arg_L_c+3.0*M_h2o_c+2.0*M_akg_c+2.0*M_nad_c -([])-> 3.0*M_h_c+M_co2_c+M_urea_c+2.0*M_glu_L_c+2.0*M_nadh_c+M_succ_c
# 133	R_arg_deg5	 => 	R_arg_deg5: M_arg_L_c+3.0*M_h2o_c+2.0*M_akg_c+M_nad_c+M_nadp_c -([])-> 3.0*M_h_c+M_co2_c+M_urea_c+2.0*M_glu_L_c+M_nadh_c+M_nadph_c+M_succ_c
# 134	R_arg_deg6	 => 	R_arg_deg6: M_arg_L_c+M_accoa_c+4.0*M_h2o_c+M_akg_c+M_nad_c -([])-> M_coa_c+M_h_c+M_co2_c+2.0*M_nh4_c+2.0*M_glu_L_c+M_nadh_c+M_succ_c
# 135	R_thr_deg1	 => 	R_thr_deg1: M_thr_L_c+M_nad_c+M_coa_c -([])-> M_nadh_c+M_h_c+M_accoa_c+M_gly_L_c
# 136	R_thr_deg2	 => 	R_thr_deg2: M_thr_L_c+M_nad_c+M_o2_c+M_h2o_c -([])-> M_nadh_c+M_co2_c+M_h2o2_c+M_nh4_c+M_mglx_c
# 137	R_thr_deg3	 => 	R_thr_deg3: M_thr_L_c+M_coa_c+M_nad_c -([])-> M_gly_L_c+M_accoa_c+M_nadh_c+M_h_c
# 138	R_thr_deg4	 => 	R_thr_deg4: M_thr_L_c+M_pi_c+M_adp_c -([])-> M_h_c+M_h2o_c+M_for_c+M_atp_c+M_prop_c
# 139	R_thr_deg5	 => 	R_thr_deg5: M_thr_L_c+M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c -([])-> 2.0*M_h2o_c+M_co2_c+M_nadp_c+M_akg_c+M_ile_L_c
# 140	R_gly_deg	 => 	R_gly_deg: M_gly_L_c+M_accoa_c+M_h_c+M_o2_c+M_h2o_c -([])-> M_coa_c+M_co2_c+M_h2o2_c+M_nh4_c+M_mglx_c
# 141	R_mglx_deg	 => 	R_mglx_deg: M_mglx_c+M_nadp_c+M_h2o_c -([])-> M_pyr_c+M_nadph_c+M_h_c
# 142	R_mglx_deg_reverse	 => 	-1*(R_mglx_deg: M_mglx_c+M_nadp_c+M_h2o_c -([])-> M_pyr_c+M_nadph_c+M_h_c)
# 143	R_ser_deg	 => 	R_ser_deg: M_ser_L_c -([])-> M_nh4_c+M_pyr_c
# 144	R_pro_deg	 => 	R_pro_deg: M_pro_L_c+M_q8_c+2.0*M_h2o_c+M_nad_c -([])-> 2.0*M_h_c+M_q8h2_c+M_nadh_c+M_glu_L_c
# 145	R_trp_deg	 => 	R_trp_deg: M_trp_L_c+M_h2o_c -([])-> M_indole_c+M_nh4_c+M_pyr_c
# 146	R_cys_deg	 => 	R_cys_deg: M_cys_L_c+M_h2o_c -([])-> M_h2s_c+M_nh4_c+M_pyr_c
# 147	R_ala_deg	 => 	R_ala_deg: M_ala_L_c+M_h2o_c+M_q8_c -([])-> M_q8h2_c+M_nh4_c+M_pyr_c
# 148	R_lys_deg	 => 	R_lys_deg: M_lys_L_c -([])-> M_co2_c+M_cadav_c
# 149	R_gln_deg	 => 	R_gln_deg: M_gln_L_c+M_h2o_c -([])-> M_nh4_c+M_glu_L_c
# 150	R_glu_deg	 => 	R_glu_deg: M_glu_L_c+M_h_c -([])-> M_co2_c+M_gaba_c
# 151	R_gaba_deg1	 => 	R_gaba_deg1: M_gaba_c+M_akg_c+M_h2o_c+M_nad_c -([])-> M_succ_c+M_glu_L_c+2*M_h_c+M_nadh_c
# 152	R_gaba_deg2	 => 	R_gaba_deg2: M_gaba_c+M_akg_c+M_h2o_c+M_nadp_c -([])-> M_succ_c+M_glu_L_c+2*M_h_c+M_nadph_c
# 153	R_asn_deg	 => 	R_asn_deg: M_asn_L_c+M_h2o_c+M_adp_c+M_pi_c -([])-> M_nh4_c+M_asp_L_c+M_atp_c
# 154	R_amp_ppi	 => 	R_amp_ppi: M_amp_c+M_ppi_c+4*M_h_c -([])-> M_atp_c+M_h2o_c
# 155	R_amp_pi	 => 	R_amp_pi: M_amp_c+2*M_pi_c+6*M_h_c -([])-> M_atp_c+2*M_h2o_c
# 156	R_gmp_ppi	 => 	R_gmp_ppi: M_gmp_c+M_ppi_c+4*M_h_c -([])-> M_gtp_c+M_h2o_c
# 157	R_gmp_pi	 => 	R_gmp_pi: M_gmp_c+2*M_pi_c+6*M_h_c -([])-> M_gtp_c+2*M_h2o_c
# 158	R_cmp_ppi	 => 	R_cmp_ppi: M_cmp_c+M_ppi_c+4*M_h_c -([])-> M_ctp_c+M_h2o_c
# 159	R_cmp_pi	 => 	R_cmp_pi: M_cmp_c+2*M_pi_c+6*M_h_c -([])-> M_ctp_c+2*M_h2o_c
# 160	R_ump_ppi	 => 	R_ump_ppi: M_ump_c+M_ppi_c+4*M_h_c -([])-> M_utp_c+M_h2o_c
# 161	R_ump_pi	 => 	R_ump_pi: M_ump_c+2*M_pi_c+6*M_h_c -([])-> M_utp_c+2*M_h2o_c
# 162	transcriptional_initiation_F2	 => 	transcriptional_initiation_F2: GENE_F2+RNAP -([])-> OPEN_GENE_F2
# 163	transcription_F2	 => 	transcription_F2: OPEN_GENE_F2+397*M_gtp_c+360*M_ctp_c+381*M_utp_c+445*M_atp_c -([])-> mRNA_F2+GENE_F2+RNAP+3166*M_pi_c
# 164	mRNA_degradation_F2	 => 	mRNA_degradation_F2: mRNA_F2 -([])-> 397*M_gmp_c+360*M_cmp_c+381*M_ump_c+445*M_amp_c
# 165	translation_initiation_F2	 => 	translation_initiation_F2: mRNA_F2+RIBOSOME -([])-> RIBOSOME_START_F2
# 166	translation_F2	 => 	translation_F2: RIBOSOME_START_F2+848*M_gtp_c+22.0*M_ala_L_c_tRNA+19.0*M_arg_L_c_tRNA+20.0*M_asn_L_c_tRNA+28.0*M_asp_L_c_tRNA+9.0*M_cys_L_c_tRNA+38.0*M_glu_L_c_tRNA+14.0*M_gln_L_c_tRNA+22.0*M_gly_L_c_tRNA+10.0*M_his_L_c_tRNA+26.0*M_ile_L_c_tRNA+45.0*M_leu_L_c_tRNA+24.0*M_lys_L_c_tRNA+12.0*M_met_L_c_tRNA+16.0*M_phe_L_c_tRNA+19.0*M_pro_L_c_tRNA+39.0*M_ser_L_c_tRNA+19.0*M_thr_L_c_tRNA+4.0*M_trp_L_c_tRNA+16.0*M_tyr_L_c_tRNA+22.0*M_val_L_c_tRNA -([])-> RIBOSOME+mRNA_F2+PROTEIN_F2+848*M_gdp_c+848*M_pi_c+424*tRNA
# 167	tRNA_charging_M_ala_L_c_F2	 => 	tRNA_charging_M_ala_L_c_F2: 22.0*M_ala_L_c+22.0*M_atp_c+22.0*tRNA -([])-> 22.0*M_ala_L_c_tRNA+22.0*M_amp_c+44.0*M_pi_c
# 168	tRNA_charging_M_arg_L_c_F2	 => 	tRNA_charging_M_arg_L_c_F2: 19.0*M_arg_L_c+19.0*M_atp_c+19.0*tRNA -([])-> 19.0*M_arg_L_c_tRNA+19.0*M_amp_c+38.0*M_pi_c
# 169	tRNA_charging_M_asn_L_c_F2	 => 	tRNA_charging_M_asn_L_c_F2: 20.0*M_asn_L_c+20.0*M_atp_c+20.0*tRNA -([])-> 20.0*M_asn_L_c_tRNA+20.0*M_amp_c+40.0*M_pi_c
# 170	tRNA_charging_M_asp_L_c_F2	 => 	tRNA_charging_M_asp_L_c_F2: 28.0*M_asp_L_c+28.0*M_atp_c+28.0*tRNA -([])-> 28.0*M_asp_L_c_tRNA+28.0*M_amp_c+56.0*M_pi_c
# 171	tRNA_charging_M_cys_L_c_F2	 => 	tRNA_charging_M_cys_L_c_F2: 9.0*M_cys_L_c+9.0*M_atp_c+9.0*tRNA -([])-> 9.0*M_cys_L_c_tRNA+9.0*M_amp_c+18.0*M_pi_c
# 172	tRNA_charging_M_glu_L_c_F2	 => 	tRNA_charging_M_glu_L_c_F2: 38.0*M_glu_L_c+38.0*M_atp_c+38.0*tRNA -([])-> 38.0*M_glu_L_c_tRNA+38.0*M_amp_c+76.0*M_pi_c
# 173	tRNA_charging_M_gln_L_c_F2	 => 	tRNA_charging_M_gln_L_c_F2: 14.0*M_gln_L_c+14.0*M_atp_c+14.0*tRNA -([])-> 14.0*M_gln_L_c_tRNA+14.0*M_amp_c+28.0*M_pi_c
# 174	tRNA_charging_M_gly_L_c_F2	 => 	tRNA_charging_M_gly_L_c_F2: 22.0*M_gly_L_c+22.0*M_atp_c+22.0*tRNA -([])-> 22.0*M_gly_L_c_tRNA+22.0*M_amp_c+44.0*M_pi_c
# 175	tRNA_charging_M_his_L_c_F2	 => 	tRNA_charging_M_his_L_c_F2: 10.0*M_his_L_c+10.0*M_atp_c+10.0*tRNA -([])-> 10.0*M_his_L_c_tRNA+10.0*M_amp_c+20.0*M_pi_c
# 176	tRNA_charging_M_ile_L_c_F2	 => 	tRNA_charging_M_ile_L_c_F2: 26.0*M_ile_L_c+26.0*M_atp_c+26.0*tRNA -([])-> 26.0*M_ile_L_c_tRNA+26.0*M_amp_c+52.0*M_pi_c
# 177	tRNA_charging_M_leu_L_c_F2	 => 	tRNA_charging_M_leu_L_c_F2: 45.0*M_leu_L_c+45.0*M_atp_c+45.0*tRNA -([])-> 45.0*M_leu_L_c_tRNA+45.0*M_amp_c+90.0*M_pi_c
# 178	tRNA_charging_M_lys_L_c_F2	 => 	tRNA_charging_M_lys_L_c_F2: 24.0*M_lys_L_c+24.0*M_atp_c+24.0*tRNA -([])-> 24.0*M_lys_L_c_tRNA+24.0*M_amp_c+48.0*M_pi_c
# 179	tRNA_charging_M_met_L_c_F2	 => 	tRNA_charging_M_met_L_c_F2: 12.0*M_met_L_c+12.0*M_atp_c+12.0*tRNA -([])-> 12.0*M_met_L_c_tRNA+12.0*M_amp_c+24.0*M_pi_c
# 180	tRNA_charging_M_phe_L_c_F2	 => 	tRNA_charging_M_phe_L_c_F2: 16.0*M_phe_L_c+16.0*M_atp_c+16.0*tRNA -([])-> 16.0*M_phe_L_c_tRNA+16.0*M_amp_c+32.0*M_pi_c
# 181	tRNA_charging_M_pro_L_c_F2	 => 	tRNA_charging_M_pro_L_c_F2: 19.0*M_pro_L_c+19.0*M_atp_c+19.0*tRNA -([])-> 19.0*M_pro_L_c_tRNA+19.0*M_amp_c+38.0*M_pi_c
# 182	tRNA_charging_M_ser_L_c_F2	 => 	tRNA_charging_M_ser_L_c_F2: 39.0*M_ser_L_c+39.0*M_atp_c+39.0*tRNA -([])-> 39.0*M_ser_L_c_tRNA+39.0*M_amp_c+78.0*M_pi_c
# 183	tRNA_charging_M_thr_L_c_F2	 => 	tRNA_charging_M_thr_L_c_F2: 19.0*M_thr_L_c+19.0*M_atp_c+19.0*tRNA -([])-> 19.0*M_thr_L_c_tRNA+19.0*M_amp_c+38.0*M_pi_c
# 184	tRNA_charging_M_trp_L_c_F2	 => 	tRNA_charging_M_trp_L_c_F2: 4.0*M_trp_L_c+4.0*M_atp_c+4.0*tRNA -([])-> 4.0*M_trp_L_c_tRNA+4.0*M_amp_c+8.0*M_pi_c
# 185	tRNA_charging_M_tyr_L_c_F2	 => 	tRNA_charging_M_tyr_L_c_F2: 16.0*M_tyr_L_c+16.0*M_atp_c+16.0*tRNA -([])-> 16.0*M_tyr_L_c_tRNA+16.0*M_amp_c+32.0*M_pi_c
# 186	tRNA_charging_M_val_L_c_F2	 => 	tRNA_charging_M_val_L_c_F2: 22.0*M_val_L_c+22.0*M_atp_c+22.0*tRNA -([])-> 22.0*M_val_L_c_tRNA+22.0*M_amp_c+44.0*M_pi_c
# 187	tNRA_exchange	 => 	tNRA_exchange: tRNA -([])-> []
# 188	tNRA_exchange_reverse	 => 	-1*(tNRA_exchange: tRNA -([])-> [])
# 189	PROTEIN_export_F2	 => 	PROTEIN_export_F2: PROTEIN_F2 -([])-> []
# 190	M_ala_L_c_exchange	 => 	M_ala_L_c_exchange: M_ala_L_c -([])-> []
# 191	M_ala_L_c_exchange_reverse	 => 	-1*(M_ala_L_c_exchange: M_ala_L_c -([])-> [])
# 192	M_arg_L_c_exchange	 => 	M_arg_L_c_exchange: M_arg_L_c -([])-> []
# 193	M_arg_L_c_exchange_reverse	 => 	-1*(M_arg_L_c_exchange: M_arg_L_c -([])-> [])
# 194	M_asn_L_c_exchange	 => 	M_asn_L_c_exchange: M_asn_L_c -([])-> []
# 195	M_asn_L_c_exchange_reverse	 => 	-1*(M_asn_L_c_exchange: M_asn_L_c -([])-> [])
# 196	M_asp_L_c_exchange	 => 	M_asp_L_c_exchange: M_asp_L_c -([])-> []
# 197	M_asp_L_c_exchange_reverse	 => 	-1*(M_asp_L_c_exchange: M_asp_L_c -([])-> [])
# 198	M_cys_L_c_exchange	 => 	M_cys_L_c_exchange: M_cys_L_c -([])-> []
# 199	M_cys_L_c_exchange_reverse	 => 	-1*(M_cys_L_c_exchange: M_cys_L_c -([])-> [])
# 200	M_glu_L_c_exchange	 => 	M_glu_L_c_exchange: M_glu_L_c -([])-> []
# 201	M_glu_L_c_exchange_reverse	 => 	-1*(M_glu_L_c_exchange: M_glu_L_c -([])-> [])
# 202	M_gln_L_c_exchange	 => 	M_gln_L_c_exchange: M_gln_L_c -([])-> []
# 203	M_gln_L_c_exchange_reverse	 => 	-1*(M_gln_L_c_exchange: M_gln_L_c -([])-> [])
# 204	M_gly_L_c_exchange	 => 	M_gly_L_c_exchange: M_gly_L_c -([])-> []
# 205	M_gly_L_c_exchange_reverse	 => 	-1*(M_gly_L_c_exchange: M_gly_L_c -([])-> [])
# 206	M_his_L_c_exchange	 => 	M_his_L_c_exchange: M_his_L_c -([])-> []
# 207	M_his_L_c_exchange_reverse	 => 	-1*(M_his_L_c_exchange: M_his_L_c -([])-> [])
# 208	M_ile_L_c_exchange	 => 	M_ile_L_c_exchange: M_ile_L_c -([])-> []
# 209	M_ile_L_c_exchange_reverse	 => 	-1*(M_ile_L_c_exchange: M_ile_L_c -([])-> [])
# 210	M_leu_L_c_exchange	 => 	M_leu_L_c_exchange: M_leu_L_c -([])-> []
# 211	M_leu_L_c_exchange_reverse	 => 	-1*(M_leu_L_c_exchange: M_leu_L_c -([])-> [])
# 212	M_lys_L_c_exchange	 => 	M_lys_L_c_exchange: M_lys_L_c -([])-> []
# 213	M_lys_L_c_exchange_reverse	 => 	-1*(M_lys_L_c_exchange: M_lys_L_c -([])-> [])
# 214	M_met_L_c_exchange	 => 	M_met_L_c_exchange: M_met_L_c -([])-> []
# 215	M_met_L_c_exchange_reverse	 => 	-1*(M_met_L_c_exchange: M_met_L_c -([])-> [])
# 216	M_phe_L_c_exchange	 => 	M_phe_L_c_exchange: M_phe_L_c -([])-> []
# 217	M_phe_L_c_exchange_reverse	 => 	-1*(M_phe_L_c_exchange: M_phe_L_c -([])-> [])
# 218	M_pro_L_c_exchange	 => 	M_pro_L_c_exchange: M_pro_L_c -([])-> []
# 219	M_pro_L_c_exchange_reverse	 => 	-1*(M_pro_L_c_exchange: M_pro_L_c -([])-> [])
# 220	M_ser_L_c_exchange	 => 	M_ser_L_c_exchange: M_ser_L_c -([])-> []
# 221	M_ser_L_c_exchange_reverse	 => 	-1*(M_ser_L_c_exchange: M_ser_L_c -([])-> [])
# 222	M_thr_L_c_exchange	 => 	M_thr_L_c_exchange: M_thr_L_c -([])-> []
# 223	M_thr_L_c_exchange_reverse	 => 	-1*(M_thr_L_c_exchange: M_thr_L_c -([])-> [])
# 224	M_trp_L_c_exchange	 => 	M_trp_L_c_exchange: M_trp_L_c -([])-> []
# 225	M_trp_L_c_exchange_reverse	 => 	-1*(M_trp_L_c_exchange: M_trp_L_c -([])-> [])
# 226	M_tyr_L_c_exchange	 => 	M_tyr_L_c_exchange: M_tyr_L_c -([])-> []
# 227	M_tyr_L_c_exchange_reverse	 => 	-1*(M_tyr_L_c_exchange: M_tyr_L_c -([])-> [])
# 228	M_val_L_c_exchange	 => 	M_val_L_c_exchange: M_val_L_c -([])-> []
# 229	M_val_L_c_exchange_reverse	 => 	-1*(M_val_L_c_exchange: M_val_L_c -([])-> [])
# 230	M_o2_c_exchange	 => 	M_o2_c_exchange: M_o2_c -([])-> []
# 231	M_o2_c_exchange_reverse	 => 	-1*(M_o2_c_exchange: M_o2_c -([])-> [])
# 232	M_co2_c_exchange	 => 	M_co2_c_exchange: M_co2_c -([])-> []
# 233	M_co2_c_exchange_reverse	 => 	-1*(M_co2_c_exchange: M_co2_c -([])-> [])
# 234	M_h2s_c_exchange	 => 	M_h2s_c_exchange: M_h2s_c -([])-> []
# 235	M_h2s_c_exchange_reverse	 => 	-1*(M_h2s_c_exchange: M_h2s_c -([])-> [])
# 236	M_h_c_exchange	 => 	M_h_c_exchange: M_h_c -([])-> []
# 237	M_h_c_exchange_reverse	 => 	-1*(M_h_c_exchange: M_h_c -([])-> [])
# 238	M_h2o_c_exchange	 => 	M_h2o_c_exchange: M_h2o_c -([])-> []
# 239	M_h2o_c_exchange_reverse	 => 	-1*(M_h2o_c_exchange: M_h2o_c -([])-> [])
# 240	M_h_e_exchange	 => 	M_h_e_exchange: M_h_e -([])-> M_h_c
# 241	M_h_e_exchange_reverse	 => 	-1*(M_h_e_exchange: M_h_e -([])-> M_h_c)
# 242	M_nh4_c_exchange	 => 	M_nh4_c_exchange: M_nh4_c -([])-> []
# 243	M_nh4_c_exchange_reverse	 => 	-1*(M_nh4_c_exchange: M_nh4_c -([])-> [])
# 244	M_hco3_c_exchange	 => 	M_hco3_c_exchange: M_hco3_c -([])-> []
# 245	M_hco3_c_exchange_reverse	 => 	-1*(M_hco3_c_exchange: M_hco3_c -([])-> [])
# 246	M_pi_c_exchange	 => 	M_pi_c_exchange: M_pi_c -([])-> []
# 247	M_pi_c_exchange_reverse	 => 	-1*(M_pi_c_exchange: M_pi_c -([])-> [])
# 248	M_maltose_c_exchange	 => 	M_maltose_c_exchange: M_maltose_c -([])-> []
# 249	M_maltose_c_exchange_reverse	 => 	-1*(M_maltose_c_exchange: M_maltose_c -([])-> [])
# 250	M_glc_D_c_exchange	 => 	M_glc_D_c_exchange: M_glc_D_c -([])-> []
# 251	M_glc_D_c_exchange_reverse	 => 	-1*(M_glc_D_c_exchange: M_glc_D_c -([])-> [])
# 252	M_for_c_exchange	 => 	M_for_c_exchange: M_for_c -([])-> []
# 253	M_for_c_exchange_reverse	 => 	-1*(M_for_c_exchange: M_for_c -([])-> [])
# 254	M_lac_D_c_exchange	 => 	M_lac_D_c_exchange: M_lac_D_c -([])-> []
# 255	M_lac_D_c_exchange_reverse	 => 	-1*(M_lac_D_c_exchange: M_lac_D_c -([])-> [])
# 256	M_ac_c_exchange	 => 	M_ac_c_exchange: M_ac_c -([])-> []
# 257	M_ac_c_exchange_reverse	 => 	-1*(M_ac_c_exchange: M_ac_c -([])-> [])
# 258	M_etoh_c_exchange	 => 	M_etoh_c_exchange: M_etoh_c -([])-> []
# 259	M_etoh_c_exchange_reverse	 => 	-1*(M_etoh_c_exchange: M_etoh_c -([])-> [])
# 260	M_mglx_c_exchange	 => 	M_mglx_c_exchange: M_mglx_c -([])-> []
# 261	M_mglx_c_exchange_reverse	 => 	-1*(M_mglx_c_exchange: M_mglx_c -([])-> [])
# 262	M_prop_c_exchange	 => 	M_prop_c_exchange: M_prop_c -([])-> []
# 263	M_prop_c_exchange_reverse	 => 	-1*(M_prop_c_exchange: M_prop_c -([])-> [])
# 264	M_indole_c_exchange	 => 	M_indole_c_exchange: M_indole_c -([])-> []
# 265	M_indole_c_exchange_reverse	 => 	-1*(M_indole_c_exchange: M_indole_c -([])-> [])
# 266	M_h2o2_c_exchange	 => 	M_h2o2_c_exchange: M_h2o2_c -([])-> []
# 267	M_h2o2_c_exchange_reverse	 => 	-1*(M_h2o2_c_exchange: M_h2o2_c -([])-> [])
# 268	M_cadav_c_exchange	 => 	M_cadav_c_exchange: M_cadav_c -([])-> []
# 269	M_cadav_c_exchange_reverse	 => 	-1*(M_cadav_c_exchange: M_cadav_c -([])-> [])
# 270	M_urea_c_exchange	 => 	M_urea_c_exchange: M_urea_c -([])-> []
# 271	M_urea_c_exchange_reverse	 => 	-1*(M_urea_c_exchange: M_urea_c -([])-> [])

function Bounds(flux_name::AbstractString, flux_model::FluxModel, species_abundance_array, control_variable::Float64)
# ----------------------------------------------------------------------------------- #
# Bounds.jl was generated using the Kwatee code generation system.
# Bounds: Updates the flux bounds for flux with key
# Username: jeffreyvarner
# Type: NFBA-JULIA
# Version: 1.0
# Generation timestamp: 07-11-2016 10:39:22
#
# Input arguments:
# flux_name  - name of the flux whose bounds we are checking
# flux_model - custom flux model
# control_variable - value of the control variable for this flux
# species_abundance_array - value of the system state at current time step
#
# Return arguments:
# lower_bound - value of the new lower bound
# upper_bound - value of the new upper bound
# constraint_type - value of the GLPK constraint type
# ----------------------------------------------------------------------------------- #

# Default is to pass the bounds and constraint type back -
lower_bound = flux_model.flux_lower_bound;
upper_bound = flux_model.flux_upper_bound;
constraint_type = flux_model.flux_constraint_type

#Glucose uptake rate
if (flux_name == "M_glc_D_c_exchange_reverse")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Oxygen uptake rate
if (flux_name == "M_o2_c_exchange_reverse")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Formate secretion rate
if (flux_name == "M_for_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Lactate secretion rate
if (flux_name == "M_lac_D_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Acetate secretion rate
if (flux_name == "M_ac_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Ethanol secretion rate
if (flux_name == "M_etoh_c_exchange")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#alpha-KG secretion rate
#if (flux_name == "M_akg_c_exchange")
#	upper_bound = 10.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Fumerate secretion rate
#if (flux_name == "M_fum_c_exchange")
#	upper_bound = 10.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Malate secretion rate
#if (flux_name == "M_mal_L_c_exchange")
#	upper_bound = 10.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Pyruvate secretion rate
#if (flux_name == "M_pyr_c_exchange")
#	upper_bound = 10.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Succinate secretion rate
#if (flux_name == "M_succ_D_c_exchange")
#	upper_bound = 10.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Maltose secretion rate
if (flux_name == "M_maltose_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#2-amino-3-oxobutanoate secretion rate
if (flux_name == "M_mglx_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Phosphoprotein(?) secretion rate
if (flux_name == "M_prop_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Indole secretion rate
if (flux_name == "M_indole_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#

#Lactate uptake rate
if (flux_name == "M_lac_D_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Acetate uptake rate
if (flux_name == "M_ac_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Ethanol uptake rate
if (flux_name == "M_etoh_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#alpha-KG uptake rate
#if (flux_name == "M_akg_c_exchange_reverse")
#	upper_bound = 0.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Fumerate uptake rate
#if (flux_name == "M_fum_c_exchange_reverse")
#	upper_bound = 0.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Malate uptake rate
#if (flux_name == "M_mal_L_c_exchange_reverse")
#	upper_bound = 0.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Pyruvate uptake rate
#if (flux_name == "M_pyr_c_exchange_reverse")
#	upper_bound = 0.0;
#	@show (flux_name,lower_bound,upper_bound)
#end

#Maltose uptake rate
if (flux_name == "M_maltose_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#2-amino-3-oxobutanoate uptake rate
if (flux_name == "M_mglx_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Phosphoprotein(?) uptake rate
if (flux_name == "M_prop_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Indole uptake rate
if (flux_name == "M_indole_c_exchange_reverse")
	upper_bound = 0.0;
	#@show (flux_name,lower_bound,upper_bound)
end

useAA = true
if useAA == true
	u_beta = 10;
else
	u_beta = 0;
end

#Amino Acids uptake rate
if (flux_name == "M_ala_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_arg_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_asn_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_asp_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_cys_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_glu_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_gln_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_gly_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_ile_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_leu_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_his_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_lys_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_met_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_phe_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_pro_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_ser_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_thr_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_trp_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_tyr_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_val_L_c_exchange_reverse")
	upper_bound = u_beta;
	#@show (flux_name,lower_bound,upper_bound)
end

if (flux_name == "M_h_e_exchange" || flux_name == "M_h_e_exchange_reverse" || flux_name == "M_h2o_c_exchange" || flux_name == "M_h2o_c_exchange_reverse")
	constraint_type = GLPK.FR
end

# Blocks -
blocked_reaction_set = data_dictionary["blocked_reaction_set"]
if (in(flux_name,blocked_reaction_set) == true)
	upper_bound = 0.0
end

# Check on computed bounds -
if (lower_bound == upper_bound)
	constraint_type = GLPK.FX
end

return (lower_bound, upper_bound, constraint_type);
end
