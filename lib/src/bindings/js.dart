@JS()
library glpk;

import 'package:js/js.dart';
// To update search for exports in glpk.js

// JS specific routines?
@JS()
external void Function(Object) glp_get_print_func();
@JS()
external void glp_set_print_func(void Function(Object) value);
@JS()
external String glp_version();
// Problem creating and modifying routines
@JS()
external Object glp_create_prob();
@JS()
external void glp_set_prob_name(Object lp, String name);
@JS()
external void glp_set_obj_name(Object lp, String name);
@JS()
external void glp_set_obj_dir(Object lp, int dir);
@JS()
external void glp_add_rows(Object lp, int nrs);
@JS()
external void glp_add_cols(Object lp, int ncs);
@JS()
external void glp_set_row_name(Object lp, int i, String name);
@JS()
external void glp_set_col_name(Object lp, int j, String name);
@JS()
external void glp_set_row_bnds(
    Object lp, int i, int type, double lb, double ub);
@JS()
external void glp_set_col_bnds(
    Object lp, int j, int type, double lb, double ub);
@JS()
external void glp_set_obj_coef(Object lp, int j, double coef);
@JS()
external void glp_set_mat_row(
    Object lp, int i, int len, List<int> ind, List<double> val);
@JS()
external void glp_set_mat_col(
    Object lp, int j, int len, List<int> ind, List<double> val);
@JS()
external void glp_load_matrix(
    Object lp, int ne, List<int> ia, List<int> ja, List<double> ar);
@JS()
external int glp_check_dup(int m, int n, int ne, List<int> ia, List<int> ja);
@JS()
external void glp_sort_matrix(Object lp);
@JS()
external void glp_del_rows(Object lp, int nrs, int num);
@JS()
external void glp_del_cols(Object lp, int ncs, int num);
@JS()
external void glp_copy_prob(Object dest, Object prob, int names);
@JS()
external void glp_erase_prob(Object lp);
// Problem retriving routines
@JS()
external String glp_get_prob_name(Object lp);
@JS()
external String glp_get_obj_name(Object lp);
@JS()
external int glp_get_obj_dir(Object lp);
@JS()
external int glp_get_num_rows(Object lp);
@JS()
external int glp_get_num_cols(Object lp);
@JS()
external String glp_get_row_name(Object lp, int i);
@JS()
external String glp_get_col_name(Object lp, int j);
@JS()
external int glp_get_row_type(Object lp, int i);
@JS()
external double glp_get_row_lb(Object lp, int i);
@JS()
external double glp_get_row_ub(Object lp, int i);
@JS()
external int glp_get_col_type(Object lp, int j);
@JS()
external double glp_get_col_lb(Object lp, int j);
@JS()
external double glp_get_col_ub(Object lp, int j);
@JS()
external double glp_get_obj_coef(Object lp, int j);
@JS()
external int glp_get_num_nz(Object lp);
@JS()
external int glp_get_mat_row(Object lp, int i, List<int> ind, List<double> val);
@JS()
external int glp_get_mat_col(Object lp, int j, List<int> ind, List<double> val);
// Row and column searching routines
@JS()
external void glp_create_index(Object lp);
@JS()
external int glp_find_row(Object lp, String name);
@JS()
external int glp_find_col(Object lp, String name);
@JS()
external void glp_delete_index(Object lp);
// Problem scaling routines
@JS()
external void glp_set_rii(Object lp, i, double rii);
@JS()
external void glp_set_sjj(Object lp, int j, double sjj);
@JS()
external double glp_get_rii(Object lp, int i);
@JS()
external double glp_get_sjj(Object lp, int j);
@JS()
external int glp_scale_prob(Object lp, int flags);
@JS()
external void glp_unscale_prob(Object lp);
// LP basis constructing routines
@JS()
external void glp_set_row_stat(Object lp, int i, int stat);
@JS()
external void glp_set_col_stat(Object lp, int j, int stat);
@JS()
external void glp_std_basis(Object lp);
// Simplex method routines
@JS()
external int glp_simplex(Object lp, Object? parm);
@JS()
external Object SMCP(Object options);
@JS()
external int glp_get_status(Object lp);
@JS()
external int glp_get_prim_stat(Object lp);
@JS()
external int glp_get_dual_stat(Object lp);
@JS()
external double glp_get_obj_val(Object lp);
@JS()
external int glp_get_row_stat(Object lp, int i);
@JS()
external double glp_get_row_prim(Object lp, int i);
@JS()
external double glp_get_row_dual(Object lp, int i);
@JS()
external int glp_get_col_stat(Object lp, int j);
@JS()
external double glp_get_col_prim(Object lp, int j);
@JS()
external double glp_get_col_dual(Object lp, int j);
@JS()
external int glp_get_unbnd_ray(Object lp);

