import 'package:app5/hom.dart';
import 'package:flutter/material.dart';

void main() => runApp(BmiCalculation());

class BmiCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculatorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
