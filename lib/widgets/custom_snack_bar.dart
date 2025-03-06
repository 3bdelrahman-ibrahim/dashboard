// // import 'dart:developer';
// // import 'dart:io';

import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        margin: EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: MediaQuery.of(context).size.height -
              (AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.bottom +
                  MediaQuery.of(context).padding.top +
                  kBottomNavigationBarHeight +
                  MediaQuery.of(context).viewPadding.top +
                  20),
        ),
        content: Text(message),
      ),
    );
  }

  static void showBottom({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        margin: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 20,
        ),
        content: Text(message),
      ),
    );
  }
}
