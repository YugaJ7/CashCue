import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/home_contoller.dart';
import 'tabButton.dart';
import 'text.dart';

class AverageMoneySpentGraph extends StatefulWidget {
  const AverageMoneySpentGraph({super.key});

  @override
  State<AverageMoneySpentGraph> createState() => _AverageMoneySpentGraphState();
}

class _AverageMoneySpentGraphState extends State<AverageMoneySpentGraph> {
  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context); 
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
                text: "₹${homeController.getCurrentAverageExpense()}",
                color: Colors.black,
                fontfamily: 'Poppins',
                fontSize: width * 0.05,
                fontweigth: FontWeight.w600,
              ),
              const SizedBox(height: 16),
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
            TabButton(
              "Today",
              0,
              homeController.selectedTab == "Daily" ? 0 : -1,
              (index) {
                homeController.updateSelectedTab("Daily");
              },
            ),
            TabButton(
              "Weekly",
              1,
              homeController.selectedTab == "Weekly" ? 1 : -1,
              (index) {
                homeController.updateSelectedTab("Weekly");
              },
            ),
            TabButton(
              "Monthly",
              2,
              homeController.selectedTab == "Monthly" ? 2 : -1,
              (index) {
                homeController.updateSelectedTab("Monthly");
              },
            ),
          ],
        ),
      ],
    );
  }
}
