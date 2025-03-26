import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton(
      {super.key,
      required this.buttonLabel,
      required this.buttonLabelStyle,
      required this.backGroundColor,
      required this.borderColor,
      required this.buttonFunction});
final  Function buttonFunction;
 final String buttonLabel;
 final TextStyle buttonLabelStyle;
 final Color backGroundColor;
 final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:() => buttonFunction(),
        child: Text(buttonLabel, style: buttonLabelStyle),
        style: ElevatedButton.styleFrom(
            backgroundColor: backGroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: borderColor))));
  }
}
