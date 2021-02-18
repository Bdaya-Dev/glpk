import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'ffi.dart';
import 'glpk.dart';

export 'package:ffi/ffi.dart';

GLPK getGLPK() => GLPKC();

class GLPKC extends GLPK {
  final glpk = GLPK_C(glpkLibraryLocationOverride != null
      ? DynamicLibrary.open(glpkLibraryLocationOverride!)
      : Platform.isLinux
          ? DynamicLibrary.open('/usr/local/lib/libglpk.so')
          : DynamicLibrary.open('/usr/local/lib/libglpk.dylib'));
  final Map<String, Pointer<Utf8>> _strings = {};
  final List<Pointer> _arrayList = [];

  @pragma('vm:prefer-inline')
  Pointer<Int8> registerString(String str) {
    if (cleanupHappening) {
      throw Exception('Cannot use glpk concurrently');
    }
    if (_strings[str] == null) {
      _strings[str] = str.toNativeUtf8();
    }
    return _strings[str]!.cast();
  }

  @pragma('vm:prefer-inline')
  Pointer<Int32> registerInt32List(List<int> list) {
    if (cleanupHappening) {
      throw Exception('Cannot use glpk concurrently');
    }
    final l = malloc.allocate<Int32>(sizeOf<Int32>() * list.length);
    l.asTypedList(list.length).setAll(0, list);
    _arrayList.add(l);
    return l;
  }

  @pragma('vm:prefer-inline')
  Pointer<Double> registerDoubleList(List<double> list) {
    if (cleanupHappening) {
      throw Exception('Cannot use glpk concurrently');
    }
    final l = malloc.allocate<Double>(sizeOf<Double>() * list.length);
    l.asTypedList(list.length).setAll(0, list);
    _arrayList.add(l);
    return l;
  }

  bool cleanupHappening = false;

  @override
  void cleanup() {
    cleanupHappening = true;
    final keys = [..._strings.keys];
    for (final str in keys) {
      malloc.free(_strings[str]!.cast<Utf8>());
    }
    _strings.clear();
    for (final p in [..._arrayList]) {
      malloc.free(p);
    }
    _arrayList.clear();
    cleanupHappening = false;
  }

  @override
  @pragma('vm:prefer-inline')
  int get DOUBLE_BOUNDED => GLP_DB;

  @override
  @pragma('vm:prefer-inline')
  int get FREE => GLP_FR;

  @override
  @pragma('vm:prefer-inline')
  int get FIXED => GLP_FX;

  @override
  @pragma('vm:prefer-inline')
  int get LOWER_BOUNDED => GLP_LO;

  @override
  @pragma('vm:prefer-inline')
  int get MAXIMIZE => GLP_MAX;

  @override
  @pragma('vm:prefer-inline')
  int get MINIMIZE => GLP_MIN;

  @override
  @pragma('vm:prefer-inline')
  int get UPPER_BOUNDED => GLP_UP;

  @override
  @pragma('vm:prefer-inline')
  void glp_add_cols(Object lp, int length) =>
      glpk.glp_add_cols(lp.pProb, length);

  @override
  @pragma('vm:prefer-inline')
  Object glp_create_prob() => glpk.glp_create_prob();

  @override
  @pragma('vm:prefer-inline')
  void glp_delete_prob(Object lp) => glpk.glp_delete_prob(lp.pProb);

  @override
  @pragma('vm:prefer-inline')
  double glp_get_col_prim(Object lp, int i) =>
      glpk.glp_get_col_prim(lp.pProb, i);

  @override
  @pragma('vm:prefer-inline')
  double glp_get_obj_val(Object lp) => glpk.glp_get_obj_val(lp.pProb);

  @override
  @pragma('vm:prefer-inline')
  void glp_load_matrix(
      Object lp, int numTerms, List<int> ia, List<int> ja, List<double> ar) {
    glpk.glp_load_matrix(lp.pProb, numTerms, registerInt32List(ia),
        registerInt32List(ja), registerDoubleList(ar));
  }

  @override
  @pragma('vm:prefer-inline')
  void glp_set_col_bnds(Object lp, int i, int boundType, double lowerBound,
          double upperBound) =>
      glpk.glp_set_col_bnds(lp.pProb, i, boundType, lowerBound, upperBound);
  @override
  @pragma('vm:prefer-inline')
  void glp_set_col_name(Object lp, int i, String name) =>
      glpk.glp_set_col_name(lp.pProb, i, registerString(name));

  @override
  @pragma('vm:prefer-inline')
  void glp_set_obj_coef(Object lp, int i, double v) =>
      glpk.glp_set_obj_coef(lp.pProb, i, v);
  @override
  @pragma('vm:prefer-inline')
  void glp_set_obj_dir(Object lp, int dir) =>
      glpk.glp_set_obj_dir(lp.pProb, dir);

  @override
  @pragma('vm:prefer-inline')
  void glp_set_prob_name(Object lp, String name) =>
      glpk.glp_set_prob_name(lp.pProb, registerString(name));

  @override
  @pragma('vm:prefer-inline')
  void glp_simplex(Object lp) => glpk.glp_simplex(lp.pProb, nullptr);

  @override
  @pragma('vm:prefer-inline')
  void glp_add_rows(Object lp, int length) =>
      glpk.glp_add_rows(lp.pProb, length);

  @override
  @pragma('vm:prefer-inline')
  void glp_set_row_bnds(Object lp, int i, int boundType, double lowerBound,
          double upperBound) =>
      glpk.glp_set_row_bnds(lp.pProb, i, boundType, lowerBound, upperBound);

  @override
  @pragma('vm:prefer-inline')
  void glp_set_row_name(Object lp, int i, String name) =>
      glpk.glp_set_row_name(lp.pProb, i, registerString(name));

  @override
  @pragma('vm:prefer-inline')
  void disableOutput() => glpk.glp_term_out(GLP_OFF);
}

extension on Object {
  @pragma('vm:prefer-inline')
  Pointer<glp_prob> get pProb => this as Pointer<glp_prob>;
}
