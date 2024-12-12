import 'package:cashcue/screen/add_balance_screen.dart';
import 'package:cashcue/screen/add_group_screen.dart';
import 'package:cashcue/screen/add_transaction_screen.dart';
import 'package:cashcue/screen/forgot_screen.dart';
import 'package:cashcue/screen/home_screen.dart';
import 'package:cashcue/screen/login.dart';
import 'package:cashcue/screen/register.dart';
import 'package:cashcue/screen/splash_page.dart';
import 'package:cashcue/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/home_contoller.dart';  
import 'screen/profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot': (context) => const ForgotScreen(),
        '/navbar': (context) => const Navbar(),
        '/home': (context) => const HomeScreen(),
        '/add_expense': (context) => const ExpenseIncomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/analysis': (context) => const ProfileScreen(),
        '/group': (context) => const ProfileScreen(),
        '/balance': (context) => const AddBalanceScreen(),
        '/add_group': (context) => const AddGroupScreen(),
      },
    );
  }
}
