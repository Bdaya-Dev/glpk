@JS()
library glpk;

import 'package:js/js.dart';
// To update search for exports in glpk.js

@JS()
external void Function(Object) glp_get_print_func();
@JS()
external void glp_set_print_func(void Function(Object) value);
@JS()
external String glp_version();
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
@JS()
external void glp_create_index(Object lp);
@JS()
external int glp_find_row(Object lp, String name);
@JS()
external int glp_find_col(Object lp, String name);
@JS()
external void glp_delete_index(Object lp);
@JS()
external void glp_set_rii(Object lp, i, double rii);
@JS()
external void glp_set_sjj(Object lp, int j, double sjj);
@JS()
external double glp_get_rii(Object lp, int i);
@JS()
external double glp_get_sjj(Object lp, int j);
@JS()
external void glp_unscale_prob(Object lp);
@JS()
external void glp_set_row_stat(Object lp, int i, int stat);
@JS()
external void glp_set_col_stat(Object lp, int j, int stat);
@JS()
external void glp_std_basis(Object lp);
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
external int get GLP_MAX;
@JS()
external int get GLP_MIN;
@JS()
external int get GLP_OFF;
@JS()
external int get GLP_DB;
@JS()
external int get GLP_FR;
@JS()
external int get GLP_FX;
@JS()
external int get GLP_LO;
@JS()
external int get GLP_UP;

@JS()
external void glp_term_out(int setting);
