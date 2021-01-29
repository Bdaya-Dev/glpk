import 'package:glpk/glpk.dart';

void main(List<String> arguments) {
  glpk.disableOutput();
  final lp = glpk.glp_create_prob();

  glpk.glp_set_prob_name(lp, 'example');
  glpk.glp_set_obj_dir(lp, glpk.MAXIMIZE);
  final ia = List.filled(1 + 1000, 0);
  final ja = List.filled(1 + 1000, 0);
  final ar = List.filled(1 + 1000, 0.0);
  double z;
  double x1;
  double x2;
  double x3;
  glpk.glp_add_rows(lp, 3);
  glpk.glp_set_row_name(lp, 1, 'p');
  glpk.glp_set_row_bnds(lp, 1, glpk.UPPER_BOUNDED, 0.0, 100.0);
  glpk.glp_set_row_name(lp, 2, 'q');
  glpk.glp_set_row_bnds(lp, 2, glpk.UPPER_BOUNDED, 0.0, 600.0);
  glpk.glp_set_row_name(lp, 3, 'r');
  glpk.glp_set_row_bnds(lp, 3, glpk.UPPER_BOUNDED, 0.0, 300.0);
  glpk.glp_add_cols(lp, 3);
  glpk.glp_set_col_name(lp, 1, 'x1');
  glpk.glp_set_col_bnds(lp, 1, glpk.LOWER_BOUNDED, 0.0, 0.0);
  glpk.glp_set_obj_coef(lp, 1, 10.0);
  glpk.glp_set_col_name(lp, 2, 'x2');
  glpk.glp_set_col_bnds(lp, 2, glpk.LOWER_BOUNDED, 0.0, 0.0);
  glpk.glp_set_obj_coef(lp, 2, 6.0);
  glpk.glp_set_col_name(lp, 3, 'x3');
  glpk.glp_set_col_bnds(lp, 3, glpk.LOWER_BOUNDED, 0.0, 0.0);
  glpk.glp_set_obj_coef(lp, 3, 4.0);
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
  glpk.glp_load_matrix(lp, 9, ia, ja, ar);
  glpk.glp_simplex(lp);
  z = glpk.glp_get_obj_val(lp);
  x1 = glpk.glp_get_col_prim(lp, 1);
  x2 = glpk.glp_get_col_prim(lp, 2);
  x3 = glpk.glp_get_col_prim(lp, 3);
  print('\nz = $z; x1 = $x1; x2 = $x2, x3 = $x3');
  glpk.glp_delete_prob(lp);
}
