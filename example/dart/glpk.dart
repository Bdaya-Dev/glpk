import 'dart:ffi';

import 'package:glpk/glpk.dart';

extension on String {
  Pointer<Utf8> get utf8 => Utf8.toUtf8(this);
}

void main(List<String> arguments) {
  final lp = GLPK.glp_create_prob();

  GLPK.glp_set_prob_name(lp, 'example'.utf8.cast());
  GLPK.glp_set_obj_dir(lp, GLP_MAX);
  final ia = allocate<Int32>(count: 1 + 1000);
  final ja = allocate<Int32>(count: 1 + 1000);
  final ar = allocate<Double>(count: 1 + 1000);
  double z;
  double x1;
  double x2;
  double x3;
  GLPK.glp_add_rows(lp, 3);

  GLPK.glp_set_row_name(lp, 1, 'p'.utf8.cast());
  GLPK.glp_set_row_bnds(lp, 1, GLP_UP, 0.0, 100.0);
  GLPK.glp_set_row_name(lp, 2, 'q'.utf8.cast());
  GLPK.glp_set_row_bnds(lp, 2, GLP_UP, 0.0, 600.0);
  GLPK.glp_set_row_name(lp, 3, 'r'.utf8.cast());
  GLPK.glp_set_row_bnds(lp, 3, GLP_UP, 0.0, 300.0);
  GLPK.glp_add_cols(lp, 3);
  GLPK.glp_set_col_name(lp, 1, 'x1'.utf8.cast());
  GLPK.glp_set_col_bnds(lp, 1, GLP_LO, 0.0, 0.0);
  GLPK.glp_set_obj_coef(lp, 1, 10.0);
  GLPK.glp_set_col_name(lp, 2, 'x2'.utf8.cast());
  GLPK.glp_set_col_bnds(lp, 2, GLP_LO, 0.0, 0.0);
  GLPK.glp_set_obj_coef(lp, 2, 6.0);
  GLPK.glp_set_col_name(lp, 3, 'x3'.utf8.cast());
  GLPK.glp_set_col_bnds(lp, 3, GLP_LO, 0.0, 0.0);
  GLPK.glp_set_obj_coef(lp, 3, 4.0);
  ia[1] = 1;
  ja[1] = 1;
  ar[1] = 1.0; // a[1,1]
  ia[2] = 1;
  ja[2] = 2;
  ar[2] = 1.0; // a[1,2]
  ia[3] = 1;
  ja[3] = 3;
  ar[3] = 1.0; // a[1,3]
  ia[4] = 2;
  ja[4] = 1;
  ar[4] = 10.0; // a[2,1]
  ia[5] = 3;
  ja[5] = 1;
  ar[5] = 2.0; // a[3,1]
  ia[6] = 2;
  ja[6] = 2;
  ar[6] = 4.0; // a[2,2]

  ia[7] = 3;
  ja[7] = 2;
  ar[7] = 2.0;
  ia[8] = 2;
  ja[8] = 3;
  ar[8] = 5.0;
  ia[9] = 3;
  ja[9] = 3;
  ar[9] = 6.0;
  GLPK.glp_load_matrix(lp, 9, ia, ja, ar);
  GLPK.glp_simplex(lp, nullptr);
  z = GLPK.glp_get_obj_val(lp);
  x1 = GLPK.glp_get_col_prim(lp, 1);
  x2 = GLPK.glp_get_col_prim(lp, 2);
  x3 = GLPK.glp_get_col_prim(lp, 3);
  print('\nz = $z; x1 = $x1; x2 = $x2, x3 = $x3');
  GLPK.glp_delete_prob(lp);
}
