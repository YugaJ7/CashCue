import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/text.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final DateTime today = DateTime.now();      
    final DateFormat format2 = DateFormat('MMMM');
    String month = format2.format(today);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -10.00),
                    end: Alignment(0, 1),
                    colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
                  ),
                ),
              child: Column(
                children: [
                  const SizedBox(
                      height: 44,
                    ),
                  Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFB968E7)),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: CustomText(text: month, color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth:FontWeight.w500,)
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}