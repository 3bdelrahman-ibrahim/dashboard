import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15.0,
        left: 15.0,
        bottom: 15.0,
        top: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context)
              .scaffoldBackgroundColor, // Adapts t o light/dark mode
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
