// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';

// class NavigationKeys {
//   static final rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');
//   static final shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');
// }

// class ExitConfirmationNavigatorObserver extends NavigatorObserver {
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     if (previousRoute == null) {
//       log('message');
//       _showExitConfirmationDialog(route.navigator!.context);
//     }
//   }
// }

// Future<bool> _showExitConfirmationDialog(BuildContext context) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Exit App'),
//       content: const Text('Are you sure you want to exit the app?'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: const Text('Exit'),
//         ),
//       ],
//     ),
//   );

//   if (result == true) {
//     SystemNavigator.pop(); // Exit the app
//     return true;
//   }
//   return false;
// }

// final goRouter = GoRouter(
//   navigatorKey: NavigationKeys.rootNavigator,
//   observers: [ExitConfirmationNavigatorObserver()],
//   debugLogDiagnostics: true,
//   initialLocation: '/',
//   routes:   [
//           GoRoute(
//             path: '/',
//             builder: (context, state) => BackButtonListener(
//               onBackButtonPressed: () async {
//                 return await NavigationMethod(context);
//               },
//               child: const SplashScreen(),
//             ),
//             routes: [
//               GoRoute(
//                 path: 'get-started',
//                 builder: (context, state) => const GetStartedScreen(),
//               ),
//               GoRoute(
//                 path: 'login',
//                 builder: (context, state) => const LoginScreen(),
//               ),
//               ShellRoute(
//                 navigatorKey: NavigationKeys.shellNavigator,
//                 builder: (context, state, child) {
//                   return MainScreen(
//                     currentIndex: 0,
//                     child: child,
//                   );
//                 },
//                 routes: [
//                   GoRoute(
//                     path: 'home',
//                     builder: (context, state) => const HomeScreen(),
//                     routes: [
//                       GoRoute(
//                         path: 'test',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         builder: (context, state) => const TestScreen(),
//                       ),
//                       GoRoute(
//                         path: 'foods',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const PopScope(child: FoodsListSection()),
//                           );
//                         },
//                         routes: [
//                           GoRoute(
//                             path: ':id',
//                             parentNavigatorKey: NavigationKeys.rootNavigator,
//                             pageBuilder: (context, state) {
//                               final foodId = state.pathParameters['id'] ?? '';
//                               return fadeAnimation(
//                                 state,
//                                 FoodDetailsScreen(foodItem: foodId),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   GoRoute(
//                     path: 'cart',
//                     builder: (context, state) => const CartScreen(),
//                     routes: [
//                       GoRoute(
//                         path: 'checkout',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const CheckoutScreen(),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   GoRoute(
//                     path: 'qr',
//                     builder: (context, state) => const QrScreen(
//                       userId: '01234567890123456789',
//                     ),
//                   ),
//                   GoRoute(
//                     path: 'follow-order',
//                     builder: (context, state) => const FollowOrderScreen(),
//                   ),
//                   GoRoute(
//                     path: 'settings',
//                     builder: (context, state) => const SettingsScreen(),
//                     routes: [
//                       GoRoute(
//                         path: 'profile',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             EditProfilePage(),
//                           );
//                         },
//                       ),
//                       GoRoute(
//                         path: 'points',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const PointsScreen(),
//                           );
//                         },
//                       ),
//                       GoRoute(
//                         path: 'notifications',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const NotificationsScreen(),
//                           );
//                         },
//                       ),
//                       GoRoute(
//                         path: 'privacy-policy',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const PrivacyPolicyScreen(),
//                           );
//                         },
//                       ),
//                       GoRoute(
//                         path: 'MyPortfolio',
//                         parentNavigatorKey: NavigationKeys.rootNavigator,
//                         pageBuilder: (context, state) {
//                           return sideAnimation(
//                             state,
//                             const WebsitePortfolio(),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//   errorBuilder: (context, state) => const ErrorScreen(),
// );
// Future<bool?> newMethod(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Exit App'),
//       content: const Text('Are you sure you want to exit the app?'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: const Text('Exit'),
//         ),
//       ],
//     ),
//   );
// }
