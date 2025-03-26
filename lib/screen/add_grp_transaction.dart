// import 'package:cashcue/widgets/date_time.dart';
// import 'package:cashcue/widgets/elevated_button.dart';
// import 'package:cashcue/widgets/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:board_datetime_picker/board_datetime_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; 
// import '../widgets/text.dart';

// class AddGroupTransactionScreen extends StatefulWidget {
//   const AddGroupTransactionScreen({super.key});

//   @override
//   State<AddGroupTransactionScreen> createState() => _AddGroupTransactionScreenState();
// }

// class _AddGroupTransactionScreenState extends State<AddGroupTransactionScreen> {
//   bool isExpense = true;
//   String selectedDateTime = "";
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   final String apiUrl = " https://cash-cue.onrender.com/groups/add-expense";

//   Future<void> _storeData() async {
//   final double? amount = double.tryParse(_amountController.text.trim());
//   final String description = _descriptionController.text.trim();
//   final String date = selectedDateTime;

//   if (amount == null || description.isEmpty || date.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Please fill in all fields")),
//     );
//     return;
//   }

//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authToken');
//   final groupIds = prefs.getStringList('groups') ?? [];

//   if (token == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Token not found, Sign In again")),
//     );
//     return;
//   }

//   if (groupIds.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("No groups found. Please create a group first.")),
//     );
//     return;
//   }

//   final String groupId = groupIds.first; // Select the first group ID (modify as needed)

//   final Map<String, dynamic> data = {
//     "groupId": groupId, // Add groupId to the request
//     "description": description,
//     "amount": amount,
//     "date": date,
//   };

//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//       body: json.encode(data),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       _showAlertDialog("Success", "Transaction has been successfully added");
//       _amountController.clear();
//       _descriptionController.clear();
//       setState(() {
//         selectedDateTime = "";
//       });

//       Future.delayed(const Duration(seconds: 1), () {
//         Navigator.pop(context); 
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to add transaction: ${response.body}")),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Failed to add transaction: $e")),
//     );
//   }
// }


// void _showAlertDialog(String title, String message) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       icon: const ImageIcon(AssetImage('assets/images/tick.png'),color: Color.fromRGBO(163, 60, 235, 1),size: 48,),
//       content: CustomText(text: message, color: Colors.black, fontfamily: 'Inter', fontSize: 14, fontweigth: FontWeight.w500,),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       backgroundColor: Colors.white,
//       shadowColor: Colors.black,
      
//     ),
//   );

//   Future.delayed(const Duration(seconds: 1), () {
//     Navigator.pop(context); 
//   });
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
//             begin: Alignment(0, -5),
//             end: Alignment(0, 1),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: Color.fromRGBO(177, 77, 255, 1),
//                       size: 30,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Center(
//               child: CustomText(
//                 text: 'How much?',
//                 color: Color.fromRGBO(30, 18, 43, 1),
//                 fontfamily: 'Poppins',
//                 fontSize: 18,
//                 fontweigth: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Center(
//               child: TextField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 style: const TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                   hintText: "₹",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(32),
//                   topRight: Radius.circular(32),
//                 ),
//                 color: Color.fromRGBO(244, 244, 244, 0.5),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
//                 child: Column(
//                   children: [
//                     CustomTextField(
//                       controller: _descriptionController,
//                       hintText: 'Description',
//                       hintSize: 16,
//                       hintColor: const Color.fromRGBO(143, 142, 148, 1),
//                       fillColor: Colors.transparent,
//                       borderRadius: 16,
//                       borderColor:
//                           const Color.fromRGBO(185, 104, 231, 0.5),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: const Color.fromRGBO(185, 104, 231, 0.5),
//                         ),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(16)),
//                       ),
//                       child: PickerItemWidget(
//                         pickerType: DateTimePickerType.datetime,
//                         onDateTimeChanged: (dateTime) {
//                           setState(() {
//                             selectedDateTime = dateTime.toIso8601String();
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * .06,
//                       child: CustomElevatedButton(
//                         text: 'Continue',
//                         onPressed: _storeData,
//                         backgroundcolor:
//                             const Color.fromRGBO(182, 76, 242, 1),
//                         textcolor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
