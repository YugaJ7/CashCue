// import 'package:cashcue/controller/home_contoller.dart';
// import 'package:cashcue/widgets/text.dart';
// import 'package:flutter/material.dart';
// //import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AnalysisScreen extends StatefulWidget {
//   const AnalysisScreen({super.key});

//   @override
//   _AnalysisScreenState createState() => _AnalysisScreenState();
// }

// class _AnalysisScreenState extends State<AnalysisScreen> {
//   String selectedTab = "Today";
//   double nextmonthsum = 0.0;
//   List<dynamic> nextdaysum = [0];
//   double nextweeksum = 0.0;
//   //List<Map<String, dynamic>> predictiondata = [];

//   @override
//   void initState() {
//     super.initState();
//     // fetchTodayData();
//     // fetchWeeklyData();
//     fetchPredictedExpense();
//   }

//   // Future<void> fetchTodayData() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final token = prefs.getString('authToken');

//   //   if (token == null) throw Exception("Authentication token is missing");

//   //   final response = await http.get(
//   //     Uri.parse('https://cash-cue.onrender.com/transaction/graph1'),
//   //     headers: {
//   //       "Authorization": "Bearer $token",
//   //       "Content-Type": "application/json",
//   //     },
//   //   );

//   //   debugPrint("Today Data API Response: ${response.statusCode} - ${response.body}");

//   //   if (response.statusCode == 200) {
//   //     final data = json.decode(response.body)['data'];
//   //     print(data);
//   //     if (data != null && data is List) {
//   //       setState(() {
//   //         todayData = List<Map<String, dynamic>>.from(data);
//   //       });
//   //     }
//   //   }
//   // }

//   // Future<void> fetchWeeklyData() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final token = prefs.getString('authToken');

//   //   if (token == null) throw Exception("Authentication token is missing");

//   //   final response = await http.get(
//   //     Uri.parse('https://cash-cue.onrender.com/transaction/graph2'),
//   //     headers: {
//   //       "Authorization": "Bearer $token",
//   //       "Content-Type": "application/json",
//   //     },
//   //   );

//   //   debugPrint("Weekly Data API Response: ${response.statusCode} - ${response.body}");

//   //   if (response.statusCode == 200) {
//   //     final data = json.decode(response.body);
//   //     if (data != null && data['transactions'] is List) {
//   //       setState(() {
//   //         weeklyCurrentData = List<FlSpot>.from(data['transactions'].asMap().entries.map((entry) {
//   //           return FlSpot(entry.key.toDouble(), entry.value['totalExpense'].toDouble());
//   //         }));
//   //       });
//   //     }
//   //   }
//   // }

//   Future<void> fetchPredictedExpense() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authToken');

//   if (token == null) throw Exception("Authentication token is missing");

//   final response = await http.get(
//     Uri.parse('https://cash-cue.onrender.com/predict/expense'),
//     headers: {
//       "Authorization": "Bearer $token",
//       "Content-Type": "application/json",
//     },
//   );

//   debugPrint("Predicted Expense API Response: ${response.statusCode} - ${response.body}");

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);

//     if (data != null && data['data'] != null && data['data']['predictions'] != null) {
//       // Assuming predictedExpense is a List<Map<String, dynamic>> or similar structure
//       final predictions = data['data']['predictions'];
//       print(predictions);
//       print(predictions['next_day_forecast']);
//       setState(() {
//         nextmonthsum = predictions["next_month_forecast_sum"];
//         nextdaysum = predictions['next_day_forecast'];
//         nextweeksum = predictions['next_week_forecast_sum'];
//         print(nextdaysum);
//         print(nextweeksum);
//         print(nextmonthsum);
//         // predictiondata=predictions;
//         // print(predictiondata);
//       });
//       // Perform null check for specific fields if necessary
//     //   if (predictions['next_day_forecast'] != null) {
//     //     setState(() {
//     //       predictedExpense = predictions['next_day_forecast']; // Assigning relevant data
//     //       print("Predicted Expense: $predictedExpense");
//     //     });
//     //   } else {
//     //     print("Next day forecast is null.");
//     //   }
//     // } else {
//     //   print("Prediction data is missing or malformed.");
//     }
//   } else {
//     print("Failed to fetch data. Status code: ${response.statusCode}");
//   }
// }


//   // Widget buildGraph() {
//   //   if (selectedTab == "Today") {
//   //     // Filter data to only show "Expense" entries
//   //     List<Map<String, dynamic>> expenseData = todayData.where((entry) {
//   //       return entry['type'] == 'Expense';
//   //     }).toList();

//   //     // Map the filtered data into FlSpot (x, y)
//   //     List<FlSpot> spots = expenseData.asMap().entries.map((entry) {
//   //       // Convert time '00:01' to numeric x value (e.g., 1 for '00:01')
//   //       String time = entry.value['time'];
//   //       int timeInMinutes = _convertTimeToMinutes(time);
//   //       double amount = entry.value['amount'].toDouble();

//   //       return FlSpot(timeInMinutes.toDouble(), amount);
//   //     }).toList();

//   //     return LineChart(
//   //       LineChartData(
//   //         gridData: const FlGridData(show: true),
//   //         titlesData: const FlTitlesData(show: true),
//   //         borderData: FlBorderData(show: true, border: Border.all()),
//   //         lineBarsData: [
//   //           LineChartBarData(
//   //             spots: spots,
//   //             isCurved: true,
//   //             color: Colors.purple,
//   //             barWidth: 4,
//   //             belowBarData: BarAreaData(show: true, color: Colors.purple.withOpacity(0.3)),
//   //           ),
//   //         ],
//   //         lineTouchData: const LineTouchData(enabled: false),
//   //       ),
//   //     );
//   //   } else if (selectedTab == "Week") {
//   //     return LineChart(
//   //       LineChartData(
//   //         lineBarsData: [
//   //           LineChartBarData(
//   //             spots: weeklyCurrentData,
//   //             isCurved: true,
//   //             color: Colors.blue,
//   //             barWidth: 4,
//   //           ),
//   //           LineChartBarData(
//   //             spots: weeklyPredictedData,
//   //             isCurved: true,
//   //             color: Colors.orange,
//   //             barWidth: 4,
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   } else {
//   //     return Container(); // Placeholder for Monthly data logic
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     final homeController = Provider.of<HomeController>(context);
//     return Scaffold(
//       body: Consumer<HomeController>(
//         builder: (context, controller, child){
//           if(controller.isLoading){
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: width,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment(0.00, -10.00),
//                       end: Alignment(0, 1),
//                       colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
//                     ),
//                   ),
//                   child: const Column(
//                     children: [
//                       SizedBox(height: 50),
//                       CustomText(text: 'Finacial Analysis', color: Color.fromRGBO(33, 35, 37, 1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w500),
//                     ]
//                   )
//                 )
//               ]
//             );
//           }
//           return Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
//                 begin: Alignment(0, -5),
//                 end: Alignment(0, 1),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: height*0.05,),
//                   const CustomText(text: 'Finacial Analysis', color: Color.fromRGBO(33, 35, 37, 1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w500),
//                   SizedBox(height: height*0.05,),
//                   Container(
//                     //height: 300,
//                     width: width,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const CustomText(text: 'Predictions', color: Colors.black, fontfamily: 'Inter', fontSize: 18,fontweigth: FontWeight.w500,),
//                          SizedBox(height: height*0.04),
//                         CustomText(text: 'Next Day : ₹${nextdaysum[0].toString()}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Next Week : ₹${nextweeksum.toString()}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Next Month : ₹${nextmonthsum.toString()}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     //height: 300,
//                     width: width,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const CustomText(text: 'Transaction Summary', color: Colors.black, fontfamily: 'Inter', fontSize: 18,fontweigth: FontWeight.w500,),
//                          SizedBox(height: height*0.04),
//                         CustomText(text: 'Total Saving : ₹${homeController.totalIncome-homeController.totalExpense}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Total Expense : ₹${homeController.totalExpense}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Total Income : ₹${homeController.totalIncome}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Average Today Spending: ₹${homeController.averageDailyExpense}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Average Weekly Spending : ₹${homeController.averageWeeklyExpense}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
//                         const SizedBox(height: 10,),
//                         CustomText(text: 'Average Monthly Spending : ₹${homeController.averageMonthlyExpense}',color: Colors.black, fontfamily: 'Poppins', fontSize: 14,fontweigth: FontWeight.w500,),
                      
//                       ],
//                     ),
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     tabButton("Today"),
//                   //     tabButton("Week"),
//                   //     tabButton("Month"),
//                   //   ],
//                   // ),
//                   const SizedBox(height: 16),
//                   // Container(
//                   //   padding: const EdgeInsets.all(16),
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.white,
//                   //     borderRadius: BorderRadius.circular(20),
//                   //     boxShadow: [
//                   //       BoxShadow(
//                   //         color: Colors.grey.withOpacity(0.2),
//                   //         spreadRadius: 2,
//                   //         blurRadius: 5,
//                   //       ),
//                   //     ],
//                   //   ),
//                   //   child: Column(
//                   //     children: [
//                   //       const Text(
//                   //         "Prediction on Money Spent:",
//                   //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   //       ),
//                   //       const SizedBox(height: 8),
//                   //       const Text(
//                   //         "Your predicted money spent for tomorrow is",
//                   //         style: TextStyle(fontSize: 14),
//                   //       ),
//                   //       const SizedBox(height: 8),
//                   //       // Text(
//                   //       //  // "₹${predictedExpense.toStringAsFixed(2)}",
//                   //       //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   //       // ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         },
//       )
//     );
//   }

//   // Widget tabButton(String title) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       setState(() {
//   //         selectedTab = title;
//   //       });
//   //     },
//   //     child: Container(
//   //       margin: const EdgeInsets.symmetric(horizontal: 8),
//   //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//   //       decoration: BoxDecoration(
//   //         color: selectedTab == title ? Colors.purple.shade100 : Colors.white,
//   //         borderRadius: BorderRadius.circular(20),
//   //         border: Border.all(color: Colors.purple),
//   //       ),
//   //       child: Text(
//   //         title,
//   //         style: TextStyle(
//   //           fontSize: 14,
//   //           fontWeight: FontWeight.bold,
//   //           color: selectedTab == title ? Colors.white : Colors.purple,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // // Convert time (e.g., '00:01') to a numerical value for the X-axis
//   // int _convertTimeToMinutes(String time) {
//   //   // Split the time into hours and minutes
//   //   List<String> timeParts = time.split(':');
//   //   int hours = int.parse(timeParts[0]);
//   //   int minutes = int.parse(timeParts[1]);

//   //   // Convert time to total minutes
//   //   return hours * 60 + minutes;
//   // }
// }
