import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'bindings/ffi.dart';
export 'bindings/ffi.dart';
export 'package:ffi/ffi.dart';

final GLPK = GLPK_C(Platform.isLinux
    ? DynamicLibrary.open('/usr/local/lib/libglpk.so')
    : DynamicLibrary.open('/usr/local/lib/libglpk.dylib'));

class LinearProblem {
  LinearProblem({
    required this.name,
    required this.optimization,
    required this.equations,
    required this.equationConstraints,
    required this.variableConstraints,
  });
  LinearProblem.matrix(
      {required this.name,
      required List<String> varNames,
      required List<String> equationNames,
      required List<List<double>> terms,
      required this.equationConstraints,
      required this.variableConstraints})
      : optimization = LinearEquation(name, [
          for (var n = 0; n < varNames.length; n++)
            LinearTerm(terms[0][n], varNames[n])
        ]),
        equations = [
          for (var i = 1; i < equationNames.length; i++)
            LinearEquation(name, [
              for (var n = 0; n < varNames.length; n++)
                LinearTerm(terms[i][n], varNames[n])
            ])
        ];
  final String name;
  final List<LinearEquation> equations;
  final List<LinearConstraint> equationConstraints;
  final List<LinearConstraint> variableConstraints;
  final LinearEquation optimization;

  Map<String, Pointer<Utf8>> strings = {};

  Pointer<Int8> registerString(String str) {
    if (strings[str] == null) {
      strings[str] = Utf8.toUtf8(str);
    }
    return strings[str]!.cast();
  }

  void cleanup() {
    final keys = [...strings.keys];
    for (final str in keys) {
      free(strings[str]!.cast<Utf8>());
      strings.remove(str);
    }
  }

  late int numTerms =
      equations.map((e) => e.terms.length).reduce((i, j) => i + j);

  LinearProgramResult solve() {
    final lp = GLPK.glp_create_prob();

    GLPK.glp_set_prob_name(lp, registerString(name));
    GLPK.glp_set_obj_dir(lp, GLP_MAX);

    final ia = allocate<Int32>(count: 1 + numTerms);
    final ja = allocate<Int32>(count: 1 + numTerms);
    final ar = allocate<Double>(count: 1 + numTerms);

    GLPK.glp_add_rows(lp, equationConstraints.length);
    for (var row = 0; row < equationConstraints.length; row++) {
      final r = equationConstraints[row];
      GLPK.glp_set_row_name(lp, row + 1, registerString(r.variable));
      GLPK.glp_set_row_bnds(
          lp, row + 1, r.boundType, r.lowerBound, r.upperBound);
    }

    GLPK.glp_add_cols(lp, variableConstraints.length);
    for (var col = 0; col < variableConstraints.length; col++) {
      final c = variableConstraints[col];
      GLPK.glp_set_col_name(lp, col + 1, registerString(c.variable));
      GLPK.glp_set_col_bnds(
          lp, col + 1, c.boundType, c.lowerBound, c.upperBound);
      GLPK.glp_set_obj_coef(
          lp,
          col + 1,
          optimization.terms
              .firstWhere((t) => t.variable == c.variable)
              .multiplier);
    }
    var entryNum = 0;
    for (var i = 0; i < equations.length; i++) {
      for (var j = 0; j < equations[i].terms.length; j++) {
        entryNum++;
        ia[entryNum] = i + 1;
        ja[entryNum] = j + 1;
        ar[entryNum] = equations[i].terms[j].multiplier;
      }
    }

    GLPK.glp_load_matrix(lp, numTerms, ia, ja, ar);
    GLPK.glp_simplex(lp, nullptr);
    final result = LinearProgramResult(
      GLPK.glp_get_obj_val(lp),
      [
        for (var col = 0; col < variableConstraints.length; col++)
          ResultTerm(variableConstraints[col].variable,
              GLPK.glp_get_col_prim(lp, col + 1))
      ],
    );

    GLPK.glp_delete_prob(lp);
    cleanup();
    return result;
  }

  @override
  String toString() {
    return '''LinearProblem:
  Objective: $optimization
  
  subject to: 
\t${equations.map((t) => t.toString() + '\n\t').join('')}

  bounded by:
\t${equationConstraints.map((t) => t.toString() + '\n\t').join('')}
\t${variableConstraints.map((t) => t.toString() + '\n\t').join('')}
''';
  }
}

class LinearProgramResult {
  LinearProgramResult(this.objectiveValue, this.terms);
  final double objectiveValue;
  final List<ResultTerm> terms;
  @override
  String toString() {
    return '''Result:
  Objective: $objectiveValue
\t${terms.map((t) => t.toString() + '\n\t').join('')}
''';
  }
}

class ResultTerm {
  ResultTerm(this.variable, this.value);
  final String variable;
  final double value;
  @override
  String toString() {
    return '$variable = $value';
  }
}

class LinearEquation {
  LinearEquation(this.leftHandSide, this.terms);
  final String leftHandSide;
  final List<LinearTerm> terms;
  @override
  String toString() {
    return '$leftHandSide = ${terms.map((t) => t.toString().padLeft(6)).join('')}';
  }
}

class LinearTerm {
  LinearTerm(
    this.multiplier,
    this.variable,
  );
  final String variable;
  final double multiplier;
  @override
  String toString() {
    return '$multiplier$variable';
  }
}

class LinearConstraint {
  LinearConstraint(this.lowerBound, this.variable, this.upperBound);
  final double lowerBound;
  final String variable;
  final double upperBound;

  late int boundType = lowerBound.isNaN ||
          upperBound.isNaN ||
          lowerBound > upperBound
      ? throw Exception('Invalid Constraint $this')
      : lowerBound.isInfinite && lowerBound.isNegative && upperBound.isInfinite
          ? GLP_FR
          : lowerBound.isInfinite && lowerBound.isNegative
              ? GLP_UP
              : upperBound.isInfinite
                  ? GLP_LO
                  : upperBound == lowerBound
                      ? GLP_FX
                      : GLP_DB;
  @override
  String toString() {
    return '$lowerBound $variable $upperBound ${boundType.boundString}';
  }
}

extension on int {
  String get boundString {
    switch (this) {
      case GLP_FR:
        return 'Free Variable';
      case GLP_UP:
        return 'Upper Bounded';
      case GLP_LO:
        return 'Lower Bounded';
      case GLP_FX:
        return 'Fixed Variable';
      case GLP_DB:
        return 'Double Bounded';
    }
    return 'No Bound';
  }
}
