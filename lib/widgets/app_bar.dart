import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlurredAppBar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final double paddingtop = MediaQuery.of(context).padding.top > 0
        ? MediaQuery.of(context).padding.top
        : 10.0;
    return Container(
      height: 50,

      padding: EdgeInsets.fromLTRB(20, paddingtop + 20, 20, 0),
      // To add some elevation shadow
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, // spaceBetween
              children: [
                // const BackButton(),
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.menu),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
