import 'package:glpk/glpk.dart';

void main() {
  /// [3, .5]
  /// [0, 1]
  /// i is row j is column
  /// max v
// subject to
// (v − Sum from i = 1 to m of (aij*xi)) ≤ 0 for all j = 1, . . . , n (3)
// Sum from i = 1 to m of (xi) = 1
// x1, . . . , xm ≥ 0 and v ∈ R.
  final problem = LinearProblem.parse('''example

z = v

p = v - 3*x1
q = v - .5*x1 - 1*x2
r = x1 + x2

-inf < p < 0
-inf < q < 0
1 < r < 1

-inf < v < inf
0 < x1 < inf
0 < x2 < inf
''');
  print(problem);
  final solution = problem.solve();
  print(solution);
  assert(solution.objectiveValue.isCloseTo(6 / 7));
  assert(solution.termMap['x1']!.isCloseTo(2 / 7));
  assert(solution.termMap['x2']!.isCloseTo(5 / 7));

  final problem2 = LinearProblem.parse('''example

z = v

p = v - 5*x1 - 3*x2
q = v - 1*x2
r = x1 + x2

-inf < p < 0
-inf < q < 0
1 < r < 1

-inf < v < inf
0 < x1 < inf
0 < x2 < inf
''');
  print(problem2);
  final solution2 = problem2.solve();
  print(solution2);
  assert(solution2.objectiveValue.isCloseTo(1));
  assert(solution2.termMap['x1']!.isCloseTo(0));
  assert(solution2.termMap['x2']!.isCloseTo(1));

  final tictactoe = LinearProblem.parse('''example

z = v

p = v - .5*x1 - 1*x2 - 1*x3
q = v - 1*x1 - .5*x2 - 1*x3
r = v - 1*x1 - 1*x2 - .5*x3
s = x1 + x2 + x3

-inf < p < 0
-inf < q < 0
-inf < r < 0
1 < s < 1

-inf < v < inf
0 < x1 < inf
0 < x2 < inf
0 < x3 < inf
''');
  print(tictactoe);
  final tictactoeSolution = tictactoe.solve();
  print(tictactoeSolution);
  assert(tictactoeSolution.objectiveValue.isCloseTo(1));
  assert(tictactoeSolution.termMap['x1']!.isCloseTo(1 / 3));
  assert(tictactoeSolution.termMap['x2']!.isCloseTo(1 / 3));
  assert(tictactoeSolution.termMap['x3']!.isCloseTo(1 / 3));
}

extension on double {
  bool isCloseTo(double other) {
    return this - other < .000001;
  }
}
