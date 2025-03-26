// import 'package:cashcue/widgets/elevated_button.dart';
// import 'package:cashcue/widgets/text.dart';
// import 'package:cashcue/widgets/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AddGroupScreen extends StatefulWidget {
//   const AddGroupScreen({super.key});

//   @override
//   State<AddGroupScreen> createState() => _AddGroupScreenState();
// }

// class _AddGroupScreenState extends State<AddGroupScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final List<TextEditingController> _participantControllers = [TextEditingController()];

//   void _addParticipant() {
//     if (_participantControllers.length < 4) {
//       setState(() {
//         _participantControllers.add(TextEditingController());
//       });
//     }
//   }

//   void _removeParticipant(int index) {
//     if (_participantControllers.length > 1) {
//       setState(() {
//         _participantControllers.removeAt(index);
//       });
//     }
//   }

//   Future<void> _saveGroup() async {
//     final String title = _titleController.text;
//     final String description = _descriptionController.text;
//     final List<String> members = _participantControllers.map((controller) => controller.text).toList();
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');

//     if (title.isEmpty || description.isEmpty || members.any((member) => member.isEmpty)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields.')),
//       );
//       return;
//     }

//     final url = Uri.parse('https://cash-cue.onrender.com/groups/create');
//     final Map<String, dynamic> body = {
//       "title": title,
//       "description": description,
//       "members": members,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//         body: json.encode(body),
//       );
//       print('Group creation api Status: ${response.statusCode}');
//       print('Group body api Response: ${response.body}');
//       if (response.statusCode == 201) {
//       final responseData = json.decode(response.body);
//       final String newGroupId = responseData['group']['id']; 

//       List<String> groupIds = prefs.getStringList('groups') ?? [];
//       groupIds.add(newGroupId);
//       await prefs.setStringList('groups', groupIds);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Group saved successfully.')),
//         );
//         Navigator.of(context).pop(true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save group: ${response.body}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
//             begin: Alignment(0, -5),
//             end: Alignment(0, 1),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 45),
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
//                   SizedBox(width: width * 0.224),
//                   const CustomText(
//                     text: 'New Group',
//                     color: Color.fromRGBO(30, 18, 43, 1),
//                     fontfamily: 'Poppins',
//                     fontSize: 18,
//                     fontweigth: FontWeight.w500,
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(32),
//                     topRight: Radius.circular(32),
//                   ),
//                   color: Color.fromRGBO(244, 244, 244, 0.5),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 27, vertical: 25),
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         hintText: 'Title',
//                         hintSize: width * 0.04,
//                         hintColor: const Color(0xFF8391A1),
//                         fillColor: const Color(0xFFF7F8F9),
//                         textColor: const Color(0xFF8391A1),
//                         controller: _titleController,
//                         borderColor: const Color.fromRGBO(185, 104, 231, 0.5),
//                         borderRadius: 16,
//                       ),
//                       SizedBox(height: height * 0.04),
//                       CustomTextField(
//                         hintText: 'Description',
//                         hintSize: width * 0.04,
//                         hintColor: const Color(0xFF8391A1),
//                         fillColor: const Color(0xFFF7F8F9),
//                         textColor: const Color(0xFF8391A1),
//                         controller: _descriptionController,
//                         borderColor: const Color.fromRGBO(185, 104, 231, 0.5),
//                         borderRadius: 16,
//                       ),
//                       //SizedBox(height: height * 0.03),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: _participantControllers.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: EdgeInsets.only(bottom: height * 0.04),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: CustomTextField(
//                                       hintText: '${index + 1} Member',
//                                       hintSize: width * 0.04,
//                                       hintColor: const Color(0xFF8391A1),
//                                       fillColor: const Color(0xFFF7F8F9),
//                                       textColor: const Color(0xFF8391A1),
//                                       controller:
//                                           _participantControllers[index],
//                                       borderColor: const Color.fromRGBO(
//                                           185, 104, 231, 0.5),
//                                       borderRadius: 16,
//                                     ),
//                                   ),
//                                   if (_participantControllers.length > 1)
//                                     IconButton(
//                                       icon: const Icon(Icons.remove_circle,
//                                           color: Colors.red),
//                                       onPressed: () =>
//                                           _removeParticipant(index),
//                                     ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       if (_participantControllers.length < 4)
//                         SizedBox(
//                           width: width,
//                           height: height * 0.06,
//                           child: CustomElevatedButton(
//                             text: 'Add more participants',
//                             onPressed: _addParticipant,
//                             backgroundcolor: const Color(0xFFF7F8F9),
//                             textcolor: const Color(0xFF8391A1),
//                             bordercolor:
//                                 const Color.fromRGBO(185, 104, 231, 0.5),
//                           ),
//                         ),
//                       SizedBox(
//                         height: height * 0.04,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Container(
//                               width: 164,
//                               height: 56,
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   color: const Color.fromRGBO(182, 76, 242, 1)
//                                 ),
//                                 borderRadius: const BorderRadius.all(Radius.circular(16))
//                               ),
//                               child: const Center(
//                                   child: CustomText(
//                                 text: 'Cancel',
//                                 color: Color.fromRGBO(30, 18, 43, 1),
//                                 fontfamily: 'Urbanist',
//                                 fontSize: 18,
//                                 fontweigth: FontWeight.w600,
//                               )),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: _saveGroup,
//                             child: Container(
//                               width: 164,
//                               height: 56,
//                               padding: const EdgeInsets.all(8),
//                               decoration: ShapeDecoration(
//                                 color: const Color.fromRGBO(182, 76, 242, 1),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               child: const Center(
//                                   child: CustomText(
//                                 text: 'Save',
//                                 color: Colors.white,
//                                 fontfamily: 'Urbanist',
//                                 fontSize: 18,
//                                 fontweigth: FontWeight.w600,
//                               )),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
