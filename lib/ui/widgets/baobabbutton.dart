import 'package:flutter/material.dart';

class BaobabButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final String customIcon;

  const BaobabButton({Key key, this.callback, this.text, this.customIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      buttonColor: Colors.orangeAccent[400],
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: RaisedButton(
        onPressed: callback,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
