import 'package:flutter/material.dart';
import 'package:glpk/glpk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LinearProblem problem = LinearProblem.parse('''example

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
  late final result = problem.solve();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Problem: $problem'),
            Text('Result: ${result}'),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
