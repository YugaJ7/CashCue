import 'package:cashcue/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  final String apiUrl = "https://cash-cue.onrender.com/transaction/list";

  Future<void> fetchTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print("Fetching transactions...");
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        var allTransactions = List<Map<String, dynamic>>.from(decodedData['transactions'] ?? []);
            allTransactions = allTransactions.reversed.toList();
        setState(() {
          transactions = sortTransactions(allTransactions);
          isLoading = false;
        });
        print("Transactions: $transactions");
      } else {
        throw Exception("Failed to load transactions");
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Sorting transactions into the correct order
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

  // Convert date to readable format
  String formatDate(String? rawDate) {
    if (rawDate == null) return "Unknown Date";

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

  @override
  void initState() {
    super.initState();
    print("initState called");
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final DateTime today = DateTime.now();
    final DateFormat format2 = DateFormat('MMMM');
    String month = format2.format(today);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              //padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFB968E7)),
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
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : transactions.isEmpty
                          ? const Center(
                              child: CustomText(text: 'No transactions', color: Colors.black, fontfamily: 'Poppins', fontSize: 24,)
                            )
                          : Column(
                              children: transactions.map((transaction) {
                                final title = transaction['description'] ?? "No Title";
                                final date = transaction['date'] ?? "00-00-00";
                                final amount = transaction['amount']?.toString() ?? "0";
                                final isExpense = transaction['type'] == "Expense";

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (transactions.indexOf(transaction) == 0 ||
                                        formatDate(transactions[transactions.indexOf(transaction) - 1]['date']) !=
                                            formatDate(transaction['date']))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        child: CustomText(text: formatDate(date), color: Colors.black, fontfamily: 'Inter', fontSize: 18,fontweigth: FontWeight.w600,)
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                                      child: Card(
                                        elevation: 0,
                                        color: Color.fromRGBO(252, 252, 252, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TransactionItem(title: title, amount: (isExpense ? "- ₹" : "+ ₹") + amount, time: date.substring(date.length - 5), color: isExpense ? Colors.red : Colors.green),
                                        )
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
      ),
    );
  }
}
