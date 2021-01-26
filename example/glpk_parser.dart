import 'package:glpk/glpk.dart';

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
