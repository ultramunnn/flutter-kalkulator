import 'package:flutter/material.dart';
import 'package:flutterkalkulator/screen/screenkalkulator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.blue),
      ),
      home: ScreenKalkulator(),
    );
  }
}
