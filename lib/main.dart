import 'package:cashcue/screen/add_balance_screen.dart';
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
        '/forgot': (context) => ForgotScreen(),
        '/navbar': (context) => Navbar(),
        '/home': (context) => const HomeScreen(),
        '/add_expense': (context) => ExpenseIncomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/analysis': (context) => ProfileScreen(),
        '/group': (context) => ProfileScreen(),
        '/balance': (context) => AddBalanceScreen(),
      },
    );
  }
}
