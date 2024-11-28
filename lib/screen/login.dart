import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/back2.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.07,),
                  Center(child: Image.asset("assets/images/logo2.png")),
                  const SizedBox(height: 24),
                  const CustomText(
                    text: 'Welcome Back! \nGlad to see you, Again!', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 28,fontweigth: FontWeight.bold,),
                  const SizedBox(height: 56),
                  const CustomTextField(
                    hintText: 'Enter your email',
                    hintColor: Color(0xFF8391A1),
                    fillColor: Color(0xFFF7F8F9),
                    textColor: Color(0xFF8391A1),
                  ),
                  const SizedBox(height: 16),
                  const CustomTextField(
                    hintText: 'Enter your password',
                    hintColor: Color(0xFF8391A1),
                    fillColor: Color(0xFFF7F8F9),
                    textColor: Color(0xFF8391A1),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {Navigator.pushReplacementNamed(context, '/forgot');},
                      child: const CustomText(text: 'Forgot password?', color: Color(0xFF7230A0), fontfamily: 'Urbanist', fontSize: 14, fontweigth: FontWeight.w600,)                      
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1),
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomText(text: 'Or Login With', color: Color(0xFF6A707C), fontfamily: 'Urbanist', fontSize: 14, fontweigth: FontWeight.w600,)
                      ),
                      Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton('assets/images/facebook.svg'),
                      const SizedBox(width: 8),
                      _socialLoginButton('assets/images/google.svg'),
                      const SizedBox(width: 8),
                      _socialLoginButton('assets/images/apple.svg'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: 'Don\'t have an account?', color: Color(0xFFA33CEB), fontfamily: 'Urbanist',fontSize: 14, fontweigth: FontWeight.w500),
                      TextButton(
                        onPressed: (){Navigator.pushReplacementNamed(context, '/register');}, 
                        child: const CustomText(text: 'Register Now', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 14, fontweigth: FontWeight.bold))
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

Widget _socialLoginButton(String imagePath) {
    return Container(
      height: 52,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SvgPicture.asset(
          imagePath,
        ),
      ),
    );
  }