// Mixed integer programming routines
@JS()
external void glp_set_col_kind(Object mip, int j, int kind);
@JS()
external int glp_get_col_kind(Object mip, int j);
@JS()
external int glp_get_num_int(Object mip);
@JS()
external int glp_get_num_bin(Object mip);
@JS()
external int glp_intopt(Object P, Object parm);
@JS()
external Object IOCP(Object options);
@JS()
external int glp_mip_status(Object mip);
@JS()
external double glp_mip_obj_val(Object mip);
@JS()
external double glp_mip_row_val(Object mip, int i);
@JS()
external double glp_mip_col_val(Object mip, int j);
// Advanced API Routings
// LP basis routines
@JS()
external int glp_bf_exists(Object lp);
@JS()
external int glp_factorize(Object lp);
@JS()
external int glp_bf_updated(Object lp);
@JS()
external void glp_get_bfcp(Object lp, Object parm);
@JS()
external void glp_set_bfcp(Object lp, Object parm);
@JS()
external int glp_get_bhead(Object lp, int k);
@JS()
external int glp_get_row_bind(Object lp, int i);
@JS()
external int glp_get_col_bind(Object lp, int j);
@JS()
external void glp_ftran(Object lp, List<int> x);
@JS()
external void glp_btran(Object lp, List<int> x);
@JS()
external int glp_warm_up(Object P);
// Simplex tableau routines
@JS()
external int glp_eval_tab_row(
    Object lp, int k, List<int> ind, List<double> val);
@JS()
external int glp_eval_tab_col(
    Object lp, int k, List<int> ind, List<double> val);
@JS()
external int glp_transform_row(Object P, len, List<int> ind, List<double> val);
@JS()
external int glp_transform_col(Object P, len, List<int> ind, List<double> val);
@JS()
external int glp_prim_rtest(
    Object P, len, List<int> ind, List<double> val, int dir, double eps);
@JS()
external int glp_dual_rtest(
    Object P, len, List<int> ind, List<double> val, int dir, double eps);
// Post optimal analysis routines
@JS()
external void glp_analyze_bound(Object P, int k,
    void Function(double value1, int var1, double value2, int var2) callback);
@JS()
external void glp_analyze_coef(
    Object P,
    int k,
    void Function(double coef1, int var1, double value1, double coef2, int var2,
            double value2)
        callback);
// Branch and cut routines
// Basic routines
@JS()
external int glp_ios_reason(Object tree);
@JS()
external Object glp_ios_get_prob(Object tree);

// Routines for processing MathProg models
@JS()
external Object glp_mpl_alloc_wksp();
@JS('_glp_mpl_init_rand')
external void glp_mpl_init_rand(Object tran, int seed);

/// [callback] should return one character at a time from the model file
@JS()
external int glp_mpl_read_model(
    Object tran, String name, String Function() callback, int skip);
@JS()
external int glp_mpl_read_model_from_string(
    Object tran, String name, String str, int skip);

/// [callback] should return one character at a time from the model file
@JS()
external int glp_mpl_read_data(
    Object tran, String name, String Function() callback);
@JS()
external int glp_mpl_read_data_from_string(
    Object tran, String name, String str);

/// [tablecb] is to open a file in a particular mode? [callback] is the output mechanism (writing)
@JS()
external int glp_mpl_generate(Object tran, String name,
    void Function(String)? callback, Function(String, String)? tablecb);

@JS()
external void glp_mpl_build_prob(Object tran, Object prob);
@JS()
external int glp_mpl_postsolve(Object tran, Object prob, int sol);
// Problem solution reading / writing routines
@JS()
external int glp_read_lp(Object P, Object parm, String Function() callback);
@JS()
external int glp_write_lp(
    Object P, Object parm, void Function(String) callback);
@JS()
external int glp_read_lp_from_string(Object P, Object parm, String str);
// TODO: Figure out what this is
@JS()
external double glp_ios_relative_gap(Object tree);

