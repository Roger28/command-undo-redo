class Calculator {

  Calculator([this._value = 0.0]);

  double get value => _value;

  void add(double amount) => this._value += amount;

  void multiply(double amount) => this._value *= amount;

  @override
  String toString() {
    return '';
  }

  double _value;

}
