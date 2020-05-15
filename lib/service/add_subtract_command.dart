import 'package:commandapp/interfaces/i_command.dart';

import '../model/calculator.dart';

class AddSubtractCommand implements ICommand {
  AddSubtractCommand(this._calculator, this._value);

  @override
  void redo() {
    this._calculator.add(this._value);
  }

  @override
  void undo() {
    this._calculator.add(-this._value);
  }

  @override
  String toString() {
    return 'AddSubtractCommand: $_calculator\nvalue: $_value}';
  }

  Calculator _calculator;
  double _value;
}
