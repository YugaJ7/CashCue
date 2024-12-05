import 'package:flutter/material.dart';
import 'text.dart';

class TransactionItem extends StatelessWidget {
  final String? title;
  final String? amount;
  final String? time;

  const TransactionItem({Key? key, this.title, this.amount, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: title ?? 'No Title',
                color: Color.fromRGBO(41, 43, 45, 1),
                fontfamily: 'Poppins',
                fontSize: 16,
                fontweigth: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: "- ${amount ?? '₹0'}",
                color: Colors.red,
                fontfamily: 'Poppins',
                fontSize: 14,
                fontweigth: FontWeight.w600,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomText(
              text: time ?? 'No Time',
              color: Color.fromRGBO(145, 145, 159, 1),
              fontfamily: 'Poppins',
              fontSize: 12,
              fontweigth: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
