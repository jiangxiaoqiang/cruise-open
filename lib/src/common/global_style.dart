import 'package:flutter/material.dart';

class GlobalStyle {
  static ButtonStyle textButtonStyle = ElevatedButton.styleFrom(onPrimary: Colors.black, shape: CircleBorder(side: BorderSide(color: Colors.transparent)));

  static ButtonStyle getButtonStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).primaryColor,
      minimumSize: Size(screenWidth - 40, 45),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    );
    return raisedButtonStyle;
  }
}
