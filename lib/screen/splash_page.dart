import 'dart:async';
import 'package:cashcue/screen/login_register_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const LoginRegisterScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/test.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(child: Image.asset("assets/images/logo.png"))
        ],
      ),
    );
  }
}



