import 'package:glpk/src/parser.dart';

import 'bindings/glpk.dart';

class LinearProblem {
  LinearProblem({
    required this.name,
    required this.optimization,
    required this.equations,
    required this.equationConstraints,
    required this.variableConstraints,
    this.maximize = true,
  });
  LinearProblem.matrix(
      {required this.name,
      required List<String> varNames,
      required List<String> equationNames,
      required List<List<double>> terms,
      required this.equationConstraints,
      required this.variableConstraints,
      this.maximize = true})
      : optimization = LinearEquation(equationNames[0], [
          for (var n = 0; n < varNames.length; n++)
            LinearTerm(terms[0][n], varNames[n])
        ]),
        equations = [
          for (var i = 1; i < equationNames.length; i++)
            LinearEquation(equationNames[i], [
              for (var n = 0; n < varNames.length; n++)
                LinearTerm(terms[i][n], varNames[n])
            ])
        ];
  factory LinearProblem.parse(String program) =>
      LinearProgramParser().parse(program).value;
  final String name;
  final List<LinearEquation> equations;
  final List<LinearConstraint> equationConstraints;
  final List<LinearConstraint> variableConstraints;
  final LinearEquation optimization;
  final bool maximize;

  late Map<String, int> varMap = {
    for (final eqn in equations) ...eqn.terms.map((t) => t.variable),
    ...optimization.terms.map((t) => t.variable),
  }.fold(<String, int>{}, (map, v) {
    map[v] = map.length + 1;
    return map;
  });
  late Map<String, int> eqnMap = {for (final eqn in equations) eqn.leftHandSide}
      .fold(<String, int>{}, (map, v) {
    map[v] = map.length + 1;
    return map;
  });

  late int numTerms =
      equations.map((e) => e.terms.length).reduce((i, j) => i + j);

  LinearProgramResult solve() {
    final lp = glpk.glp_create_prob();

    glpk.glp_set_prob_name(lp, name);
    glpk.glp_set_obj_dir(lp, maximize ? glpk.MAXIMIZE : glpk.MINIMIZE);

    final ia = List.filled(1 + numTerms, 0);
    final ja = List.filled(1 + numTerms, 0);
    final ar = List.filled(1 + numTerms, 0.0);

    glpk.glp_add_rows(lp, equationConstraints.length);
    for (var row = 0; row < equationConstraints.length; row++) {
      final r = equationConstraints[row];
      glpk.glp_set_row_name(lp, eqnMap[r.variable]!, r.variable);
      glpk.glp_set_row_bnds(
          lp, eqnMap[r.variable]!, r.boundType, r.lowerBound, r.upperBound);
    }

    glpk.glp_add_cols(lp, variableConstraints.length);
    for (var col = 0; col < variableConstraints.length; col++) {
      final c = variableConstraints[col];
      glpk.glp_set_col_name(lp, varMap[c.variable]!, c.variable);
      glpk.glp_set_col_bnds(
          lp, varMap[c.variable]!, c.boundType, c.lowerBound, c.upperBound);
      final terms = optimization.terms.where((t) => t.variable == c.variable);
      glpk.glp_set_obj_coef(lp, varMap[c.variable]!,
          terms.isNotEmpty ? terms.first.multiplier : 0);
    }
    var entryNum = 0;
    for (var i = 0; i < equations.length; i++) {
      final eqn = equations[i];
      for (var j = 0; j < eqn.terms.length; j++) {
        entryNum++;
        final term = eqn.terms[j];
        final eqnNum = eqnMap[eqn.leftHandSide]!;
        final varNum = varMap[term.variable]!;

        ia[entryNum] = eqnNum;
        ja[entryNum] = varNum;
        ar[entryNum] = term.multiplier;
      }
    }

    glpk.glp_load_matrix(lp, numTerms, ia, ja, ar);
    glpk.glp_simplex(lp);
    final result = LinearProgramResult(
      glpk.glp_get_obj_val(lp),
      [
        for (final v in varMap.keys)
          ResultTerm(v, glpk.glp_get_col_prim(lp, varMap[v]!))
      ],
    );

    glpk.glp_delete_prob(lp);
    glpk.cleanup();
    return result;
  }

  @override
  String toString() {
    return '''LinearProblem:
  Objective: $optimization
  
  subject to: 
    ${equations.map((t) => t.toString() + '\n    ').join('')}

  bounded by:
    ${equationConstraints.map((t) => t.toString() + '\n    ').join('')}
    ${variableConstraints.map((t) => t.toString() + '\n    ').join('')}
''';
  }
}

class LinearProgramResult {
  LinearProgramResult(this.objectiveValue, this.terms);
  final double objectiveValue;
  final List<ResultTerm> terms;
  late Map<String, double> termMap = {
    for (final term in terms) term.variable: term.value
  };
  @override
  String toString() {
    return '''Result:
  Objective: $objectiveValue
    ${terms.map((t) => t.toString() + '\n    ').join('')}
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
    return '$leftHandSide = ${terms.map((t) => t.toString()).join(' + ')}';
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
    return '$multiplier*$variable';
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
          ? glpk.FREE
          : lowerBound.isInfinite && lowerBound.isNegative
              ? glpk.UPPER_BOUNDED
              : upperBound.isInfinite
                  ? glpk.LOWER_BOUNDED
                  : upperBound == lowerBound
                      ? glpk.FIXED
                      : glpk.DOUBLE_BOUNDED;
  @override
  String toString() {
    return '$lowerBound < $variable < $upperBound ${boundType.boundString}';
  }
}

extension on int {
  String get boundString {
    if (this == glpk.FREE) {
      return 'Free Variable';
    }
    if (this == glpk.UPPER_BOUNDED) {
      return 'Upper Bounded';
    }
    if (this == glpk.LOWER_BOUNDED) {
      return 'Lower Bounded';
    }
    if (this == glpk.FIXED) {
      return 'Fixed Variable';
    }
    if (this == glpk.DOUBLE_BOUNDED) {
      return 'Double Bounded';
    }
    return 'Unknown Bound Constraint';
  }
}
