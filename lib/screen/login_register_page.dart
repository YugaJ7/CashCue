import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}