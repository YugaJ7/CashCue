import 'package:flutter/material.dart';

class SmallOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  const SmallOutlinedButton({super.key, 
    required this.text,
    required this.onPressed,
    required this.textStyle,
    required this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
            text,
            style: textStyle
          ),
    );
  }
}