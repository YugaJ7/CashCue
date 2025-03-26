import 'package:flutter/material.dart';



class ButtonStyles {
  Color? color;
  late final ButtonStyle filledprimarybutton;
  late final ButtonStyle outlinedprimarybutton;

  ButtonStyles.withColor({this.color}) {
    filledprimarybutton = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      // side: BorderSide(
      //   color: color ?? AppColors.lightpink,
      //   width: 1
      //   )
      ),
      elevation: 0
    );
    outlinedprimarybutton = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: color ?? Colors.black,
        width: 1
        )
      ),
      elevation: 0
    );
  }
}