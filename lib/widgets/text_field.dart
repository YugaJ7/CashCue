import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double hintSize;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final double borderRadius;
  final bool filled;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.hintSize,
    this.onChanged,
    this.controller,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.hintColor,
    this.borderRadius = 8.0,
    this.filled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: textColor ?? Colors.black),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        filled: filled,
        hintStyle: GoogleFonts.urbanist(color: hintColor, fontSize: hintSize),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1, color: borderColor??Color(0xFFDADADA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1, color:borderColor??Color(0xFFDADADA))
        ),
        //focusColor: const Color(0xFFDADADA)
      ),
    );
  }
}

