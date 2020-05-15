import 'interfaces/i_command.dart';

class InvokerCalculator {
  InvokerCalculator._(this._lastExecuted, this._commands);

  factory InvokerCalculator() {
    if (_instance == null) _instance = InvokerCalculator._(-1, []);
    return _instance;
  }

  void addCommand(ICommand command) {
    if (this._lastExecuted != this._commands.length - 1)
      this
          ._commands
          .sublist(this._lastExecuted + 1, this._commands.length)
          .clear();
    this._commands.add(command);
    command.redo();
    this._lastExecuted = this._commands.length - 1;
  }

  bool moveBackward() {
    if (this._lastExecuted >= 0) {
      this._commands[this._lastExecuted--].undo();
      return true;
    } else
      return false;
  }

  bool moveForward() {
    if (this._lastExecuted < this._commands.length - 1) {
      this._commands[++this._lastExecuted].redo();
      return true;
    } else
      return false;
  }

  int getSize() => this._commands.length;
  List<ICommand> getCommands() => this._commands;

  int _lastExecuted;
  List<ICommand> _commands;
  static InvokerCalculator _instance;
}
