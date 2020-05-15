import 'package:commandapp/interfaces/i_command.dart';

import '../model/calculator.dart';

class MultiplyDivideCommand implements ICommand {
  MultiplyDivideCommand(this._calculator, this._amount);

  @override
  void redo() {
    this._calculator.multiply(this._amount);
  }

  @override
  void undo() {
    this._calculator.multiply(1.0 / this._amount);
  }

  @override
  String toString() {
    return 'MultiplyDivideCommand: $_calculator\nvalue: $_amount}';
  }

  Calculator _calculator;
  double _amount;
}
