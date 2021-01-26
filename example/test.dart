import 'package:glpk/glpk.dart';

void main() {
  final problem = LinearProblem.parse('''Problem

result = 1.0*minimax + 0.0*action_0 + 0.0*action_1

sum = 0*minimax + 1.0*action_0 + 1.0*action_1
eq1 = 1.0*minimax - 0.0*action_0 - 1.0*action_1
eq0 = 1.0*minimax - 3.0*action_0 - 5.0*action_1

1.0 < sum < 1.0
-inf < eq0 < 0.0
-inf < eq1 < 0.0

-inf < minimax < inf
0.0 < action_0 < inf
0.0 < action_1 < inf
''');
  final result = problem.solve();
  print(result);
}
