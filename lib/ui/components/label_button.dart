import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String labelText;
  final void Function() onPressed;

  const LabelButton({super.key, required this.labelText, required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
      ),
    );
  }
}