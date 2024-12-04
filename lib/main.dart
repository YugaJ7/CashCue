import 'package:cashcue/screen/add_screen.dart';
import 'package:cashcue/screen/forgot_screen.dart';
import 'package:cashcue/screen/home_screen.dart';
import 'package:cashcue/screen/login.dart';
import 'package:cashcue/screen/register.dart';
import 'package:cashcue/screen/splash_page.dart';
import 'package:cashcue/widgets/navbar.dart';
import 'package:flutter/material.dart';

void main()
{
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:
      {
        '/' : (context) => const SplashScreen(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/forgot' : (context) => ForgotScreen(),
        '/navbar' : (context) => Navbar(),
        '/home' : (context) => HomeScreen(),
        '/add_expense' : (context) => ExpenseIncomeScreen()
      },
   )
  );
}