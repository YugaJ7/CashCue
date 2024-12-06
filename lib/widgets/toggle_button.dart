import 'package:flutter/material.dart';
import '../widgets/text.dart';

class CustomToggleButton extends StatelessWidget {
  final bool isExpense; 
  final Function(bool) onToggle; 

  const CustomToggleButton({
    Key? key,
    required this.isExpense,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onToggle(true), 
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: isExpense ? Color.fromRGBO(182, 76, 242, 1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: CustomText(
                  text: 'Expense',
                  color: isExpense ? Colors.white : Colors.black,
                  fontfamily: 'Urbanist',
                  fontSize: 16,
                  fontweigth: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onToggle(false), 
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: !isExpense ? Color.fromRGBO(182, 76, 242, 1): Colors.transparent,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: CustomText(
                  text: 'Income',
                  color: !isExpense ? Colors.white : Colors.black,
                  fontfamily: 'Urbanist',
                  fontSize: 16,
                  fontweigth: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
