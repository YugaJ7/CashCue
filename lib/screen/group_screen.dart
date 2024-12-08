import 'package:cashcue/widgets/text.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
            begin: Alignment(0, -5),
            end: Alignment(0, 1),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 45),
              CustomText(text: 'Group', color: Color.fromRGBO(30, 18, 43, 1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w500)
            ],
          ),
        )
      )
    );
  }
}