import 'dart:convert';
import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirm_passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirm_passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
  setState(() => _isLoading = true);
  try {
    final response = await http.post(
      Uri.parse('https://cash-cue.onrender.com/user/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _confirm_passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Registration successful')));
      //Navigator.pushReplacementNamed(context, '/home');
    } else {
      final errorMessage = jsonDecode(response.body)['message'] ?? 'Registration failed';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  } finally {
    setState(() => _isLoading = false);
  }
}
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
                "assets/images/signup_back.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.06,),
                  Center(child: Image.asset("assets/images/logo2.png")),
                  const SizedBox(height: 24),
                  const CustomText(
                    text: 'Welcome! to Cash Cue,\nGlad to see you!', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 28,fontweigth: FontWeight.bold,),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Username',
                    hintColor: const Color(0xFF8391A1),
                    fillColor: const Color(0xFFF7F8F9),
                    textColor: const Color(0xFF8391A1),
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Email',
                    hintColor: const Color(0xFF8391A1),
                    fillColor: const Color(0xFFF7F8F9),
                    textColor: const Color(0xFF8391A1),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Password',
                    hintColor: const Color(0xFF8391A1),
                    fillColor: const Color(0xFFF7F8F9),
                    textColor: const Color(0xFF8391A1),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirm_passwordController,
                    obscureText: _obscureText,
                    style: const TextStyle(color: Color(0xFF8391A1)),
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      fillColor: const Color(0xFFF7F8F9),
                      filled: true,
                      hintStyle: const TextStyle(color: Color(0xFF8391A1)),
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
                  const SizedBox(height: 72),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: _isLoading ? 'Registering...' : 'Register',
                      onPressed: () async {
                              if (_usernameController.text.isEmpty ||_emailController.text.isEmpty ||_confirm_passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are required.')));
                                return;
                              }
                              else if(_confirm_passwordController.text.trim()==_passwordController.text.trim()){
                                await _register();
                              }
                              else{
                                print(_confirm_passwordController.text);
                                print(_passwordController.text);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passowrd doesn\'t match. Please the password.')));
                              }
                            },
                      backgroundcolor: const Color(0xFFB968E7),
                      textcolor: Colors.white,
                      bordercolor: const Color(0xFFB968E7),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 25),
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
                      const CustomText(text: 'Have an account?', color: Color(0xFFA33CEB), fontfamily: 'Urbanist',fontSize: 14, fontweigth: FontWeight.w500),
                      TextButton(
                        onPressed: (){Navigator.pushReplacementNamed(context, '/login');}, 
                        child: const CustomText(text: 'Sign in Now', color: Color(0xFF1E122B), fontfamily: 'Urbanist',fontSize: 14, fontweigth: FontWeight.bold))
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
