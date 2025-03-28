// import 'package:cashcue/widgets/text.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class GroupDetail extends StatefulWidget {
//   const GroupDetail({super.key});

//   @override
//   State<GroupDetail> createState() => _GroupDetailState();
// }

// class _GroupDetailState extends State<GroupDetail> {
//   List<Map<String, dynamic>> groups = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchGroupData();
//   }

//   Future<void> _fetchGroupData() async {
//     try {
//       List<Map<String, dynamic>> fetchedGroups = [];
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       final groupIds = prefs.getStringList('groups') ?? [];

//       for (String groupId in groupIds) {
//         final url =
//             Uri.parse('https://cash-cue.onrender.com/groups/group/$groupId');
//         final response = await http.get(
//           url,
//           headers: {
//             "Authorization": "Bearer $token",
//             "Content-Type": "application/json",
//           },
//         );
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           fetchedGroups.add(data['group']);
//         } else {
//           print('Failed to fetch group $groupId: ${response.body}');
//         }
//       }
//       setState(() {
//         groups = fetchedGroups;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching groups: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     final group = groups[0];
//     final title = group['title'];
//     final transactions = group['transactions'] ?? [];
//     final members = group['members'] ?? [];
//     final description = group['description'] ?? [];
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         body: Container(
//           width: width,
//           height: height,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
//               begin: Alignment(0, -5),
//               end: Alignment(0, 1),
//             ),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 45),
//               CustomText(text: title, color: const Color.fromRGBO(30, 18, 43, 1), fontfamily: 'Poppins', fontSize: 18, fontweigth: FontWeight.w500),
//               const SizedBox(height: 20),
//               _buildCustomTabBar(),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     _buildExpensesTab(transactions),
//                     _buildInfoTab(members),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: const FloatingActionButton(
//           onPressed: null, 
//           backgroundColor: Colors.purple,
//           child: Icon(Icons.add, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildCustomTabBar() {
//     return TabBar(
//       indicator: BoxDecoration(
//         color: const Color.fromRGBO(182, 76, 242, 1),
//         borderRadius: BorderRadius.circular(28),
//       ),
//       labelColor: Colors.white,
//       unselectedLabelColor: Colors.black,
//       labelStyle: const TextStyle(
//         fontFamily: 'Poppins',
//         fontWeight: FontWeight.w500,
//         fontSize: 14,
//       ),
//       unselectedLabelStyle: const TextStyle(
//         fontFamily: 'Poppins',
//         fontWeight: FontWeight.w400,
//         fontSize: 14,
//       ),
      
//       tabs: [
//         Tab(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: const Text('Expenses'),
//           ),
//         ),
//         Tab(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: const Text('Info'),
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget for the Expenses tab
//   Widget _buildExpensesTab(List transactions) {
//     return transactions.isEmpty
//         ? const Center(child: Text('No transactions found.'))
//         : ListView.builder(
//             itemCount: transactions.length,
//             itemBuilder: (context, index) {
//               final transaction = transactions[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: ListTile(
//                   title: Text(
//                     transaction['description'] ?? 'No description',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   subtitle: Text(transaction['time'] ?? 'No time provided'),
//                   trailing: Text(
//                     "₹${transaction['amount'] ?? '0'}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//   }
//   // Widget for the Info tab
//   Widget _buildInfoTab(List members) {
//     return members.isEmpty
//         ? const Center(child: Text('No members found.'))
//         : ListView.builder(
//             itemCount: members.length,
//             itemBuilder: (context, index) {
//               final member = members[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.purple,
//                     child: Text(
//                       member['name']?.substring(0, 1).toUpperCase() ?? '?',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   title: Text(
//                     member['name'] ?? 'No name',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   subtitle: Text(member['email'] ?? 'No email provided'),
//                 ),
//               );
//             },
//           );
//   }
// }
