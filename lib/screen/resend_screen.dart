import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';

class ResendScreen extends StatefulWidget {
  const ResendScreen({super.key});

  @override
  State<ResendScreen> createState() => _ResendScreenState();
}

class _ResendScreenState extends State<ResendScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    text: 'Check your Email', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 30,fontweigth: FontWeight.bold,),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: 'We have sent an email with password reset information to', color: Color(0xFF8391A1), fontfamily: 'Urbanist',fontSize: 16,fontweigth: FontWeight.w500,),
                  Spacer(),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: 'Resend Email', 
                      onPressed: (){//Navigator.pushReplacementNamed(context, '/login');
                      }, 
                      backgroundcolor: const Color(0xFFB968E7), 
                      textcolor: Colors.white,
                      bordercolor: const Color(0xFFB968E7)),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: const CustomText(
                      text: 'Didn\'t receive the email? Check spam or promotion folder', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 13,fontweigth: FontWeight.normal,),
                  ),
                  SizedBox(height: 16),
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
