import 'package:glpk/glpk.dart';

void main() {
  final problem = LinearProblem(
    name: 'example',
    optimization: LinearEquation(
        'z', [LinearTerm(10, 'x1'), LinearTerm(6, 'x2'), LinearTerm(4, 'x3')]),
    equations: [
      LinearEquation(
          'p', [LinearTerm(1, 'x1'), LinearTerm(1, 'x2'), LinearTerm(1, 'x3')]),
      LinearEquation('q',
          [LinearTerm(10, 'x1'), LinearTerm(4, 'x2'), LinearTerm(5, 'x3')]),
      LinearEquation(
          'r', [LinearTerm(2, 'x1'), LinearTerm(2, 'x2'), LinearTerm(6, 'x3')])
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
