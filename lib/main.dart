import 'package:cashcue/screen/splash_page.dart';
import 'package:flutter/material.dart';

void main()
{
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',
      routes:
      {
        '/dashboard' : (context) => SplashScreen(),

      },
   )
  );
}