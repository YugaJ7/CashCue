import 'package:flutter/material.dart';

import '../services/expense_api.dart';

class HomeController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();

  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  Future<void> loadExpenses() async {
    isLoading = true;
    notifyListeners();

    try {
      transactions = await _expenseService.fetchExpenses();
      transactions = transactions.reversed.toList();
    } catch (error) {
      print("Error fetching expenses: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
