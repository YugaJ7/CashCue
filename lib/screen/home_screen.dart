import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/home_contoller.dart';
import '../widgets/home_graph.dart';
import '../widgets/text.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bool isLoading = true;

  @override
  void initState() {
  super.initState();
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    
    print("Calling fetchSummaryData");
    homeController.loadExpenses();
    homeController.fetchSummaryData();
    print("Called fetchSummaryData");
  });
}


  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final DateTime today = DateTime.now();      
    final DateFormat format2 = DateFormat('MMMM');
    String month = format2.format(today);
    print(month);
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
                    // Header with profile, month
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){Navigator.pushNamed(context, '/profile');},
                          child: CircleAvatar(
                            radius: width * .065,
                            backgroundColor: const Color(0xFFB968E7),
                            child: CircleAvatar(
                                radius: width * .06,
                                child: Image.asset('assets/images/avatar.png')),
                          ),
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
                        const SizedBox(width: 45,)
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Account Balance
                    Center(
                      child: Column(
                        children: [
                          CustomText(
                            text: "Account Balance",
                            color: const Color.fromRGBO(145, 145, 159, 1),
                            fontfamily: 'Inter',
                            fontSize: width * .04,
                            fontweigth: FontWeight.w500,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: "₹${homeController.remainingBalance}",
                            color: Colors.black,
                            fontfamily: 'Inter',
                            fontSize: width * .1,
                            fontweigth: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    // Income and Expense cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: width * 0.5,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(185, 104, 231, 1),
                              borderRadius: BorderRadius.circular(width * 0.1),
                            ),
                            padding: EdgeInsets.all(width * .04),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/in.png',
                                  width: width * 0.128,
                                  height: width * 0.128,
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Income',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.04,
                                      fontweigth: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: '₹${homeController.totalIncome}',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.05,
                                      fontweigth: FontWeight.w600,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            width: width * 0.5,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(128, 127, 128, 1),
                              borderRadius: BorderRadius.circular(width * 0.1),
                            ),
                            padding: EdgeInsets.all(width * .04),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/out.png',
                                  width: width * 0.128,
                                  height: width * 0.128,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                    CustomText(
                                      text: 'Expense',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.04,
                                      fontweigth: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: '₹${homeController.totalExpense}',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.05,
                                      fontweigth: FontWeight.w600,
                                    )
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
                    const AverageMoneySpentGraph(),
                    const SizedBox(height: 8),
                    // Recent Transactions
                    SizedBox(
                      width: width,
                      height: height * 0.05,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Recent Transaction",
                            color: Color.fromRGBO(30, 18, 43, 1),
                            fontfamily: 'Poppins',
                            fontSize: 19,
                            fontweigth: FontWeight.w600,
                          ),
                          // TextButton(
                          //   onPressed: () {}, 
                          //   child: CustomText(text: "See All", color: Color.fromRGBO(112, 65, 163, 1), fontfamily: fontfamily)
                          // )
                        ],
                      ),
                    ),
                    homeController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : homeController.transactions.isEmpty
                  ? const Center(
                      child: Text(
                        "No Recent Transactions",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Column(
                      children: homeController.transactions
                          .take(5)
                          .map<Widget>((transaction) {
                        final String type = transaction['type'];
                        final String sign = type == 'Income' ? '+' : '-';
                        final Color color = type == 'Income'
                            ? Colors.green
                            : Colors.red;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TransactionItem(
                            title: transaction['description'],
                            amount: "$sign ₹${transaction['amount']}",
                            time: transaction['date'],
                            color: color,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ),
          ],
        ),
      ),
    );
  }
}
