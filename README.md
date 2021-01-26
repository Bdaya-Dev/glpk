An Integer Programming Library using C bindings to the glpk library

Download and Install the GLPK library from here:
https://www.gnu.org/software/glpk/glpk.html#downloading

Example Problem:
```dart
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

```

Or using the matrix format:
```dart
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
```


---

Or a parser based approach:
```dart
void main() {
  final problem = LinearProblem.parse('''example

z = 10x1 - 6x2 + 4x3

p = 1x1 + 1x2 + 1x3
q = 10x1 + 4x2 + 5x3
r = 2x1 + 2x2 + 6x3

-inf < p < 100
-inf < q < 600
-inf < r < 300

0 < x1 < inf
0 < x2 < inf
0 < x3 < inf
''');
  print(problem);
  final solution = problem.solve();
  print(solution);
}

```