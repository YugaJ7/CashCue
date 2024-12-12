import 'package:flutter/material.dart';
import 'package:cashcue/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String user = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }
  Future<void> _loadUsername() async {
    try {
      final username = await SharedPreferences.getInstance();
      final name = username.getString('username');
      
      setState(() {
        user = name!;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        user = 'Default'; 
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
            begin: Alignment(0, -5),
            end: Alignment(0, 1),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        text: 'Username',
                        color: Color.fromRGBO(145, 145, 159, 1),
                        fontfamily: 'Poppins',
                        fontSize: 14,
                        fontweigth: FontWeight.w500),
                    isLoading
                        ? const CustomText(
                            text: 'Loading...',
                            color: Color.fromRGBO(22, 23, 25, 1),
                            fontfamily: 'Poppins',
                            fontSize: 24,
                            fontweigth: FontWeight.w600,
                          )
                        : CustomText(
                            text: user,
                            color: Color.fromRGBO(22, 23, 25, 1),
                            fontfamily: 'Poppins',
                            fontSize: 24,
                            fontweigth: FontWeight.w600,
                          ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //       padding: const EdgeInsets.all(4),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //               color: const Color.fromRGBO(241, 241, 250, 1)),
                //           borderRadius: const BorderRadius.all(Radius.circular(8))),
                //       child: const ImageIcon(
                //         AssetImage('assets/images/edit.png'),
                //         size: 35,
                //       )),
                // )
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){Navigator.pushNamed(context, '/balance');},
                    child: const CustomText(
                        text: 'Account',
                        color: Color.fromRGBO(41, 43, 45, 1),
                        fontfamily: 'Poppins',
                        fontSize: 16,
                        fontweigth: FontWeight.w500),
                  ),
                  // const SizedBox(height: 35),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: const CustomText(
                  //       text: 'About',
                  //       color: Color.fromRGBO(41, 43, 45, 1),
                  //       fontfamily: 'Poppins',
                  //       fontSize: 16,
                  //       fontweigth: FontWeight.w500),
                  // ),
                  const SizedBox(height: 35),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius:  BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                color: Colors.white,
                              ),
                              height: height*0.21,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const CustomText(
                                    text: 'Logout?',
                                    color: Colors.black,
                                    fontfamily: 'Poppins',
                                    fontSize: 18,
                                    fontweigth: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 10),
                                  const CustomText(
                                    text: 'Are you sure do you wanna logout?',
                                    color: Color.fromRGBO(145, 145, 159, 1),
                                    fontfamily: 'Poppins',
                                    fontSize: 18,
                                    fontweigth: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: (){Navigator.of(context).pop();},
                                        child: Container(
                                          width: 164,
                                          height: 56,
                                          padding: const EdgeInsets.all(8),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFE4B7FF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const Center(child: CustomText(text: 'No', color: Color(0xFFB54BF1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w600,)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).popUntil((route) => route.isFirst);  
                                          Navigator.pushReplacementNamed(context, '/login');
                                        },
                                        child: Container(
                                          width: 164,
                                          height: 56,
                                          padding: const EdgeInsets.all(8),
                                          decoration: ShapeDecoration(
                                            color: const Color.fromRGBO(182, 76, 242, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const Center(child: CustomText(text: 'Yes', color: Colors.white, fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w600,)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logout.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomText(
                            text: 'Logout',
                            color: Color.fromRGBO(41, 43, 45, 1),
                            fontfamily: 'Poppins',
                            fontSize: 16,
                            fontweigth: FontWeight.w500)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}