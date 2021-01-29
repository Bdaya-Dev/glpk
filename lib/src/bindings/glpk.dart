import 'glpk_stub.dart'
    if (dart.library.io) 'glpk_c.dart'
    if (dart.library.js) 'glpk_js.dart';

abstract class GLPK {
  static final GLPK instance = getGLPK();

  int get MAXIMIZE;
  int get DOUBLE_BOUNDED;
  int get FIXED;
  int get LOWER_BOUNDED;
  int get UPPER_BOUNDED;
  int get FREE;

  void disableOutput();
  Object glp_create_prob();
  void cleanup();
  void glp_delete_prob(Object lp);
  double glp_get_col_prim(Object lp, int i);
  double glp_get_obj_val(Object lp);
  void glp_simplex(Object lp);
  void glp_load_matrix(
      Object lp, int numTerms, List<int> ia, List<int> ja, List<double> ar);
  void glp_set_obj_coef(Object lp, int i, double v);
  void glp_set_col_bnds(
      Object lp, int i, int boundType, double lowerBound, double upperBound);
  void glp_set_col_name(Object lp, int i, String name);
  void glp_add_cols(Object lp, int length);
  void glp_set_obj_dir(Object lp, int direction);
  void glp_set_prob_name(Object lp, String name);
  void glp_set_row_bnds(
      Object lp, int i, int boundType, double lowerBound, double upperBound);
  void glp_set_row_name(Object lp, int i, String name);
  void glp_add_rows(Object lp, int length);
}

final glpk = GLPK.instance;
