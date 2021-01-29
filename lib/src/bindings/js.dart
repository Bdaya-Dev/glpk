@JS()
library glpk;

import 'package:js/js.dart';

@JS('GLP_MAX')
external int get GLP_MAX;
@JS('GLP_OFF')
external int get GLP_OFF;
@JS('GLP_DB')
external int get GLP_DB;
@JS('GLP_FR')
external int get GLP_FR;
@JS('GLP_FX')
external int get GLP_FX;
@JS('GLP_LO')
external int get GLP_LO;
@JS('GLP_UP')
external int get GLP_UP;

@JS('glp_add_cols')
external void glp_add_cols(Object lp, int length);
@JS('glp_create_prob')
external Object glp_create_prob();

@JS('glp_get_col_prim')
external double glp_get_col_prim(Object lp, int i);
@JS('glp_get_obj_val')
external double glp_get_obj_val(Object lp);
@JS('glp_load_matrix')
external void glp_load_matrix(
    Object lp, int numTerms, List<int> ia, List<int> ja, List<double> ar);
@JS('glp_set_col_bnds')
external void glp_set_col_bnds(
    Object lp, int i, int boundType, double lowerBound, double upperBound);
@JS('glp_set_col_name')
external void glp_set_col_name(Object lp, int i, String name);
@JS('glp_set_obj_coef')
external void glp_set_obj_coef(Object lp, int i, double v);
@JS('glp_set_obj_dir')
external void glp_set_obj_dir(Object lp, int direction);
@JS('glp_set_prob_name')
external void glp_set_prob_name(Object lp, String name);
@JS('glp_simplex')
external void glp_simplex(Object lp);
@JS('glp_add_rows')
external void glp_add_rows(Object lp, int length);
@JS('glp_set_row_bnds')
external void glp_set_row_bnds(
    Object lp, int i, int boundType, double lowerBound, double upperBound);
@JS('glp_set_row_name')
external void glp_set_row_name(Object lp, int i, String variable);
@JS('glp_term_out')
external void glp_term_out(int setting);
