import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.leftButtonText,
      required this.leftButtonColor,
      required this.rightButtonTex,
      required this.rightButtonColor,
      required this.onConfirmed});
  final String title;
  final String description;
  final String rightButtonTex;
  final String leftButtonText;
  final Color rightButtonColor;
  final Color leftButtonColor;
  final Function onConfirmed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.white)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              description,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  leftButtonText,
                  style: TextStyle(color: leftButtonColor),
                )),
            TextButton(
                onPressed: () {
                  onConfirmed();
                },
                child: Text(
                  rightButtonTex,
                  style: TextStyle(color: rightButtonColor),
                )),
          ],
        )
      ],
    );
  }
}
