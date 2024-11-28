import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/forgot.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.18,),
                  const CustomText(
                    text: 'Forgot Password?', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 30,fontweigth: FontWeight.bold,),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: 'Don\'t worry! It occurs. Please enter the email address linked with your account.', color: Color(0xFF8391A1), fontfamily: 'Urbanist',fontSize: 16,fontweigth: FontWeight.w500,),
                  SizedBox(height: MediaQuery.of(context).size.height*.08,),
                  const CustomTextField(
                    hintText: 'Enter your email',
                    hintColor: Color(0xFF8391A1),
                    fillColor: Color(0xFFF7F8F9),
                    textColor: Color(0xFF8391A1),
                  ),
                  SizedBox(height: 16),
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
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: 'Remember Password?', color: Color(0xFFA33CEB), fontfamily: 'Urbanist',fontSize: 15, fontweigth: FontWeight.w500),
                      TextButton(
                        onPressed: (){Navigator.pushReplacementNamed(context, '/login');}, 
                        child: const CustomText(text: 'Login', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 15, fontweigth: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}