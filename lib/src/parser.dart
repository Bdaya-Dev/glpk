import 'package:petitparser/petitparser.dart';

import '../glpk.dart';

class LinearProgramParser extends GrammarParser {
  LinearProgramParser() : super(LinearProgramDefinition());
}

class LinearProgramDefinition extends GrammarDefinition {
  LinearProgramDefinition();
  @override
  Parser<LinearProblem> start() {
    return ref(linearProgram).cast();
  }

  Parser<LinearProblem> linearProgram() => (word('name').plus() &
          char('\n') &
          ref(optimization) &
          char('\n') &
          ref(equations) &
          char('\n') &
          ref(equationConstraints) &
          char('\n') &
          ref(variableConstraints) &
          endOfInput())
      .map((l) => LinearProblem(
          name: l[0],
          optimization: l[2],
          equations: l[4],
          equationConstraints: l[6],
          variableConstraints: l[8]));

  Parser<LinearEquation> optimization() => ref(linearEquation).cast();
  Parser<LinearEquation> linearEquation() => (letter('lhs').plus().flatten() &
          char('=') &
          ref(linearTerm)
              .separatedBy(ref(ws) | char('+'), includeSeparators: false)
              .cast<List<LinearTerm>>())
      .map((l) => LinearEquation(l[0], l[2]));
  Parser<LinearTerm> linearTerm() =>
      (doubleParser('coefficient') & ref(ws) & letter('var').plus().flatten())
          .map((l) => LinearTerm(l[0], l[2]));
  Parser<List<LinearEquation>> equations() => ref(linearEquation)
      .separatedBy(char('\n'), includeSeparators: false)
      .cast();
  Parser<List<LinearConstraint>> equationConstraints() =>
      ref(constraints).cast();
  Parser<List<LinearConstraint>> variableConstraints() =>
      ref(constraints).cast();
  Parser<List<LinearConstraint>> constraints() =>
      ref(linearConstraint).plus().cast();
  Parser<LinearConstraint> linearConstraint() => (doubleParser('lower bound') &
          ref(inequality) &
          letter('var').plus().flatten() &
          ref(inequality) &
          doubleParser('upper bound'))
      .map((l) => LinearConstraint(l[0], l[2], l[4]));

  Parser<double> doubleParser(String exp) =>
      ((char('-').optional() & ref(ws) & digit(exp).plus()).flatten().map((s) =>
                  double.parse(s.replaceAll(' ', '').replaceAll('\t', ''))) |
              string('-inf', exp).map((s) => double.negativeInfinity) |
              string('inf', exp).map((s) => double.infinity))
          .cast();
  Parser ws() => whitespace().plusLazy(pattern('\r\n') | word()).flatten();
  Parser inequality() =>
      (char('>') | char('<') | string('>=') | string('<=') | char('='))
          .plus()
          .flatten();
}
