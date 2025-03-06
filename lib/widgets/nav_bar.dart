// import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
// import 'package:iconly/iconly.dart';
// import 'package:restauranttest/app/config.dart';

// class NavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onItemTapped;

//   const NavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return CrystalNavigationBar(
//       enableFloatingNavBar: true,

//       borderRadius: 25,
//       boxShadow: [
//         BoxShadow(
//           color:
//               Theme.of(context).primaryColor.withOpacity(0.2), // Shadow color
//           blurRadius: 5, // Spread radius
//           offset: const Offset(0, 4), // Offset in the x and y direction
//         )
//       ],
//       margin: const EdgeInsets.only(top: 30),
//       currentIndex: currentIndex, //15 Use the current index
//       paddingR: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//       marginR: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),

//       unselectedItemColor: getCurruntThemePrimary(context).withAlpha(200),
//       backgroundColor: isDark
//           ? Theme.of(context).canvasColor.withAlpha(150)
//           : Theme.of(context).cardColor.withAlpha(150),
//       //  backgroundColor: Colors.grey.withOpacity(0.5),
//       onTap: onItemTapped, // Call the callback when tapped
//       items: [
//         CrystalNavigationBarItem(
//           icon: IconlyBold.home,
//           unselectedIcon: IconlyBroken.home,
//           selectedColor: getCurruntThemePrimary(context),
//         ),
//         CrystalNavigationBarItem(
//           icon: IconlyBold.bag,
//           unselectedIcon: IconlyBroken.bag,
//           selectedColor: getCurruntThemePrimary(context),
//         ),
//         CrystalNavigationBarItem(
//           icon: IconlyBold.message,
//           unselectedIcon: IconlyBroken.message,
//           selectedColor: getCurruntThemePrimary(context),
//         ),
//         CrystalNavigationBarItem(
//           icon: IconlyBold.setting,
//           unselectedIcon: IconlyBroken.setting,
//           selectedColor: getCurruntThemePrimary(context),
//         ),
//       ],
//     );
//   }
// }
