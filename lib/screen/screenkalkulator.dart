import 'package:flutter/material.dart';
import 'package:flutterkalkulator/controller/logikakalkulator.dart';

class ScreenKalkulator extends StatefulWidget {
  @override
  State<ScreenKalkulator> createState() => _ScreenKalkulatorState();
}

class _ScreenKalkulatorState extends State<ScreenKalkulator> {
  final Color primaryGreen = Color(0xFF4CAF50);
  final Color lightGreen = Color(0xFFE8F5E9);
  final Color darkGreen = Color(0xFF2E7D32);
  final Color errorRed = Color(0xFFD32F2F);

  final KalkulatorController _controller = KalkulatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      appBar: AppBar(
        title: Text(
          'Kalkulator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: darkGreen,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _controller.input,
                    style: TextStyle(fontSize: 36, color: darkGreen),
                  ),
                  SizedBox(height: 10),
                  if (_controller.result.isNotEmpty)
                    Text(
                      _controller.result,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _controller.result == 'Error'
                            ? errorRed
                            : darkGreen,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Divider(color: darkGreen),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildOperatorButton('x'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildOperatorButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('C'),
              _buildButton('DEL'),
              _buildButton('('),
              _buildButton(')'),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (text == '=') {
              _controller.calculate();
            } else if (text == 'DEL') {
              _controller.deleteLastCharacter();
            } else if (text == 'C') {
              _controller.clear();
            } else {
              _controller.addInput(text);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: darkGreen,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _controller.addInput(text);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
