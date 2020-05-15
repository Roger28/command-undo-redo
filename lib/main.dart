import 'package:commandapp/model/calculator.dart';
import 'package:commandapp/invoker_calculator.dart';
import 'package:commandapp/service/add_subtract_command.dart';
import 'package:commandapp/service/multiply_divide_command.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Undo/Redo with calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  Calculator _calculator;
  InvokerCalculator _invokerCalculator;
  TextEditingController _input;

  @override
  void initState() {
    super.initState();
    this._calculator = Calculator();
    this._invokerCalculator = InvokerCalculator();
    this._input = TextEditingController();
  }

  void _execute(double value, String option) {
    setState(() {
      switch (option) {
        case '+':
          this
              ._invokerCalculator
              .addCommand(AddSubtractCommand(this._calculator, value));
          break;
        case '-':
          this
              ._invokerCalculator
              .addCommand(AddSubtractCommand(this._calculator, -value));
          break;
        case '*':
          this
              ._invokerCalculator
              .addCommand(MultiplyDivideCommand(this._calculator, value));
          break;
        case '/':
          this
              ._invokerCalculator
              .addCommand(MultiplyDivideCommand(this._calculator, 1.0 / value));
          break;
      }
    });
  }

  void _undo() {
    setState(() {
      if (!this._invokerCalculator.moveBackward()) this._showBar('Cannot undo!');
    });
  }

  void _redo() {
    setState(() {
      if (!this._invokerCalculator.moveForward()) this._showBar('Cannot redo!');
    });
  }

  void _showBar(String message) {
    _scaffoldstate.currentState
        .showSnackBar(SnackBar(content: Text('$message')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _input,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.blue,
                child: Text('+'),
                onPressed: () =>
                    this._execute(double.parse(this._input.value.text), '+'),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('-'),
                onPressed: () =>
                    this._execute(double.parse(this._input.value.text), '-'),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('*'),
                onPressed: () =>
                    this._execute(double.parse(this._input.value.text), '*'),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('/'),
                onPressed: () =>
                    this._execute(double.parse(this._input.value.text), '/'),
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.red,
                child: Text('Undo'),
                onPressed: this._undo,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Redo'),
                onPressed: this._redo,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Current value: '),
                    Text('${this._calculator.value}'),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ListView.separated(
                    itemCount: this._invokerCalculator.getSize(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Text(
                            '${this._invokerCalculator.getCommands()[i]}'),
                        dense: true,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
