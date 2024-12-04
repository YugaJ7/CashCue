// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late PersistentTabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }

//   List<Widget> _buildScreens() {
//     return [
//       Center(child: Text("Home Screen")),
//       Center(child: Text("Swap Screen")),
//       //Center(child: Text("Add Screen")),
//       Center(child: Text("Analytics Screen")),
//       Center(child: Text("Group Screen")),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.home),
//         title: "Home",
//         activeColorPrimary: Colors.purple,
//         activeColorSecondary: Colors.white,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.swap_horizontal_circle_outlined),
//         title: "Swap",
//         activeColorPrimary: Colors.purple,
//         activeColorSecondary: Colors.white,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       // PersistentBottomNavBarItem(
//       //   icon: const Icon(Icons.add),
//       //   title: "Add",
//       //   activeColorPrimary: Colors.purple,
//       //   activeColorSecondary: Colors.white,
//       //   inactiveColorPrimary: Colors.grey,
//       // ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.analytics),
//         title: "Analytics",
//         activeColorPrimary: Colors.purple,
//         activeColorSecondary: Colors.white,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.group),
//         title: "Group",
//         activeColorPrimary: Colors.purple,
//         activeColorSecondary: Colors.white,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         confineToSafeArea: true,
//         backgroundColor: Colors.white, // Navbar background color
//         navBarStyle: NavBarStyle.style15, // Style that supports customizations
//         hideNavigationBarWhenKeyboardAppears: true,
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(20),
//           colorBehindNavBar: Colors.transparent,
//         ),
//         // itemAnimationProperties: const ItemAnimationProperties(
//         //   duration: Duration(milliseconds: 200),
//         //   curve: Curves.easeInOut,
//         // ),
//         animationSettings: const NavBarAnimationSettings(
//           navBarItemAnimation: ItemAnimationSettings(
//             duration: Duration(milliseconds: 200),
//             curve: Curves.easeInOut,
//           )
//         ),
//         navBarHeight: 60,
//       ),
//     );
//   }
// }

import 'package:cashcue/screen/add_screen.dart';
import 'package:cashcue/screen/transaction_screen.dart';
import 'package:flutter/material.dart';

import '../screen/home_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          TransactionScreen(),
          SizedBox.shrink(), // Placeholder for the Add screen
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          if (index == 2) {
            // Push ExpenseIncomeScreen without replacing
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExpenseIncomeScreen()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/transaction.png')),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/add.png')),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/analysis.png')),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/group.png')),
            label: 'Group',
          ),
        ],
      ),
    );
  }
}
