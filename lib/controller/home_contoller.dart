import 'package:flutter/material.dart';

import '../services/expense_api.dart';
import '../services/summary_api.dart'; 

class HomeController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  final SummaryService _summaryService = SummaryService(); 

  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  int totalIncome = 0;
  int totalExpense = 0;
  int remainingBalance = 0;
  double averageDailyExpense = 0.0;
  double averageWeeklyExpense = 0.0;
  double averageMonthlyExpense = 0.0;
  String selectedTab = "Daily";

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

  Future<void> fetchSummaryData() async {
    isLoading = true;
    notifyListeners();

    try {
      print("CALLING SUM API");
      final summaryData = await _summaryService.fetchSummary();
      print(summaryData);
      print("API CALLED");
      
      totalIncome = summaryData['totalIncome'];
      totalExpense = summaryData['totalExpense'];
      remainingBalance = summaryData['remainingBalance'];
      averageDailyExpense = double.parse(summaryData['averageDailyExpense']);
      averageWeeklyExpense = double.parse(summaryData['averageWeeklyExpense']);
      averageMonthlyExpense = double.parse(summaryData['averageMonthlyExpense']);
    } catch (error) {
      print("Error fetching summary data: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  double getCurrentAverageExpense() {
    switch (selectedTab) {
      case "Weekly":
        return averageWeeklyExpense;
      case "Monthly":
        return averageMonthlyExpense;
      case "Daily":
      default:
        return averageDailyExpense;
    }
  }

  void updateSelectedTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }
}
