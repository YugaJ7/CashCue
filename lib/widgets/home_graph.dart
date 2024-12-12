import 'package:cashcue/widgets/tabButton.dart';
import 'package:cashcue/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/home_contoller.dart';

class AverageMoneySpentGraph extends StatefulWidget {
  const AverageMoneySpentGraph({super.key});

  @override
  State<AverageMoneySpentGraph> createState() => _AverageMoneySpentGraphState();
}

class _AverageMoneySpentGraphState extends State<AverageMoneySpentGraph> {
  String selectedTab = "Today";  
  List<Map<String, dynamic>> graphData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGraphData(); 
  }

Future<void> fetchGraphData() async {
    setState(() {
      isLoading = true;
    });

    String url = '';
    if (selectedTab == "Today") {
      url = "https://cash-cue.onrender.com/transaction/graph1";
    } else if (selectedTab == "Weekly") {
      url = "https://cash-cue.onrender.com/transaction/graph2";
    } else if (selectedTab == "Monthly") {
      url = "https://cash-cue.onrender.com/transaction/graph3";
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          graphData = List<Map<String, dynamic>>.from(data['data']);
          isLoading = false;
          print(graphData);
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  List<BarChartGroupData> createBarGroups() {
    return graphData
        .asMap()
        .map(
          (index, item) => MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: selectedTab == "Today"
                  ? [
                      BarChartRodData(
                        toY: (item['amount'] ?? 0).toDouble(),
                        color: item['type']=='Expense'? Colors.red : Colors.green,
                        width: 15,
                      ),
                    ]
                  : [
                      BarChartRodData(
                        toY: (item['totalExpense'] ?? 0).toDouble(),
                        color: Colors.red,
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: (item['totalIncome'] ?? 0).toDouble(),
                        color: Colors.green,
                        width: 8,
                      ),
                    ],
              barsSpace: selectedTab == "Today" ? 0 : 4,
            ),
          ),
        )
        .values
        .toList();
  }
  String formatLargeNumber(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k'; 
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context); 
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double averageSpent = homeController.getCurrentAverageExpense(); 

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
                text: "₹${averageSpent.toStringAsFixed(2)}", 
                color: Colors.black,
                fontfamily: 'Poppins',
                fontSize: width * 0.05,
                fontweigth: FontWeight.w600,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: height * 0.25,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : BarChart(
                        BarChartData(
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, _) {
                                  int index = value.toInt();
                                  if (index >= 0 && index < graphData.length) {
                                    return CustomText(
                                      text: selectedTab == "Today"? graphData[index]['time'] ?? '' : selectedTab == "Weekly"? graphData[index]['date'] ?? '' : graphData[index]['weekLabel'],
                                      color: const Color.fromRGBO(97, 94, 131, 1),
                                      fontfamily: 'Poppins',
                                      fontSize: 12,
                                      fontweigth: FontWeight.w400,
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              drawBelowEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (double value, _) {
                                  String formattedValue = formatLargeNumber(value.toInt());
                                  return CustomText(
                                    text: formattedValue,
                                    color: const Color.fromRGBO(97, 94, 131, 1),
                                    fontfamily: 'Poppins',
                                    fontSize: 14,
                                    fontweigth: FontWeight.w400,
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barGroups: createBarGroups(),
                        ),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
//         Row(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     TabButton(
//       "Today",
//       0,
//       homeController.selectedTab == "Today" ? 0 : -1,
//       (index) {
//         homeController.updateSelectedTab("Today");
//         fetchGraphData(); // Fetch data when tab changes
//       },
//     ),
//     TabButton(
//       "Weekly",
//       1,
//       homeController.selectedTab == "Weekly" ? 1 : -1,
//       (index) {
//         homeController.updateSelectedTab("Weekly");
//         fetchGraphData(); // Fetch data when tab changes
//       },
//     ),
//     TabButton(
//       "Monthly",
//       2,
//       homeController.selectedTab == "Monthly" ? 2 : -1,
//       (index) {
//         homeController.updateSelectedTab("Monthly");
//         fetchGraphData(); // Fetch data when tab changes
//       },
//     ),
//   ],
// ),
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    TabButton(
      "Today",
      0,
      selectedTab == "Today" ? 0 : -1,
      (index) {
        setState(() {
          selectedTab = "Today"; 
          homeController.updateSelectedTab("Today");// Update the local state
        });
        fetchGraphData(); // Fetch graph data for "Today"
      },
    ),
    TabButton(
      "Weekly",
      1,
      selectedTab == "Weekly" ? 1 : -1,
      (index) {
        setState(() {
          selectedTab = "Weekly"; 
          homeController.updateSelectedTab("Weekly");// Update the local state
        });
        fetchGraphData(); // Fetch graph data for "Weekly"
      },
    ),
    TabButton(
      "Monthly",
      2,
      selectedTab == "Monthly" ? 2 : -1,
      (index) {
        setState(() {
          selectedTab = "Monthly";
          homeController.updateSelectedTab("Monthly"); // Update the local state
        });
        fetchGraphData(); // Fetch graph data for "Monthly"
      },
    ),
  ],
),

      ],
    );
  }
}
