import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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

