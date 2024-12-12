import 'package:cashcue/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../controller/forgot_controller.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // Future<void> _forgot() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   final String email = _emailController.text.trim();
    
  //   if (email.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email')));
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return;
  //   }
  //   final Uri url = Uri.parse('https://cash-cue.onrender.com/user/forgot-password');
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'email': email,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     if (data['success'] == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email send successful')));
  //       //Navigator.pushReplacementNamed(context, '/home');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Email sending failed')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred. Please try again.')));
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
              height: height,
              width:  width,
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
                  CustomTextField(
                    hintText: 'Enter your email',
                    hintSize: width*0.04,
                    hintColor: const Color(0xFF8391A1),
                    fillColor: const Color(0xFFF7F8F9),
                    textColor: const Color(0xFF8391A1),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: _isLoading ? 'Sending...' : 'Send Email', 
                      onPressed: () async {
                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email')));
                          return;
                        }
                        else{
                          setState(() {
                            _isLoading = true;
                          });
                          await forgot(context: context, email: _emailController.text.trim());
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      backgroundcolor: const Color(0xFFB968E7), 
                      textcolor: Colors.white,
                      bordercolor: const Color(0xFFB968E7)),
                  ),
                  const Spacer(),
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
