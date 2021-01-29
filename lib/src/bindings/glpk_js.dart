@JS()
library glpk;

import 'package:glpk/src/bindings/glpk.dart';
import 'package:js/js.dart';

GLPK getGLPK() => GLPKJS();

class GLPKJS extends GLPK {
  @override
  // TODO: implement GLP_DB
  int get DOUBLE_BOUNDED => throw UnimplementedError();

  @override
  // TODO: implement GLP_FR
  int get FREE => throw UnimplementedError();

  @override
  // TODO: implement GLP_FX
  int get FIXED => throw UnimplementedError();

  @override
  // TODO: implement GLP_LO
  int get LOWER_BOUNDED => throw UnimplementedError();

  @override
  // TODO: implement GLP_MAX
  int get MAXIMIZE => throw UnimplementedError();

  @override
  // TODO: implement GLP_UP
  int get UPPER_BOUNDED => throw UnimplementedError();

  @override
  void cleanup() {
    // TODO: implement cleanup
  }

  @override
  void glp_add_cols(Object lp, int length) {
    // TODO: implement glp_add_cols
  }

  @override
  Object glp_create_prob() {
    // TODO: implement glp_create_prob
    throw UnimplementedError();
  }

  @override
  void glp_delete_prob(Object lp) {
    // TODO: implement glp_delete_prob
  }

  @override
  double glp_get_col_prim(Object lp, int i) {
    // TODO: implement glp_get_col_prim
    throw UnimplementedError();
  }

  @override
  double glp_get_obj_val(Object lp) {
    // TODO: implement glp_get_obj_val
    throw UnimplementedError();
  }

  @override
  void glp_load_matrix(
      Object lp, int numTerms, List<int> ia, List<int> ja, List<double> ar) {
    // TODO: implement glp_load_matrix
  }

  @override
  void glp_set_col_bnds(
      Object lp, int i, int boundType, double lowerBound, double upperBound) {
    // TODO: implement glp_set_col_bnds
  }

  @override
  void glp_set_col_name(Object lp, int i, String name) {
    // TODO: implement glp_set_col_name
  }

  @override
  void glp_set_obj_coef(Object lp, int i, double v) {
    // TODO: implement glp_set_obj_coef
  }

  @override
  void glp_set_obj_dir(Object lp, int direction) {
    // TODO: implement glp_set_obj_dir
  }

  @override
  void glp_set_prob_name(Object lp, String name) {
    // TODO: implement glp_set_prob_name
  }

  @override
  void glp_simplex(Object lp) {
    // TODO: implement glp_simplex
  }

  @override
  void glp_add_rows(Object lp, int length) {
    // TODO: implement glp_add_rows
  }

  @override
  void glp_set_row_bnds(
      Object lp, int i, int boundType, double lowerBound, double upperBound) {
    // TODO: implement glp_set_row_bnds
  }

  @override
  void glp_set_row_name(Object lp, int i, String variable) {
    // TODO: implement glp_set_row_name
  }

  @override
  void disableOutput() {
    // TODO: implement disableOutput
  }
}
