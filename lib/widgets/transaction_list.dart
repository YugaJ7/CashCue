import 'package:cashcue/widgets/text.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String time;
  final Color color;

  const TransactionItem({
    Key? key,
    required this.title,
    required this.amount,
    required this.time,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: title,
                color: Color.fromRGBO(145, 145, 159, 1),
                fontfamily: 'Poppins',
                fontSize: 16,
                fontweigth: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: amount,
                color: color,
                fontfamily: 'Poppins',
                fontSize: 15,
                fontweigth: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomText(
              text: time,
              color: Color.fromRGBO(145, 145, 159, 1),
              fontfamily: 'Poppins',
              fontSize: 14,
              fontweigth: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
