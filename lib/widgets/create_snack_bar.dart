import 'dart:developer';

import 'package:dashboard_example/app/config.dart';
import 'package:flutter/material.dart';

SnackBar createSnackBar(BuildContext context, String text) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    margin: EdgeInsets.only(
      right: 20.0,
      left: 20.0,
      bottom:
          getScreenHeight(context) -
          (getAppBarHeight(context) + getStatusBarHeight(context) + 20),
    ),
    content: Text(text),
  );
}

SnackBar createTopSnackBar(
  BuildContext context,
  String text,
  Color backgroundColor,
) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    backgroundColor: backgroundColor,
    margin: EdgeInsets.only(
      right: 20.0,
      left: 20.0,
      bottom:
          getScreenHeight(context) -
          (getAppBarHeight(context) + getStatusBarHeight(context) + 50),
    ),
    content: Text(text),
  );
}

SnackBar createBottomSnackBar(BuildContext context, String text) {
  log(getScreenHeight(context).toString());
  return SnackBar(
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
    content: Text(text),
  );
}
