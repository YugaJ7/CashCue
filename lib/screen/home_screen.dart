import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
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
                    const SizedBox(
                      height: 44,
                    ),
                    // Header with profile, month dropdown, and notification
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: width * .065,
                          backgroundColor: const Color(0xFFB968E7),
                          child: CircleAvatar(
                              radius: width * .06,
                              child: Image.asset('assets/images/avatar.png')),
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
            menuMaxHeight: height * 0.3,
            value: 'March',
            items: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
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
                            const Icon(Icons.notifications,
                                color: Colors.purple),
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
                          CustomText(
                            text: "Account Balance",
                            color: const Color.fromRGBO(145, 145, 159, 1),
                            fontfamily: 'Inter',
                            fontSize: width * .04,
                            fontweigth: FontWeight.w500,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: "₹9400",
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
                            width: width * 0.437,
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
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                    CustomText(
                                      text: 'Income',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.04,
                                      fontweigth: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: '\$8000',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.06,
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
                            width: width * 0.437,
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
                                      text: '\$7000',
                                      color: Colors.white,
                                      fontfamily: 'Poppins',
                                      fontSize: width * 0.06,
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
                    Container(
                      width: width,
                      height: height * 0.05,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Recent Transaction",
                            color: Color.fromRGBO(30, 18, 43, 1),
                            fontfamily: 'Poppins',
                            fontSize: 18,
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
                                    .map<Widget>((transaction) {
                                  return TransactionItem(
                                    title: transaction['description'],
                                    amount: "₹${transaction['amount']}",
                                    time: transaction['date'],
                                  );
                                }).toList(), 
                              ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
