import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontweigth;
  final String fontfamily;

  const CustomText({super.key, 
    required this.text,
    required this.color,
    this.fontSize,
    this.fontweigth,
    required this.fontfamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontfamily,
        textStyle: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize ?? 10,
          fontWeight: fontweigth),
        ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}

