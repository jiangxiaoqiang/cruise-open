import 'package:flutter/material.dart';

class GlobalStyle {

  static ButtonStyle textButtonStyle = ElevatedButton.styleFrom(onPrimary: Colors.black, shape: CircleBorder(side: BorderSide(color: Colors.transparent)));

  static ButtonStyle getButtonStyle(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    );
    return raisedButtonStyle;
  }
}

