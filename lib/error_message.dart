import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
    final String errorMsg;

    ErrorMessage(this.errorMsg); // {this.questionText} will enable named parameters
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(errorMsg, style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
    ),);
    // TODO add "try again" button
  }
}
