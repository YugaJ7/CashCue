import 'package:cashcue/controller/home_contoller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../widgets/text.dart';
import '../widgets/transaction_list.dart'; 

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final DateTime today = DateTime.now();
    final DateFormat format2 = DateFormat('MMMM');
    String month = format2.format(today);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.transactions.isEmpty) {
            return const Center(
                child: CustomText(
              text: 'No transactions',
              color: Colors.black,
              fontfamily: 'Poppins',
              fontSize: 24,
            ));
          }
          List<Map<String, dynamic>> sortedTransactions = sortTransactions(controller.transactions);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -10.00),
                      end: Alignment(0, .5),
                      colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFB968E7)),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: CustomText(
                          text: month,
                          color: Colors.black,
                          fontfamily: 'Poppins',
                          fontSize: 14,
                          fontweigth: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Column(
                        children: sortedTransactions.map((transaction) {
                          final title = transaction['description'] ?? "No Title";
                          final date = transaction['date'] ?? "00-00-00";
                          final amount = transaction['amount']?.toString() ?? "0";
                          final isExpense = transaction['type'] == "Expense";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (sortedTransactions.indexOf(transaction) == 0 ||
                                  formatDate(sortedTransactions[sortedTransactions.indexOf(transaction) - 1]['date']) !=
                                      formatDate(transaction['date']))
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: CustomText(
                                    text: formatDate(date),
                                    color: Colors.black,
                                    fontfamily: 'Inter',
                                    fontSize: 18,
                                    fontweigth: FontWeight.w600,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 4.0),
                                child: Card(
                                  elevation: 0,
                                  color: const Color.fromRGBO(252, 252, 252, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TransactionItem(
                                      title: title,
                                      amount: (isExpense ? "- ₹" : "+ ₹") + amount,
                                      time: date.substring(date.length - 5),
                                      color: isExpense ? Colors.red : Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String formatDate(String rawDate) {
    try {
      DateTime parsedDate = DateFormat("yy-MM-dd").parse(rawDate);

      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(const Duration(days: 1));

      if (parsedDate == today) {
        return "Today";
      } else if (parsedDate == yesterday) {
        return "Yesterday";
      } else {
        return DateFormat("dd-MM-yyyy").format(parsedDate);
      }
    } catch (e) {
      print("Date parsing error: $e");
      return "Invalid Date";
    }
  }

  List<Map<String, dynamic>> sortTransactions(List<Map<String, dynamic>> list) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    List<Map<String, dynamic>> todayTransactions = [];
    List<Map<String, dynamic>> yesterdayTransactions = [];
    List<Map<String, dynamic>> otherTransactions = [];

    for (var transaction in list) {
      if (transaction['date'] != null) {
        DateTime parsedDate = DateFormat("yy-MM-dd").parse(transaction['date']);
        if (parsedDate.year == today.year &&
            parsedDate.month == today.month &&
            parsedDate.day == today.day) {
          todayTransactions.add(transaction);
        } else if (parsedDate.year == yesterday.year &&
            parsedDate.month == yesterday.month &&
            parsedDate.day == yesterday.day) {
          yesterdayTransactions.add(transaction);
        } else {
          otherTransactions.add(transaction);
        }
      }
    }

    todayTransactions.sort((a, b) =>
        DateFormat("yy-MM-dd").parse(b['date']).compareTo(DateFormat("yy-MM-dd").parse(a['date'])));
    yesterdayTransactions.sort((a, b) =>
        DateFormat("yy-MM-dd").parse(b['date']).compareTo(DateFormat("yy-MM-dd").parse(a['date'])));
    otherTransactions.sort((a, b) =>
        DateFormat("yy-MM-dd").parse(b['date']).compareTo(DateFormat("yy-MM-dd").parse(a['date'])));

    return [...todayTransactions, ...yesterdayTransactions, ...otherTransactions];
  }
}
