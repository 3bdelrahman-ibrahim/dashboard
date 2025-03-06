import 'dart:developer' as dev;

import 'package:dashboard_example/app/theme.dart';
import 'package:dashboard_example/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// ================== Padding-related functions ==================

/// Function to get top padding (status bar area)
double getTopPadding(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// Function to get bottom padding (system navigation bar or other areas)
double getBottomPadding(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

/// Function to get left padding (if any)
double getLeftPadding(BuildContext context) {
  return MediaQuery.of(context).padding.left;
}

/// Function to get right padding (if any)
double getRightPadding(BuildContext context) {
  return MediaQuery.of(context).padding.right;
}

/// Function to get overall padding (top + bottom)
EdgeInsetsGeometry getTotalPadding(BuildContext context) {
  return EdgeInsets.only(
    top: getTopPadding(context),
    bottom: getBottomPadding(context),
  );
}

/// Function to get all padding (top, bottom, left, right)
EdgeInsetsGeometry getAllPadding(BuildContext context) {
  return MediaQuery.of(context).padding;
}

/// ================== Screen-related functions ==================

/// Function to get screen width
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Function to get screen height
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Function to get device pixel ratio (useful for high-density displays)
double getDevicePixelRatio(BuildContext context) {
  return MediaQuery.of(context).devicePixelRatio;
}

/// Function to check if the device is in landscape mode
bool isLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

/// Function to check if the device has a notch or safe area
bool hasNotch(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top > 0;
}

/// Function to get text scale factor (useful for accessibility)
double getTextScaleFactor(BuildContext context) {
  return MediaQuery.of(context).textScaleFactor;
}

/// ================== AppBar-related functions ==================

/// Function to get the height of the AppBar
double getAppBarHeight(BuildContext context) {
  final appBar = AppBar(); // Create a default AppBar instance
  return appBar.preferredSize.height; // Return the height of the AppBar
}

/// ================== System-related functions ==================

/// Function to get the height of the Status Bar (system status area)
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// Function to get the height of the Bottom Navigation Bar (if present)
double getBottomNavigationBarHeight(BuildContext context) {
  final bottomNavBarHeight = MediaQuery.of(context).padding.bottom;
  return bottomNavBarHeight > 0
      ? bottomNavBarHeight
      : 0.0; // Return 0 if no bottom nav bar
}

/// Function to get the total height (Status Bar + AppBar + Bottom Navigation Bar)
double getTotalHeight(BuildContext context) {
  double statusBarHeight = getStatusBarHeight(context);
  double appBarHeight = getAppBarHeight(context);
  double bottomNavBarHeight = getBottomNavigationBarHeight(context);
  return statusBarHeight + appBarHeight + bottomNavBarHeight;
}

double getScaleFactor(context) {
  return MediaQuery.of(context).textScaleFactor;
}

double getTopHomeHeight(context) {
  return getTopPadding(context) +
      getAppBarHeight(context) * 1.3 * getScaleFactor(context);
}

double getHomeCardHeight(context) {
  return getScreenWidth(context) * 0.6;
}

double getHomeCardWidth(context) {
  return getScreenWidth(context) * 0.9;
}

double getHomeDraggableHeight(context) {
  double screenHeight = getScreenHeight(context);
  double topHomeHeight = getTopHomeHeight(context);
  double homeCardHeight = getHomeCardHeight(context);
  return ((screenHeight - (topHomeHeight + homeCardHeight + 50)) /
      screenHeight);
}

bool getCurruntThemeBrightness(context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}

Color getCurruntThemePrimary(context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return Theme.of(context).primaryColorDark;
  } else {
    return Theme.of(context).primaryColorLight;
  }
}

class DateHelper {
  static String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}

Future<bool> checkFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstTime') ?? true;
}

