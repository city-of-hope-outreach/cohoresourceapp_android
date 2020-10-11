import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
    final String errorMsg;

    final Function() onRefresh;

    ErrorMessage({this.errorMsg, this.onRefresh}); // {this.questionText} will enable named parameters
  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(errorMsg, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            ),
            RaisedButton(
                onPressed: () {
                    this.onRefresh();
                },
                child: Text("Refresh"),
            )
        ],
      );
    // TODO add "try again" button
  }
}