// library version numbers:
@JS()
external int get GLP_MAJOR_VERSION;
@JS()
external int get GLP_MINOR_VERSION;
// optimization direction flag:
@JS()
external int get GLP_MIN;
@JS()
external int get GLP_MAX;
// kind of structural variable:
@JS()
external int get GLP_CV;
@JS()
external int get GLP_IV;
@JS()
external int get GLP_BV;
// type of auxiliary/structural variable:
@JS()
external int get GLP_FR;
@JS()
external int get GLP_LO;
@JS()
external int get GLP_UP;
@JS()
external int get GLP_DB;
@JS()
external int get GLP_FX;
// status of auxiliary/structural variable:
@JS()
external int get GLP_BS;
@JS()
external int get GLP_NL;
@JS()
external int get GLP_NU;
@JS()
external int get GLP_NF;
@JS()
external int get GLP_NS;
// scaling options:
@JS()
external int get GLP_SF_GM;
@JS()
external int get GLP_SF_EQ;
@JS()
external int get GLP_SF_2N;
@JS()
external int get GLP_SF_SKIP;
@JS()
external int get GLP_SF_AUTO;
// solution indicator:
@JS()
external int get GLP_SOL;
@JS()
external int get GLP_IPT;
@JS()
external int get GLP_MIP;
// solution status:
@JS()
external int get GLP_UNDEF;
@JS()
external int get GLP_FEAS;
@JS()
external int get GLP_INFEAS;
@JS()
external int get GLP_NOFEAS;
@JS()
external int get GLP_OPT;
@JS()
external int get GLP_UNBND;
// basis factorization control parameters
@JS()
external int get GLP_BF_FT;
@JS()
external int get GLP_BF_BG;
@JS()
external int get GLP_BF_GR;
// simplex method control parameters
@JS()
external int get GLP_MSG_OFF;
@JS()
external int get GLP_MSG_ERR;
@JS()
external int get GLP_MSG_ON;
@JS()
external int get GLP_MSG_ALL;
@JS()
external int get GLP_MSG_DBG;
@JS()
external int get GLP_PRIMAL;
@JS()
external int get GLP_DUALP;
@JS()
external int get GLP_DUAL;
@JS()
external int get GLP_PT_STD;
@JS()
external int get GLP_PT_PSE;
@JS()
external int get GLP_RT_STD;
@JS()
external int get GLP_RT_HAR;
// interior-point solver control parameters
@JS()
external int get GLP_ORD_NONE;
@JS()
external int get GLP_ORD_QMD;
@JS()
external int get GLP_ORD_AMD;
@JS()
external int get GLP_ORD_SYMAMD;
// integer optimizer control parameters
@JS()
external int get GLP_BR_FFV;
@JS()
external int get GLP_BR_LFV;
@JS()
external int get GLP_BR_MFV;
@JS()
external int get GLP_BR_DTH;
@JS()
external int get GLP_BR_PCH;
@JS()
external int get GLP_BT_DFS;
@JS()
external int get GLP_BT_BFS;
@JS()
external int get GLP_BT_BLB;
@JS()
external int get GLP_BT_BPH;
@JS()
external int get GLP_PP_NONE;
@JS()
external int get GLP_PP_ROOT;
@JS()
external int get GLP_PP_ALL;
// additional row attributes
@JS()
external int get GLP_RF_REG;
@JS()
external int get GLP_RF_LAZY;
@JS()
external int get GLP_RF_CUT;
// row class descriptor:
@JS()
external int get GLP_RF_GMI;
@JS()
external int get GLP_RF_MIR;
@JS()
external int get GLP_RF_COV;
@JS()
external int get GLP_RF_CLQ;
// enable/disable flag:
@JS()
external int get GLP_ON;
@JS()
external int get GLP_OFF;
// reason codes:
@JS()
external int get GLP_IROWGEN;
@JS()
external int get GLP_IBINGO;
@JS()
external int get GLP_IHEUR;
@JS()
external int get GLP_ICUTGEN;
@JS()
external int get GLP_IBRANCH;
@JS()
external int get GLP_ISELECT;
@JS()
external int get GLP_IPREPRO;
// branch selection indicator:
@JS()
external int get GLP_NO_BRNCH;
@JS()
external int get GLP_DN_BRNCH;
@JS()
external int get GLP_UP_BRNCH;
// return codes:
@JS()
external int get GLP_EBADB;
@JS()
external int get GLP_ESING;
@JS()
external int get GLP_ECOND;
@JS()
external int get GLP_EBOUND;
@JS()
external int get GLP_EFAIL;
@JS()
external int get GLP_EOBJLL;
@JS()
external int get GLP_EOBJUL;
@JS()
external int get GLP_EITLIM;
@JS()
external int get GLP_ETMLIM;
@JS()
external int get GLP_ENOPFS;
@JS()
external int get GLP_ENODFS;
@JS()
external int get GLP_EROOT;
@JS()
external int get GLP_ESTOP;
@JS()
external int get GLP_EMIPGAP;
@JS()
external int get GLP_ENOFEAS;
@JS()
external int get GLP_ENOCVG;
@JS()
external int get GLP_EINSTAB;
@JS()
external int get GLP_EDATA;
@JS()
external int get GLP_ERANGE;
// condition indicator:
@JS()
external int get GLP_KKT_PE;
@JS()
external int get GLP_KKT_PB;
@JS()
external int get GLP_KKT_DE;
@JS()
external int get GLP_KKT_DB;
@JS()
external int get GLP_KKT_CS;
// MPS file format:
@JS()
external int get GLP_MPS_DECK;
@JS()
external int get GLP_MPS_FILE;
// assignment problem formulation:
@JS()
external int get GLP_ASN_MIN;
@JS()
external int get GLP_ASN_MAX;
@JS()
external int get GLP_ASN_MMP;

