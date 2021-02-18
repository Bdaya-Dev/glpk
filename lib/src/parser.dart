import 'package:glpk/src/problem.dart';
import 'package:petitparser/petitparser.dart';

class LinearProgramParser extends GrammarParser {
  LinearProgramParser() : super(LinearProgramDefinition());
}

class LinearProgramDefinition extends GrammarDefinition {
  LinearProgramDefinition();
  @override
  Parser<LinearProblem> start() {
    return ref(linearProgram).cast();
  }

  Parser<LinearProblem> linearProgram() => (word('name').plus().flatten() &
              string('\n\n', 'double newline') &
              (stringIgnoreCase('max') | stringIgnoreCase('min'))
                  .trim()
                  .optionalWith('max') &
              ref(optimization) &
              string('\n\n', 'double newline') &
              ref(equations) &
              string('\n\n', 'double newline') &
              ref(equationConstraints) &
              string('\n\n', 'double newline') &
              ref(variableConstraints) &
              char('\n') &
              endOfInput())
          .map(
        (l) => LinearProblem(
          name: l[0],
          optimization: l[3],
          equations: l[5],
          equationConstraints: l[7],
          variableConstraints: l[9],
          maximize: (l[2] as String).toLowerCase() == 'min' ? false : true,
        ),
      );

  Parser<LinearEquation> optimization() => ref(linearEquation).cast();
  Parser<LinearEquation> linearEquation() =>
      ((letter('var') & word('var').star()).flatten() &
              char('=').surroundedBy(ref(ws).star()) &
              ref(linearTerm)
                  .separatedBy(
                      (char('+').surroundedBy(ref(ws).plus()).flatten() |
                          ref(ws).plus().flatten()),
                      includeSeparators: false)
                  .castList<LinearTerm>())
          .map((l) => LinearEquation(l[0], l[2]))
          .debug();
  Parser<LinearTerm> linearTerm() => (doubleParser('coefficient') &
          (char('*').surroundedBy(ref(ws).star()) | ref(ws).star()) &
          (letter('var') & word('var').star()).flatten())
      .map((l) => LinearTerm(l[0] ?? 1, l[2]));
  Parser<List<LinearEquation>> equations() => ref(linearEquation)
      .separatedBy(char('\n'), includeSeparators: false)
      .castList();
  Parser<List<LinearConstraint>> equationConstraints() =>
      ref(constraints).cast();
  Parser<List<LinearConstraint>> variableConstraints() =>
      ref(constraints).cast();
  Parser<List<LinearConstraint>> constraints() => ref(linearConstraint)
      .separatedBy(char('\n'), includeSeparators: false)
      .castList();
  Parser<LinearConstraint> linearConstraint() => (doubleParser('lower bound') &
          ref(inequality) &
          word('var').plus().flatten() &
          ref(inequality) &
          doubleParser('upper bound'))
      .map((l) => LinearConstraint(l[0], l[2], l[4]));

  Parser<double> doubleParser(String exp) =>
      (string('-inf', exp).map((s) => double.negativeInfinity) |
              string('inf', exp).map((s) => double.infinity) |
              ((char('-') & ref(ws).star()).optional() &
                      digit(exp).star() &
                      char('.').optional() &
                      digit(exp).star())
                  .flatten()
                  .map((s) {
                final str = s.replaceAll(' ', '').replaceAll('\t', '').trim();
                if (str.isEmpty) {
                  return 1.0;
                } else if (str == '-') {
                  return -1.0;
                }
                return double.parse(str);
              }))
          .cast();
  Parser ws() => char('\t', 'whitespace') | char(' ', 'whitespace');
  Parser inequality() =>
      (char('>') | char('<') | string('>=') | string('<=') | char('='))
          .surroundedBy(ref(ws).plus())
          .flatten();
}

extension ParserHelpers<T> on Parser<T> {
  Parser surroundedBy(Parser p) {
    return p & this & p;
  }

  Parser<T> debug() => map((t) {
        print(t);
        return t;
      });
}
