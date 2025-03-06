import 'dart:ui';
import 'package:flutter/material.dart';

class MyCustomTopStackBar extends StatelessWidget {
  const MyCustomTopStackBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              color: Colors.white.withAlpha(30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).padding.top,
            ),
          ),
        ),
      ],
    );
  }
}
