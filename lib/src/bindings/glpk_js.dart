import 'package:glpk/src/bindings/glpk.dart';
import 'package:js/js.dart';
import 'js.dart' as js;

GLPK getGLPK() => GLPKJS();

class GLPKJS extends GLPK {
  @override
  int get DOUBLE_BOUNDED => js.GLP_DB;

  @override
  int get FREE => js.GLP_FR;

  @override
  int get FIXED => js.GLP_FX;

  @override
  int get LOWER_BOUNDED => js.GLP_LO;

  @override
  int get MAXIMIZE => js.GLP_MAX;

  @override
  int get UPPER_BOUNDED => js.GLP_UP;

  @override
  void cleanup() {}

  @override
  void glp_add_cols(Object lp, int length) => js.glp_add_cols(lp, length);

  @override
  Object glp_create_prob() => js.glp_create_prob();

  @override
  void glp_delete_prob(Object lp) {} // No delete in javascript

  @override
  double glp_get_col_prim(Object lp, int i) => js.glp_get_col_prim(lp, i);

  @override
  double glp_get_obj_val(Object lp) => js.glp_get_obj_val(lp);

  @override
  void glp_load_matrix(Object lp, int numTerms, List<int> ia, List<int> ja,
          List<double> ar) =>
      js.glp_load_matrix(lp, numTerms, ia, ja, ar);

  @override
  void glp_set_col_bnds(Object lp, int i, int boundType, double lowerBound,
          double upperBound) =>
      js.glp_set_col_bnds(lp, i, boundType, lowerBound, upperBound);

  @override
  void glp_set_col_name(Object lp, int i, String name) =>
      js.glp_set_col_name(lp, i, name);

  @override
  void glp_set_obj_coef(Object lp, int i, double v) =>
      js.glp_set_obj_coef(lp, i, v);

  @override
  void glp_set_obj_dir(Object lp, int direction) =>
      js.glp_set_obj_dir(lp, direction);

  @override
  void glp_set_prob_name(Object lp, String name) =>
      js.glp_set_prob_name(lp, name);

  @override
  void glp_simplex(Object lp) => js.glp_simplex(lp, null);
  @override
  void glp_add_rows(Object lp, int length) => js.glp_add_rows(lp, length);

  @override
  void glp_set_row_bnds(Object lp, int i, int boundType, double lowerBound,
          double upperBound) =>
      js.glp_set_row_bnds(lp, i, boundType, lowerBound, upperBound);

  @override
  void glp_set_row_name(Object lp, int i, String name) =>
      js.glp_set_row_name(lp, i, name);

  @override
  void disableOutput() => js.glp_set_print_func(allowInterop((s) {}));
}
