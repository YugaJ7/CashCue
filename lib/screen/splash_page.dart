import 'dart:async';
import 'package:cashcue/screen/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginRegisterScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              "assets/images/back1.svg",
              fit: BoxFit.cover,
            ),
          ),
          Center(child: SvgPicture.asset("assets/images/logo.svg"))
        ],
      ),
    );
  }
}



