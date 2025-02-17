import 'package:math_expressions/math_expressions.dart';

class KalkulatorController {
  String _input = '';
  String _result = '';
  bool _isNewCalculation = true;

  String get input => _input;
  String get result => _result;

  void addInput(String value) {
    if (_isNewCalculation) {
      _input = '';
      _result = '';
      _isNewCalculation = false;
    }

    if (_input.isEmpty) {
      if (value == '-' || value == '(') {
        _input = value; // Izinkan "-" atau "(" di awal input
        return;
      }
    } else {
      String lastChar = _input[_input.length - 1];

      // Cegah operator lain selain '-' atau '(' di awal input
      if (_input.length == 1 && isOperator(lastChar)) {
        return;
      }

      // Tambahkan input jika valid
    }
    _input += value;
  }

  void deleteLastCharacter() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
    }
  }

  void clear() {
    _input = '';
    _result = '';
    _isNewCalculation = true;
  }

  void calculate() {
    try {
      String expression = _input
          .replaceAll('x', '*') // Ganti x dengan *
          .replaceAll(',', '.'); // Ganti koma dengan titik untuk desimal
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      _result = _removeDecimalZero(eval.toString());
      _isNewCalculation = true;
    } catch (e) {
      _result = 'Error';
      _isNewCalculation = false;
    }
  }

  String _removeDecimalZero(String value) {
    return value.replaceAll(RegExp(r'\.0$'), '');
  }

  bool isOperator(String char) {
    return ['+', '-', 'x', '/', '(', ')'].contains(char);
  }

  void replaceLastOperator(String newOperator) {
    if (_input.isNotEmpty && isOperator(_input[_input.length - 1])) {
      _input = _input.substring(0, _input.length - 1) + newOperator;
    }
  }

  void handleOperatorInput(String text) {
    if (_input.isEmpty) return; // Mencegah operator di awal input

    String lastChar = _input[_input.length - 1];

    if (!isOperator(lastChar)) {
      addInput(text); // Tambahkan operator jika sebelumnya bukan operator
    } else {
      replaceLastOperator(text); // Ganti operator terakhir jika sudah ada
    }
  }
}
