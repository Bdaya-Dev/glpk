import 'package:glpk/glpk.dart';

void main() {
  final problem = LinearProblem.matrix(
    name: 'example',
    varNames: ['x1', 'x2', 'x3'],
    equationNames: ['z', 'p', 'q', 'r'],
    terms: [
      [10, 6, 4],
      [1, 1, 1],
      [10, 4, 5],
      [2, 2, 6]
    ],
    equationConstraints: [
      LinearConstraint(double.negativeInfinity, 'p', 100),
      LinearConstraint(double.negativeInfinity, 'q', 600),
      LinearConstraint(double.negativeInfinity, 'r', 300)
    ],
    variableConstraints: [
      LinearConstraint(0, 'x1', double.infinity),
      LinearConstraint(0, 'x2', double.infinity),
      LinearConstraint(0, 'x3', double.infinity)
    ],
  );
  print(problem);
  final solution = problem.solve();
  print(solution);
}
