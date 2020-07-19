import 'package:flutter/material.dart';

class Question extends StatelessWidget {
    final String questionText;

    Question(this.questionText); // {this.questionText} will enable named parameters
  @override
  Widget build(BuildContext context) {
    return Text(questionText, style: TextStyle(fontSize: 28),
        textAlign: TextAlign.right,);
  }
}
