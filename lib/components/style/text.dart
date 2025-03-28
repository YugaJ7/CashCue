import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
   Color? textcolor;
   late final TextStyle onboardinghead;
   late final TextStyle onboardingtitle;
   late final TextStyle headline1;
   late final TextStyle headline2;
   late final TextStyle bodytext1;
   late final TextStyle bodytext2; 
   late final TextStyle bodytext3;
   late final TextStyle buttontext2;
   TextStyles.withColor({this.textcolor}) {
     onboardinghead = GoogleFonts.poppins(
       color: textcolor,
       fontSize: 30,
       fontWeight: FontWeight.w800,
     );
     onboardingtitle = GoogleFonts.poppins(
       color: textcolor,
       fontSize: 14,
       fontWeight: FontWeight.w400,
     );
     headline1 = GoogleFonts.urbanist(
       color: textcolor,
       fontSize: 30,
       fontWeight: FontWeight.w700,
       height: 1.3,
       letterSpacing: 1.0
     );
     headline2 = GoogleFonts.urbanist(
       color: textcolor,
       fontSize: 15,
       fontWeight: FontWeight.w700,
       height: 1.7
     );
     bodytext1 = GoogleFonts.notoSans(
      color: textcolor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    bodytext2 = GoogleFonts.urbanist(
       color: textcolor,
       fontSize: 14,
       fontWeight: FontWeight.w600,
     );
    bodytext3 = GoogleFonts.urbanist(
       color: textcolor,
       fontSize: 15,
       fontWeight: FontWeight.w500,
     );
    buttontext2 = GoogleFonts.urbanist(
       color: textcolor,
       fontSize: 15,
       fontWeight: FontWeight.w600,
     );
   }
}