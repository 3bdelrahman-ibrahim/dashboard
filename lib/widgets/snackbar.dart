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
          (getBottomNavigationBarHeight(context) +
              getAppBarHeight(context) +
              getStatusBarHeight(context) +
              20),
    ),
    content: Text(
      text,
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
    ),
    backgroundColor:
        getIsDarkMode(context)
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColorLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
}

SnackBar createSnackBar2(BuildContext context, String text) {
  return SnackBar(
    behavior: SnackBarBehavior.floating, // Change to floating
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 0),
    content: Text(
      text,
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
}
