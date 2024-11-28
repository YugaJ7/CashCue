import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/test.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Login', 
                    onPressed: (){Navigator.pushReplacementNamed(context, '/login');}, 
                    backgroundcolor: const Color(0xFFB968E7), 
                    textcolor: Colors.white,
                    bordercolor: const Color(0xFFB968E7)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Register', 
                    onPressed: (){Navigator.pushReplacementNamed(context, '/register');}, 
                    backgroundcolor: Colors.white, 
                    textcolor: const Color(0xFF6A707C),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}