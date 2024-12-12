import 'package:cashcue/widgets/social_button.dart';
import 'package:cashcue/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/register_controller.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
              height: height,
              width:  width,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/signin_back.png",
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*.71),
                        SizedBox(
                          height: height*0.065,
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: _isLoading ? 'Registering...' : 'Register',
                            onPressed: () async {
                                    if (_usernameController.text.isEmpty ||_emailController.text.isEmpty ||_confirmPasswordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are required.')));
                                      return;
                                    }
                                    else if(_confirmPasswordController.text.trim()==_passwordController.text.trim()){
                                      setState(() => _isLoading = true);
                                      await register(
                                        context: context,
                                        name: _usernameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                      );
                                      setState(() => _isLoading = false);
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password do not match. Please check the password.')));
                                    }
                                  },
                            backgroundcolor: const Color(0xFFB968E7),
                            textcolor: Colors.white,
                            bordercolor: const Color(0xFFB968E7),
                          ),
                        ),
                        const Spacer(),
                        // Row(
                        //   children: [
                        //     Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                        //     const Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                        //       child: CustomText(text: 'Or Login With', color: Color(0xFF6A707C), fontfamily: 'Urbanist', fontSize: 14, fontweigth: FontWeight.w600,)
                        //     ),
                        //     Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                        //   ],
                        // ),
                        // const SizedBox(height: 25),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SocialButton(imagePath: 'assets/images/facebook.svg'),
                        //     SizedBox(width: 8),
                        //     SocialButton(imagePath: 'assets/images/google.svg'),
                        //     SizedBox(width: 8),
                        //     SocialButton(imagePath: 'assets/images/apple.svg'),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: 'Have an account?', color: const Color(0xFFA33CEB), fontfamily: 'Urbanist',fontSize: width*0.037, fontweigth: FontWeight.w500),
                            TextButton(
                              onPressed: (){Navigator.pushReplacementNamed(context, '/login');}, 
                              child: CustomText(text: 'Sign in Now', color: const Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: width*0.037, fontweigth: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: height*.017,)
                      ],
                    ),
                  )
                ]
              ),
            ),
            SizedBox(
              height: height*.7,
              width: width,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/signup_front.png",
                    fit: BoxFit.fill,
                    width: width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*.06,),
                        Center(child: Image.asset("assets/images/logo2.png", height: height*0.097,width: width*.43,fit: BoxFit.fill,)),
                        SizedBox(height: height*.03),
                        CustomText(
                          text: 'Welcome! to Cash Cue,\nGlad to see you!', color: const Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: width*.07,fontweigth: FontWeight.bold,),
                        SizedBox(height: height*.03),
                        SizedBox(
                          height: height*0.065,
                          width: width,
                          child: CustomTextField(
                            hintText: 'Username',
                            hintSize: width*0.04,
                            hintColor: const Color(0xFF8391A1),
                            fillColor: const Color(0xFFF7F8F9),
                            textColor: const Color(0xFF8391A1),
                            controller: _usernameController,
                          ),
                        ),
                        SizedBox(height: height*.02),
                        SizedBox(
                          height: height*0.065,
                          width: width,
                          child: CustomTextField(
                            hintText: 'Email',
                            hintSize: width*0.04,
                            hintColor: const Color(0xFF8391A1),
                            fillColor: const Color(0xFFF7F8F9),
                            textColor: const Color(0xFF8391A1),
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(height: height*.02),
                        SizedBox(
                          height: height*0.065,
                          width: width,
                          child: CustomTextField(
                            hintText: 'Password',
                            hintSize: width*0.04,
                            hintColor: const Color(0xFF8391A1),
                            fillColor: const Color(0xFFF7F8F9),
                            textColor: const Color(0xFF8391A1),
                            controller: _passwordController,
                          ),
                        ),
                        SizedBox(height: height*.02),
                        SizedBox(
                          height: height*0.065,
                          width: width,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureText,
                            style: const TextStyle(color: Color(0xFF8391A1)),
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              fillColor: const Color(0xFFF7F8F9),
                              filled: true,
                              hintStyle: GoogleFonts.urbanist(color: const Color(0xFF8391A1),fontSize: width*0.04),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 1, color: Color(0xFFDADADA)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 1, color: Color(0xFFDADADA))
                              ),
                              suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: const Color(0xFF8391A1),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