Future<Map<String, dynamic>> loadSavedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final savedThemeIndex = prefs.getInt('themeIndex') ?? 0;
  final savedLanguageCode = prefs.getString('languageCode') ?? 'ar';

  final List<Map<String, dynamic>> themes = [
    {'theme': AppTheme.lightTheme, 'text': 'بني فاتح'},
    {'theme': AppTheme.darkTheme, 'text': 'بني غامق'},
  ];

  bool isDarkTheme = savedThemeIndex % 2 != 0;

  return {
    'theme': themes[savedThemeIndex]['theme'],
    'locale': Locale(savedLanguageCode),
    'isDarkTheme': isDarkTheme,
  };
}

Future<void> checkVersion(context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getString('db_version') ?? '1.0.0';

    if (savedVersion != '1.0.4') {
      showMyAlertDialog(
        context,
        'تنبيه',
        'يرجى تحديث التطبيق',
        action1Label: 'اغلاق',
        action2Label: 'تحديث',
        onAction2: () async {
          await launchUrl(
            Uri.parse(
              'https://play.google.com/store/apps/details?id=com.arab.restauranttest',
            ),
            mode: LaunchMode.externalApplication,
          );
        },
      );
      await prefs.setString('db_version', '1.0.4');
      dev.log('Database version updated to 1.0.4');
    }
  } catch (e) {
    dev.log('Error checking database version: $e');
  }
}

Future<void> clearAllData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await clearCache();
  } catch (e) {
    dev.log('Error delete all data: $e');
  }
}

Future<void> checkDatabaseVersion() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getString('db_version') ?? '1.0.0';
    final writeVersion = '1.1.1';
    // await prefs.clear();
    // await clearCache();

    if (savedVersion != writeVersion) {
      await clearCache();
      // await prefs.clear();
      await prefs.setString('db_version', writeVersion);
      dev.log('Database version updated to $writeVersion');
    }
  } catch (e) {
    dev.log('Error checking database version: $e');
  }
}

Future<void> clearCache() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('db_version');

    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      dev.log('Cache cleared successfully');
    }
  } catch (e) {
    dev.log('Error clearing cache: $e');
  }
}

// Future<void> resetAllNotifications() async {
//   final prefs = await SharedPreferences.getInstance();
//   final notificationService = NotificationService();
//   try {
//     await notificationService.cancelAllNotifications();
//     await notificationService.initializeNotifications();
//     //  log('message');
//     await prefs.remove('last_scheduled_date');

//     await prefs.remove('notifications_enabled');

//     final startupHandler = PrayerNotificationHandler(
//       notificationService: notificationService,
//     );
//     await startupHandler.handleStartup();

//     try {
//       final handler = GeneratedNotificationHandler(
//         notificationService: NotificationService(),
//         prefs: await SharedPreferences.getInstance(),
//       );

//       await handler.scheduleAllNotifications();
//       dev.log('GeneratedNotificationHandler scheduled successfully');
//     } catch (e) {
//       dev.log('Error scheduling GeneratedNotificationHandler: $e');
//     }
//   } catch (e) {
//     dev.log('Error resetAllNotifications: $e');
//   }
// }

// void initializeNotifications() {
//   // Listen for app lifecycle changes
//   SystemChannels.lifecycle.setMessageHandler((msg) async {
//     if (msg == AppLifecycleState.resumed.toString()) {
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//           FlutterLocalNotificationsPlugin();

//       await flutterLocalNotificationsPlugin.cancelAll();
//     }
//     return null;
//   });
// }

// class AppLifecycleObserver extends WidgetsBindingObserver {
//   bool _isAppActive = false;

//   bool get isAppActive => _isAppActive;

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _isAppActive = true;
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//           FlutterLocalNotificationsPlugin();
//       flutterLocalNotificationsPlugin.cancelAll();
//     } else {
//       _isAppActive = false;
//     }
//   }
// }

bool getDarkOrNot(context) {
  return Theme.of(context).brightness == Brightness.dark;
}

String getMode(BuildContext context, bool isQuran) {
  if (isQuran) {
    return "Quran"; // If Quran mode is enabled
  } else if (Theme.of(context).brightness == Brightness.dark) {
    return "Dark"; // If the app theme is dark
  } else {
    return "Light"; // If the app theme is light
  }
}

