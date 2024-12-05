import 'package:flutter/material.dart';

import 'tabButton.dart';
import 'text.dart';

class AverageMoneySpentGraph extends StatefulWidget {
  const AverageMoneySpentGraph({super.key});

  @override
  State<AverageMoneySpentGraph> createState() => _AverageMoneySpentGraphState();
}

class _AverageMoneySpentGraphState extends State<AverageMoneySpentGraph> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Average money spent",
                color: const Color.fromRGBO(146, 145, 165, 1),
                fontfamily: 'Poppins',
                fontSize: width * .045,
                fontweigth: FontWeight.w600,
              ),
              CustomText(
                text: '\$1000',
                color: Colors.black,
                fontfamily: 'Poppins',
                fontSize: width * 0.05,
                fontweigth: FontWeight.w600,
              ),
              const SizedBox(height: 16),
              // Placeholder for graph
              Container(
                height: 100,
                child: const Center(
                  child: Text("Graph Placeholder"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabButton("Today", 0, selectedIndex, (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
            TabButton("Week", 1, selectedIndex, (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
            TabButton("Month", 2, selectedIndex, (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
          ],
        ),
      ],
    );
  }
}
