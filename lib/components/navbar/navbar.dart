// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:onelook/components/navbar/navbar_data.dart';
// import 'package:onelook/constants/app_color.dart';
// import 'package:onelook/controllers/navbar_controller.dart';

// class Navbar extends StatelessWidget {
//   Navbar({super.key});

//   final NavbarController controller = Get.put(NavbarController());

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final iconContainerWidth = screenWidth / NavbarData.icons.length;
//     return Scaffold(
//       body: Obx(() => NavbarData.screens[controller.selectedIndex.value]), 
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(32),
//             topRight: Radius.circular(32),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(237, 238, 251, 0.8),
//               blurRadius: 40,
//               spreadRadius: 2,
//               offset: Offset(0, -5),
//             ),
//           ],
//         ),
//         height: screenHeight * 0.1,
//         child: Stack(
//           children: [
//             Obx(() {
//               final circlePosition = (controller.selectedIndex.value * iconContainerWidth) +
//                   (iconContainerWidth / 2) -
//                   25;
//               return AnimatedPositioned(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 left: circlePosition,
//                 top: screenWidth * 0.025,
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: AppColors.lightvoilet,
//                 ),
//               );
//             }),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(NavbarData.icons.length, (index) {
//                 return GestureDetector(
//                   onTap: () => controller.changeIndex(index),
//                   child: Container(
//                     width: iconContainerWidth,
//                     height: screenHeight * 0.1,
//                     alignment: Alignment.center,
//                     child: Obx(() {
//                       return Image.asset(
//                         controller.selectedIndex.value != index
//                             ? NavbarData.icons[index] 
//                             : NavbarData.filledIcons[index], 
//                         scale: 3.5,
//                       );
//                     }),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }