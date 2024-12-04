import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cashcue/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> transactions = []; 
  bool isLoading = true; 
  final String apiUrl = "https://cash-cue.onrender.com/expense/list"; 

  @override
  void initState() {
    super.initState();
    fetchExpenses(); 
  }

  Future<void> fetchExpenses() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  print(token); 
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $token", // Passing the token
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      // Ensure the response contains 'expenses' key
      if (decodedData is Map<String, dynamic> && decodedData['expenses'] != null) {
        setState(() {
          transactions = List<Map<String, dynamic>>.from(decodedData['expenses']);
          print(transactions);
          isLoading = false; // Stop the loading spinner
        });
      } else {
        throw Exception('Unexpected response format: Missing "expenses" key');
      }
    } else {
      throw Exception('Failed to load expenses. Status code: ${response.statusCode}');
    }
  } catch (error) {
    setState(() {
      isLoading = false; // Stop spinner even on error
    });
    print("Error fetching expenses: $error");
  }
}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, -10.00),
                  end: Alignment(0, .5),
                  colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 44,),
                  // Header with profile, month dropdown, and notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: width*.065,
                        backgroundColor: const Color(0xFFB968E7),
                        child:  CircleAvatar(radius: width*.06,child: Image.asset('assets/images/avatar.png')),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFB968E7)),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: DropdownButton<String>(
                          menuMaxHeight: height*0.3,
                          value: 'March',
                          items: ['January', 'February', 'March', 'April','May','June','July','August','September','October','November','December']
                              .map((month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                          underline: const SizedBox(),
                        ),
                      ),
                      Stack(
                        children: [
                          const Icon(Icons.notifications, color: Colors.purple),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Account Balance
                  Center(
                    child: Column(
                      children: [
                        CustomText(text: "Account Balance", color: const Color.fromRGBO(145, 145, 159, 1), fontfamily: 'Inter',fontSize: width*.04,fontweigth: FontWeight.w500,),
                        const SizedBox(height: 4),
                        CustomText(text: "₹9400", color: Colors.black, fontfamily: 'Inter',fontSize: width*.1,fontweigth: FontWeight.w600,),
                      ],
                    ),
                  ),
                  // Income and Expense cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: width*0.437,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(185, 104, 231, 1),
                            borderRadius: BorderRadius.circular(width*0.1),
                          ),
                          padding: EdgeInsets.all(width*.04),
                          child: Row(
                            children: [
                              Image.asset('assets/images/in.png',width: width*0.128,height: width*0.128,),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  CustomText(text: 'Income', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.04,fontweigth: FontWeight.w500,),
                                  CustomText(text: '\$8000', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.06,fontweigth: FontWeight.w600,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          width: width*0.437,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(128, 127, 128, 1),
                            borderRadius: BorderRadius.circular(width*0.1),
                          ),
                          padding: EdgeInsets.all(width*.04),
                          child: Row(
                            children: [
                              Image.asset('assets/images/out.png',width: width*0.128,height: width*0.128,),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  CustomText(text: 'Expense', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.04,fontweigth: FontWeight.w500,),
                                  CustomText(text: '\$7000', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.06,fontweigth: FontWeight.w600,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Average Money Spent graph
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Average money spent", color: const Color.fromRGBO(146, 145, 165, 1), fontfamily: 'Poppins',fontSize: width*.045,fontweigth: FontWeight.w600,),
                        CustomText(text: '\$1000', color: Colors.black, fontfamily: 'Poppins',fontSize: width*0.05,fontweigth: FontWeight.w600,),
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
                      _buildTabButton("Today", 0),
                      _buildTabButton("Week", 1),
                      _buildTabButton("Month", 2),
                    ],
             ),
             SizedBox(height: 8),
            // Recent Transactions
            Container(
              width: width,
              height: height*0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(text: "Recent Transaction", color:  Color.fromRGBO(30, 18, 43, 1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w600,),
                  CustomElevatedButton(text: "See All", onPressed: (){}, backgroundcolor: const Color(0xFFE9C1FF), textcolor: Color.fromRGBO(112, 65, 163, 1), bordercolor: Colors.transparent,)
                ],
              ),
            ),
            transactions.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Transactions Found",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : Column(
                                children: transactions
                                    .map((transaction) => transactionItem(
                                          transaction['description'],
                                          "₹${transaction['amount']}",
                                          transaction['date'],
                                        ))
                                    .toList(),
                              ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionItem(String? title, String? amount, String? time) {
  return Padding(
    padding: const EdgeInsets.all( 8.0),
    child: Column(
      children: [
        Row(
          children: [
            CustomText(text: title ?? 'No Title', color: Color.fromRGBO(41, 43, 45, 1), fontfamily: 'Poppins', fontSize: 16, fontweigth: FontWeight.w500,),
            Spacer(),
            CustomText(text: "- ${amount ?? '₹0'}", color: Colors.red, fontfamily: 'Poppins', fontSize: 14, fontweigth: FontWeight.w600,),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CustomText(text: time ?? 'No Time', color: Color.fromRGBO(145, 145, 159, 1), fontfamily: 'Poppins', fontSize: 12, fontweigth: FontWeight.w500,)),
      ],
    ),
  );
}
  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9C1FF) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF7041A3) : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}



