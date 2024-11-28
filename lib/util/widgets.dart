import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontweigth;

  const CustomText({
    required this.text,
    required this.color,
    this.fontSize,
    this.fontweigth,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize ?? 10,
          fontWeight: fontweigth),
      )
    );
  }
}