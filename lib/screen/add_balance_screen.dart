import 'package:cashcue/controller/home_contoller.dart';
import 'package:cashcue/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/text.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({Key? key}) : super(key: key);

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  
  final String apiUrl = "https://cash-cue-web.onrender.com/settings/balance";

  Future<void> _storeData() async {
    final int? amount = int.tryParse(_amountController.text.trim());
    
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the amount")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print(token);

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found, Sign In again")),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          'accountBalance': amount,
          }
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final homeController =
            Provider.of<HomeController>(context, listen: false);
        homeController.loadExpenses();
        homeController.fetchSummaryData();
        _showAlertDialog("Success", "Account Balance has been successfully added");
        _amountController.clear();
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to add account balance: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add account balance:$e")),
      );
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const ImageIcon(
          AssetImage('assets/images/tick.png'),
          color: Color.fromRGBO(163, 60, 235, 1),
          size: 48,
        ),
        content: CustomText(
          text: message,
          color: Colors.black,
          fontfamily: 'Inter',
          fontSize: 14,
          fontweigth: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
            begin: Alignment(0, -5),
            end: Alignment(0, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
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
                  CustomText(
                    text: 'Account',
                    color: Color.fromRGBO(33, 35, 37, 1),
                    fontfamily: 'Poppins',
                    fontSize: 18,
                    fontweigth: FontWeight.w600,
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: CustomText(
                  text: 'Account Balance',
                  color: Color.fromRGBO(145, 145, 159, 1),
                  fontfamily: 'Poppins',
                  fontSize: 14,
                  fontweigth: FontWeight.w500,
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .06,
                child: CustomElevatedButton(
                  text: 'Add Balance',
                  onPressed: _storeData,
                  backgroundcolor: const Color.fromRGBO(182, 76, 242, 1),
                  textcolor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
