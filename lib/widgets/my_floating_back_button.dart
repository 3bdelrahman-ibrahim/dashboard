import 'dart:developer';

import 'package:dashboard_example/app/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyFloatingBackButton extends StatelessWidget {
  const MyFloatingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 15.0,
        left: 15.0,
        bottom: 15.0,
        top: getStatusBarHeight(context) + 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color:
              Theme.of(
                context,
              ).scaffoldBackgroundColor, // Adapts t o light/dark mode
          borderRadius: BorderRadius.circular(15), // Rounded corners
          boxShadow: [
            const BoxShadow(
              color: Colors.black, // Soft shadow
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
    );
  }
}

class MyFloatingBackButton2 extends StatelessWidget {
  const MyFloatingBackButton2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
            right: 15.0,
            left: 15.0,
            bottom: 15.0,
            top: getStatusBarHeight(context),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                250,
                20,
                28,
                43,
              ), // Adapts t o light/dark mode
              borderRadius: BorderRadius.circular(15), // Rounded corners
              boxShadow: [
                const BoxShadow(
                  color: Colors.black, // Soft shadow
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                log('Pressed');
                context.pop();
              },
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