Map<String, dynamic> getThemeQuran(BuildContext context, bool isQuran) {
  if (isQuran) {
    return {'name': "Quran", 'background': Colors.white, 'text': Colors.black};
  } else if (Theme.of(context).brightness == Brightness.dark) {
    return {'name': "Dark", 'background': Colors.black, 'text': Colors.white};
  } else {
    return {'name': "Light", 'background': Colors.white, 'text': Colors.black};
  }
}

bool getIsDarkMode(context) {
  return Theme.of(context).brightness == Brightness.dark;
}

// Future<void> setNewData() async {
//   await getPrayerTimesForYear();

//   final notificationService = NotificationService();
//   await notificationService.initializeNotifications();
//   final startupHandler = PrayerNotificationHandler(
//     notificationService: notificationService,
//   );
//   await startupHandler.handleStartup();

//   // final prayerModel = Provider.of<PrayerModel>(context, listen: false);
//   // await prayerModel.fetchPrayerTimes();
//   initializeService();
// }

bool getIsArabic(context) {
  return Localizations.localeOf(context).languageCode == 'ar';
}

Future<bool> checkDarkMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if 'isDarkMode' is stored in SharedPreferences
  final bool? isDark = prefs.getBool('isDarkMode');

  // If not stored, fallback to system brightness

  if (isDark == null) {
    final bool isSystemDarkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

    // Save the system value as the initial default
    await prefs.setBool('isDarkMode', isSystemDarkMode);
    return isSystemDarkMode;
  }

  // Return the stored preference
  return isDark;
}

Future<bool> checkAuthentication() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAuthenticated') ?? false;
}

Future<bool> checkAnymous() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await checkAndSetPreference('isAnonymous');
  return prefs.getBool('isAuthenticated') ?? false;
}

Future<void> checkAndSetPreference(String key) async {
  // Obtain the SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  // Check if the given key exists
  if (!prefs.containsKey(key)) {
    // If not found, set the default value to true
    await prefs.setBool(key, true);
    dev.log("Key '$key' was not found. Default value set to true.");
  } else {
    dev.log("Key '$key' already exists.");
  }
}

Color MyCardColorful(bool isColored, bool isDarkMode) {
  Color lightColors =
      isColored
          ? const Color.fromARGB(255, 255, 220, 220)
          : const Color.fromARGB(255, 255, 255, 255);

  Color darkColors =
      isColored
          ? const Color.fromARGB(255, 50, 30, 30)
          : const Color.fromARGB(255, 30, 30, 30);

  return isDarkMode ? darkColors : lightColors;
}

Color MyCardColorful2(context, {required String color}) {
  bool isDarkMode = getDarkOrNot(context);
  Color primary =
      isDarkMode
          ? getShade(Colors.red.shade900, 0.1)
          : getShade(Theme.of(context).colorScheme.primary, 2.0);
  Color redColor =
      isDarkMode
          ? const Color.fromARGB(255, 30, 0, 0)
          : const Color.fromARGB(255, 255, 220, 220);

  Color greenColor =
      isDarkMode
          ? const Color.fromARGB(255, 0, 30, 0)
          : const Color.fromARGB(255, 220, 255, 220);

  Color blueColor =
      isDarkMode
          ? const Color.fromARGB(255, 0, 0, 30)
          : const Color.fromARGB(255, 220, 220, 255);

  Color greyColor =
      isDarkMode
          ? const Color.fromARGB(255, 20, 20, 20)
          : const Color.fromARGB(255, 235, 235, 235);

  if (color == 'red') {
    return redColor;
  } else if (color == 'green') {
    return greenColor;
  } else if (color == 'blue') {
    return blueColor;
  } else if (color == 'grey') {
    return greyColor;
  } else {
    return primary;
  }
}

Color getShade(Color color, double factor) {
  return Color.fromARGB(
    color.alpha,
    (color.red * factor).clamp(0, 255).toInt(),
    (color.green * factor).clamp(0, 255).toInt(),
    (color.blue * factor).clamp(0, 255).toInt(),
  );
}
