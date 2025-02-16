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
      _result = ''; // Reset hasil juga
      _isNewCalculation = false;
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
      // Hapus replaceAll yang tidak diperlukan
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
}
