import 'package:cashcue/screen/add_group_screen.dart';
import 'package:cashcue/widgets/elevated_button.dart';
import 'package:cashcue/widgets/groupdetail.dart';
import 'package:cashcue/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<String> _groupIds = [];
  List<Map<String, dynamic>> _groups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print('loadgroupids called');
    _loadGroupIds();
  }

  Future<void> _loadGroupIds() async {
    final prefs = await SharedPreferences.getInstance();
    final groupIds = prefs.getStringList('groups') ?? [];
    print(groupIds);
    setState(() {
      _groupIds = groupIds;
    });
    print(_groupIds.isEmpty);
    if (_groupIds.isEmpty) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> _fetchGroupData() async {
  //   try {
  //     List<Map<String, dynamic>> fetchedGroups = [];
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('authToken');

  //     for (String groupId in _groupIds) {
  //       final url =
  //           Uri.parse('https://cash-cue.onrender.com/groups/group/${groupId}');
  //       print(url);
  //       final response = await http.get(
  //         url,
  //         headers: {
  //           "Authorization": "Bearer $token",
  //           "Content-Type": "application/json",
  //         },
  //       );
  //       print(response.statusCode);
  //       print(response.body);
  //       if (response.statusCode == 200) {
  //         final data = json.decode(response.body);
  //         fetchedGroups.add(data['group']);
  //       } else {
  //         print('Failed to fetch group $groupId: ${response.body}');
  //       }
  //     }
  //     setState(() {
  //       _groups = fetchedGroups;
  //       print('fetched groups = ${_groups}');
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching groups: $e');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
            begin: Alignment(0, -5),
            end: Alignment(0, 1),
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _groupIds.isEmpty
                ? Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(185, 104, 231, 0.5),
                          Colors.white
                        ],
                        begin: Alignment(0, -5),
                        end: Alignment(0, 1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 45),
                          const CustomText(
                              text: 'Groups',
                              color: Color.fromRGBO(30, 18, 43, 1),
                              fontfamily: 'Poppins',
                              fontSize: 18,
                              fontweigth: FontWeight.w500),
                          SizedBox(height: height*.3,),
                          const CustomText(
                              text: 'Empty',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontfamily: 'Poppins',
                              fontSize: 18,
                              fontweigth: FontWeight.w600),
                          SizedBox(height: 8,),
                          const CustomText(
                              text: 'You haven\'t created a group yet',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontfamily: 'Poppins',
                              fontSize: 18,
                              fontweigth: FontWeight.w200),
                          SizedBox(height: 48,),
                          SizedBox(
                            width: width,
                            height: height*0.06,
                            child: CustomElevatedButton(
                              text: 'Create a new group', 
                              onPressed: (){
                                final result = Navigator.pushNamed(context, '/add_group');
                                if (result== true) {
                                    print("After true loadgroupids");
                                    _loadGroupIds(); // Refresh group IDs after adding a group.
                                    print("After true loadgroupids............done");
                                  }
                                }, 
                              backgroundcolor: Color.fromRGBO(182, 76, 242, 1), 
                              textcolor: Colors.white),
                          )
                        ],
                      ),
                    ))
                : GroupDetail()
      ),
    );
  }
}
