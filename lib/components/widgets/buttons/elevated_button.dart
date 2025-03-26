import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    required this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        )
      ),
    );
  }
}
