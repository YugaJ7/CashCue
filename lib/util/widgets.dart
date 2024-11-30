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

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundcolor;
  final Color? textcolor;
  final Color? bordercolor;
  const CustomElevatedButton({super.key, 
    required this.text,
    required this.onPressed,
    required this.backgroundcolor,
    required this.textcolor,
    this.bordercolor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: bordercolor ?? const Color(0xFFA33CEB).withOpacity(.4), //Color(0xFFA33CEB).withOpacity(.4),
            width: 1
          )
        ),
        elevation: 0
      ),
      child: Text(
        text,
        style: GoogleFonts.urbanist(
          textStyle: TextStyle(
            color: textcolor,
            fontSize: 15,
            fontWeight: FontWeight.w600
          )
        )
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double hintSize;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Color? fillColor;
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
          borderSide: BorderSide(width: 1, color: Color(0xFFDADADA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1, color: Color(0xFFDADADA))
        ),
        //focusColor: const Color(0xFFDADADA)
      ),
    );
  }
}