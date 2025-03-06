// // import 'dart:developer';
// // import 'dart:io';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Darkens the color by the given percentage [percentage].
  /// The percentage should be between 0 and 100.
  Color darken(int percentage) {
    assert(percentage >= 0 && percentage <= 100,
        'Percentage must be between 0 and 100');
    final factor = 1 - (percentage / 100);
    return Color.fromARGB(
      alpha,
      (red * factor).clamp(0, 255).toInt(),
      (green * factor).clamp(0, 255).toInt(),
      (blue * factor).clamp(0, 255).toInt(),
    );
  }

  /// Lightens the color by the given percentage [percentage].
  /// The percentage should be between 0 and 100.
  Color lighten(int percentage) {
    assert(percentage >= 0 && percentage <= 100,
        'Percentage must be between 0 and 100');
    final factor = percentage / 100;
    return Color.fromARGB(
      alpha,
      (red + (255 - red) * factor).clamp(0, 255).toInt(),
      (green + (255 - green) * factor).clamp(0, 255).toInt(),
      (blue + (255 - blue) * factor).clamp(0, 255).toInt(),
    );
  }

  /// Determines the appropriate color based on the theme brightness.
  /// Returns a darkened color if the theme is light, and a lightened color if the theme is dark.
  Color adaptToTheme(BuildContext context, int percentage) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? lighten(percentage) : darken(percentage);
  }

  Color adaptToTheme2(BuildContext context, int percentage) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? darken(percentage) : lighten(percentage);
  }
}