// problem class:
@JS()
external int get LPX_LP;
@JS()
external int get LPX_MIP;
// type of auxiliary/structural variable:
@JS()
external int get LPX_FR;
@JS()
external int get LPX_LO;
@JS()
external int get LPX_UP;
@JS()
external int get LPX_DB;
@JS()
external int get LPX_FX;
// optimization direction flag:
@JS()
external int get LPX_MIN;
@JS()
external int get LPX_MAX;
// status of primal basic solution:
@JS()
external int get LPX_P_UNDEF;
@JS()
external int get LPX_P_FEAS;
@JS()
external int get LPX_P_INFEAS;
@JS()
external int get LPX_P_NOFEAS;
// status of dual basic solution:
@JS()
external int get LPX_D_UNDEF;
@JS()
external int get LPX_D_FEAS;
@JS()
external int get LPX_D_INFEAS;
@JS()
external int get LPX_D_NOFEAS;
// status of auxiliary/structural variable:
@JS()
external int get LPX_BS;
@JS()
external int get LPX_NL;
@JS()
external int get LPX_NU;
@JS()
external int get LPX_NF;
@JS()
external int get LPX_NS;
// status of interior-point solution:
@JS()
external int get LPX_T_UNDEF;
@JS()
external int get LPX_T_OPT;
// kind of structural variable:
@JS()
external int get LPX_CV;
@JS()
external int get LPX_IV;
// status of integer solution:
@JS()
external int get LPX_I_UNDEF;
@JS()
external int get LPX_I_OPT;
@JS()
external int get LPX_I_FEAS;
@JS()
external int get LPX_I_NOFEAS;
// status codes reported by the routine lpx_get_status:
@JS()
external int get LPX_OPT;
@JS()
external int get LPX_FEAS;
@JS()
external int get LPX_INFEAS;
@JS()
external int get LPX_NOFEAS;
@JS()
external int get LPX_UNBND;
@JS()
external int get LPX_UNDEF;
// exit codes returned by solver routines:
@JS()
external int get LPX_E_OK;
@JS()
external int get LPX_E_EMPTY;
@JS()
external int get LPX_E_BADB;
@JS()
external int get LPX_E_INFEAS;
@JS()
external int get LPX_E_FAULT;
@JS()
external int get LPX_E_OBJLL;
@JS()
external int get LPX_E_OBJUL;
@JS()
external int get LPX_E_ITLIM;
@JS()
external int get LPX_E_TMLIM;
@JS()
external int get LPX_E_NOFEAS;
@JS()
external int get LPX_E_INSTAB;
@JS()
external int get LPX_E_SING;
@JS()
external int get LPX_E_NOCONV;
@JS()
external int get LPX_E_NOPFS;
@JS()
external int get LPX_E_NODFS;
@JS()
external int get LPX_E_MIPGAP;
// control parameter identifiers:
@JS()
external int get LPX_K_MSGLEV;
@JS()
external int get LPX_K_SCALE;
@JS()
external int get LPX_K_DUAL;
@JS()
external int get LPX_K_PRICE;
@JS()
external int get LPX_K_RELAX;
@JS()
external int get LPX_K_TOLBND;
@JS()
external int get LPX_K_TOLDJ;
@JS()
external int get LPX_K_TOLPIV;
@JS()
external int get LPX_K_ROUND;
@JS()
external int get LPX_K_OBJLL;
@JS()
external int get LPX_K_OBJUL;
@JS()
external int get LPX_K_ITLIM;
@JS()
external int get LPX_K_ITCNT;
@JS()
external int get LPX_K_TMLIM;
@JS()
external int get LPX_K_OUTFRQ;
@JS()
external int get LPX_K_OUTDLY;
@JS()
external int get LPX_K_BRANCH;
@JS()
external int get LPX_K_BTRACK;
@JS()
external int get LPX_K_TOLINT;
@JS()
external int get LPX_K_TOLOBJ;
@JS()
external int get LPX_K_MPSINFO;
@JS()
external int get LPX_K_MPSOBJ;
@JS()
external int get LPX_K_MPSORIG;
@JS()
external int get LPX_K_MPSWIDE;
@JS()
external int get LPX_K_MPSFREE;
@JS()
external int get LPX_K_MPSSKIP;
@JS()
external int get LPX_K_LPTORIG;
@JS()
external int get LPX_K_PRESOL;
@JS()
external int get LPX_K_BINARIZE;
@JS()
external int get LPX_K_USECUTS;
@JS()
external int get LPX_K_BFTYPE;
@JS()
external int get LPX_K_MIPGAP;
@JS()
external int get LPX_C_COVER;
@JS()
external int get LPX_C_CLIQUE;
@JS()
external int get LPX_C_GOMORY;
@JS()
external int get LPX_C_MIR;
@JS()
external int get LPX_C_ALL;

