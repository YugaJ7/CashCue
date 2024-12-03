import 'package:flutter/material.dart';

import '../widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
print(height);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, -10.00),
                  end: Alignment(0, 1),
                  colors: [Color.fromRGBO(185, 104, 231, 0.5), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 44,),
                  // Header with profile, month dropdown, and notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: width*.065,
                        backgroundColor: Color(0xFFB968E7),
                        child:  CircleAvatar(radius: width*.06,child: Image.asset('assets/images/avatar.png')),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFB968E7)),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: DropdownButton<String>(
                          menuMaxHeight: height*0.3,
                          value: 'March',
                          items: ['January', 'February', 'March', 'April','May','June','July','August','September','October','November','December']
                              .map((month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                          underline: const SizedBox(),
                        ),
                      ),
                      Stack(
                        children: [
                          const Icon(Icons.notifications, color: Colors.purple),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Account Balance
                  Center(
                    child: Column(
                      children: [
                        CustomText(text: "Account Balance", color: const Color.fromRGBO(145, 145, 159, 1), fontfamily: 'Inter',fontSize: width*.04,fontweigth: FontWeight.w500,),
                        const SizedBox(height: 4),
                        CustomText(text: "₹9400", color: Colors.black, fontfamily: 'Inter',fontSize: width*.1,fontweigth: FontWeight.w600,),
                      ],
                    ),
                  ),
                  // Income and Expense cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: width*0.437,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(185, 104, 231, 1),
                            borderRadius: BorderRadius.circular(width*0.1),
                          ),
                          padding: EdgeInsets.all(width*.04),
                          child: Row(
                            children: [
                              Image.asset('assets/images/in.png',width: width*0.128,height: width*0.128,),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  CustomText(text: 'Income', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.04,fontweigth: FontWeight.w500,),
                                  CustomText(text: '\$8000', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.06,fontweigth: FontWeight.w600,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          width: width*0.437,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(128, 127, 128, 1),
                            borderRadius: BorderRadius.circular(width*0.1),
                          ),
                          padding: EdgeInsets.all(width*.04),
                          child: Row(
                            children: [
                              Image.asset('assets/images/out.png',width: width*0.128,height: width*0.128,),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  CustomText(text: 'Expense', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.04,fontweigth: FontWeight.w500,),
                                  CustomText(text: '\$7000', color: Colors.white, fontfamily: 'Poppins', fontSize: width*0.06,fontweigth: FontWeight.w600,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Average Money Spent graph
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Average money spent", color: Color.fromRGBO(146, 145, 165, 1), fontfamily: 'Poppins',fontSize: width*.045,fontweigth: FontWeight.w600,),
                            DropdownButton<String>(
                              value: 'Weekly',
                              items: ['Daily', 'Weekly', 'Monthly']
                                  .map((filter) => DropdownMenuItem(
                                        value: filter,
                                        child: Text(filter),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                              underline: const SizedBox(),
                            ),
                          ],
                        ),
                        CustomText(text: '\$1000', color: Colors.black, fontfamily: 'Poppins',fontSize: width*0.05,fontweigth: FontWeight.w600,),
                        const SizedBox(height: 16),
                        // Placeholder for graph
                        Container(
                          height: 100,
                          child: const Center(
                            child: Text("Graph Placeholder"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTabButton("Today", 0),
                      _buildTabButton("Week", 1),
                      _buildTabButton("Month", 2),
                    ],
                  ),
            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Transaction",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("See All"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                transactionItem("Food", "Buy a ramen", "₹32", "07:30 PM"),
                transactionItem(
                    "Shopping", "Buy some grocery", "₹120", "10:00 AM"),
                transactionItem("Subscription", "Disney+ Annual", "₹80",
                    "03:30 PM"),
              ],
            ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionItem(String title, String subtitle, String amount,
      String time) {
    return ListTile(
      leading: const Icon(Icons.fastfood, color: Colors.purple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "- $amount",
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE9C1FF) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Color(0xFF7041A3) : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}



