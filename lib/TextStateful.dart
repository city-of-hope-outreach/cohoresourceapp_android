import 'package:flutter/material.dart';

class TextStateful extends StatefulWidget {
    TextStateful({Key key, this.text}) : super(key: key);

    final String text;

    _TextState state;

    void changeText(String newText) {
        state.changeText(newText);
    }

    @override
    State<StatefulWidget> createState() {
        state = _TextState(text: text);
        return state;
    }
}

class _TextState extends State<TextStateful> {
    _TextState({this.text});
    var text = 'Hello World';

    void changeText(String newText) {
        setState(() {
          this.text = newText;
        });
    }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }

}