// TODO: Not documented functions (in JS but not glpk 5.0)
@JS()
external int mpl_tab_num_args(Object dca);
@JS()
external String mpl_tab_get_arg(Object dca, int k);
@JS()
external List<String> mpl_tab_get_args(Object dca, int k);
@JS()
external int mpl_tab_num_flds(Object dca);
@JS()
external String mpl_tab_get_name(Object dca, int k);
@JS()
external int mpl_tab_get_type(Object dca, int k);
@JS()
external double mpl_tab_get_num(Object dca, int k);
@JS()
external String mpl_tab_get_str(Object dca, int k);
@JS()
external void mpl_tab_set_num(Object dca, int k, double num);
@JS()
external void mpl_tab_set_str(Object dca, int k, String str);
@JS()
external Object mpl_initialize();
@JS()
external void mpl_read_model(
    Object mpl, String name, String Function() callback, int skip_data);
@JS()
external void mpl_read_data(
    Object mpl, String name, String Function() callback);
@JS()
external void mpl_generate(Object mpl, String name,
    void Function(String) callback, Function(String, String) tablecb);
@JS()
external String mpl_get_prob_name(Object mpl);
@JS()
external int mpl_get_num_rows(Object mpl);
@JS()
external int mpl_get_num_cols(Object mpl);
@JS()
external String mpl_get_row_name(Object mpl, int i);
@JS()
external int mpl_get_row_kind(Object mpl, int i);
@JS()
external int mpl_get_row_bnds(
    Object mpl, int i, void Function(double lb, double up) callback);
@JS()
external int mpl_get_mat_row(
    Object mpl, int i, List<int> ndx, List<double> val);
@JS()
external int mpl_get_row_c0(Object mpl, int i);
@JS()
external String mpl_get_col_name(Object mpl, int j);
@JS()
external int mpl_get_col_kind(Object mpl, int j);
@JS()
external int mpl_get_col_bnds(
    Object mpl, int j, void Function(double lb, double up) callback);
@JS()
external int mpl_has_solve_stmt(Object mpl);
@JS()
external void mpl_put_row_soln(
    Object mpl, int i, int stat, double prim, double dual);
@JS()
external void mpl_put_col_soln(
    Object mpl, int j, int stat, double prim, double dual);
@JS()
external int mpl_postsolve(Object mpl);
@JS()
external void mpl_tab_drv_register(String name, Object driver);
