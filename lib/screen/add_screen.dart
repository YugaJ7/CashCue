import 'package:cashcue/controller/home_contoller.dart';
import 'package:cashcue/widgets/date_time.dart';
import 'package:cashcue/widgets/elevated_button.dart';
import 'package:cashcue/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 
import '../widgets/text.dart';

class ExpenseIncomeScreen extends StatefulWidget {
  const ExpenseIncomeScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseIncomeScreen> createState() => _ExpenseIncomeScreenState();
}

class _ExpenseIncomeScreenState extends State<ExpenseIncomeScreen> {
  bool isExpense = true;
  String selectedDateTime = "";
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final String apiUrl = "https://cash-cue.onrender.com/expense/add"; 

  Future<void> _storeData() async {
  final double? amount = double.tryParse(_amountController.text.trim());
  final String description = _descriptionController.text.trim();
  final String date = selectedDateTime;

  if (amount == null || description.isEmpty || date.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill in all fields")),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  print(token);

  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Authentication token not found")),
    );
    return;
  }

  final Map<String, dynamic> data = {
    "amount": amount,
    "description": description,
    "date": date,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final homeController = Provider.of<HomeController>(context, listen: false);
      homeController.loadExpenses();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storing successfully")),
      );
      _amountController.clear();
      _descriptionController.clear();
      setState(() {
        selectedDateTime = "";
      });
      Future.delayed(Duration.zero, () {
        Navigator.pop(context); 
      }
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to store data: ${response.body}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
            begin: Alignment(0, -5),
            end: Alignment(0, 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(177, 77, 255, 1),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 40),
                  ToggleButtons(
                    isSelected: [isExpense, !isExpense],
                    onPressed: (index) {
                      setState(() {
                        isExpense = index == 0;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    selectedColor: Colors.white,
                    fillColor: const Color.fromRGBO(182, 76, 242, 1),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomText(
                          text: 'Expense',
                          color: Colors.white,
                          fontfamily: 'Urbanist',
                          fontSize: 16,
                          fontweigth: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Income'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: CustomText(
                text: 'How much?',
                color: Color.fromRGBO(30, 18, 43, 1),
                fontfamily: 'Poppins',
                fontSize: 18,
                fontweigth: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "₹",
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                color: Color.fromRGBO(244, 244, 244, 0.5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _descriptionController,
                      hintText: 'Description',
                      hintSize: 16,
                      hintColor: const Color.fromRGBO(143, 142, 148, 1),
                      fillColor: Colors.transparent,
                      borderRadius: 16,
                      borderColor:const Color.fromRGBO(185, 104, 231, 0.5),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(185, 104, 231, 0.5),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      child: PickerItemWidget(
                        pickerType: DateTimePickerType.datetime,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            selectedDateTime = dateTime.toIso8601String();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .06,
                      child: CustomElevatedButton(
                        text: 'Continue',
                        onPressed: _storeData,
                        backgroundcolor:
                            const Color.fromRGBO(182, 76, 242, 1),
                        textcolor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
