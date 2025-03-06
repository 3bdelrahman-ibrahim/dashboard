import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<dynamic> sideAnimation(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide transition (from right to left)
      const offsetBegin = Offset(1.0, 0.0);
      const offsetEnd = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

CustomTransitionPage<dynamic> bottomAnimation(
    GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide transition (from bottom to top)
      const offsetBegin = Offset(0.0, 1.0); // Start from bottom
      const offsetEnd = Offset.zero; // End at the current position
      const curve = Curves.easeInOut;

      var tween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

CustomTransitionPage<dynamic> fadeAnimation(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Fade transition
      var fadeAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));
      return FadeTransition(opacity: fadeAnimation, child: child);
    },
  );
}
