import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppConsts {
  static int splashDelay = 0;
  static String nullAssetImage = 'assets/images/null.jpg';
  static String appLink =
      'https://play.google.com/store/apps/details?id=com.arab.salamspace';

  /////////////// routes ///////////////////////////////////////////////////////////////////////////////////

  static String splash = '/splash';
  static String login = '/login';
  static String getStarted = '/get-started';

  static String home = '/home';
  static String cart = '/cart';
  static String qr = '/qr';
  static String followOrder = '/follow-order';
  static String settings = '/settings';

  static String profile = '/settings/profile';
  static String notifications = '/settings/notifications';

  //////////////////////////////////////////////////////////////////////////////////////////////////

  static Color primaryColor = const Color(0xFFE0E0E0);
  static Color secondaryColor = const Color(0xFFE0E0E0);
  static String kBaseUrl = 'https://api.example.com';
  static int kApiTimeout = 30000; // milliseconds
  static String kApiVersion = 'v1';

// Authentication Related
  static String kAuthToken = 'auth_token';
  static String kRefreshToken = 'refresh_token';
  static String kUserDataKey = 'user_data';
  static int kOtpLength = 6;
  static int kPasswordMinLength = 8;

// Shared Preferences Keys
  static String kPrefIsFirstTime = 'is_first_time';
  static String kPrefLanguageCode = 'language_code';
  static String kPrefThemeMode = 'theme_mode';
  static String kImageUrl =
      'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=';

// Animation Duration  staticants
  static Duration kDefaultAnimationDuration = const Duration(milliseconds: 300);
  static Duration kLongAnimationDuration = const Duration(milliseconds: 500);
  static Duration kPageTransitionDuration = const Duration(milliseconds: 200);

// UI  staticants
  static double kDefaultPadding = 16.0;
  static double kDefaultMargin = 16.0;
  static double kDefaultRadius = 8.0;
  static double kButtonHeight = 48.0;
  static double kAppBarHeight = 56.0;
  static double kBottomNavBarHeight = 60.0;

// Font Sizes
  static double kFontSizeXSmall = 10.0;
  static double kFontSizeSmall = 12.0;
  static double kFontSizeRegular = 14.0;
  static double kFontSizeMedium = 16.0;
  static double kFontSizeLarge = 18.0;
  static double kFontSizeXLarge = 20.0;
  static double kFontSizeXXLarge = 24.0;

// Image Assets
  static String kLogoPath = 'assets/images/logo.png';
  static String kPlaceholderImage = 'assets/images/placeholder.png';
  static String kErrorImage = 'assets/images/error.png';

// Local Storage Keys
  static String kCacheKey = 'cache_data';
  static String kSearchHistoryKey = 'search_history';
  static String kRecentViewsKey = 'recent_views';

// Date Formats
  static String kDateFormatDefault = 'yyyy-MM-dd';
  static String kDateFormatWithTime = 'yyyy-MM-dd HH:mm';
  static String kDateFormatDisplay = 'MMM dd, yyyy';
  static String kTimeFormatDisplay = 'HH:mm a';

// Network  staticants
  static int kMaxRetryAttempts = 3;
  static Duration kRetryInterval = const Duration(seconds: 5);
  static int kMaxCacheAge = 7; // days

// Pagination
  static int kDefaultPageSize = 20;
  static int kMaxPageSize = 50;
  static String kDefaultSortOrder = 'desc';

// Validation  staticants
  static String kEmailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static String kPhoneRegex = r'^\+?[0-9]{10,14}$';
  static String kUrlRegex =
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

// Error Messages
  static String kErrorNoInternet = 'No internet connection';
  static String kErrorTimeout = 'Request timeout';
  static String kErrorUnauthorized = 'Unauthorized access';
  static String kErrorGeneric = 'Something went wrong';

// Success Messages
  static String kSuccessProfileUpdate = 'Profile updated successfully';
  static String kSuccessPasswordChange = 'Password changed successfully';
  static String kSuccessLogout = 'Logged out successfully';

// Feature Flags
  static bool kEnablePushNotifications = true;
  static bool kEnableAnalytics = true;
  static bool kEnableCrashReporting = true;
  static bool kEnableDeepLinking = true;

// App Information
  static String kAppName = 'Your App Name';
  static String kAppVersion = '1.0.0';
  static String kAppBuildNumber = '1';
  static String kSupportEmail = 'support@example.com';
  static String kPrivacyPolicyUrl = 'https://example.com/privacy';
  static String kTermsUrl = 'https://example.com/terms';

// Social Media URLs
  static String kFacebookUrl = 'https://facebook.com/yourapp';
  static String kTwitterUrl = 'https://twitter.com/yourapp';
  static String kInstagramUrl = 'https://instagram.com/yourapp';

// Cache Duration
  static Duration kCacheDurationShort = const Duration(minutes: 5);
  static Duration kCacheDurationMedium = const Duration(hours: 1);
  static Duration kCacheDurationLong = const Duration(days: 1);

// File Size Limits (in bytes)
  static int kMaxImageSize = 5 * 1024 * 1024; // 5MB
  static int kMaxVideoSize = 50 * 1024 * 1024; // 50MB
  static int kMaxDocumentSize = 10 * 1024 * 1024; // 10MB

// Location  staticants
  static double kDefaultLatitude = 0.0;
  static double kDefaultLongitude = 0.0;
  static int kLocationTimeout = 10000; // milliseconds
  static double kLocationAccuracy = 100.0; // meters

// In-App Purchase
  static String kPremiumSubscriptionId = 'premium_subscription';
  static Duration kSubscriptionDuration = const Duration(days: 30);
  static double kDefaultCurrency = 0.0;

  static Color kPrimaryColor = const Color(0xFF6200EE); // Purple
  static Color kSecondaryColor = const Color(0xFF03DAC6); // Teal
  static Color kBackgroundColor = const Color(0xFFF5F5F5); // Light Gray
  static Color kAccentColor = const Color(0xFFBB86FC); // Light Purple
  static Color kErrorColor = const Color(0xFFB00020); // Red
  static Color kOnPrimaryColor = const Color(0xFFFFFFFF); // White
  static Color kOnSecondaryColor = const Color(0xFF000000); // Black
  static Color kSurfaceColor = const Color(0xFF121212); // Dark Gray
  static Color kTextColor = const Color(0xFF000000); // Black
  static Color kIconColor = const Color(0xFF888888); // Gray
  static Color kDividerColor =
      const Color.fromRGBO(100, 100, 100, 0); // Light Gray

  static String kFirebaseProjectId = 'your_firebase_project_id';
  static String kSentryDsn = 'your_sentry_dsn';
  static String kStripePublishableKey = 'your_stripe_publishable_key';
  static String kStripeSecretKey = 'your_stripe_secret_key';
  static String kOnesignalAppId = 'your_onesignal_app_id';
  static String kAppDescription = 'A brief description of your app.';
  static String kAppIconAsset = 'assets/images/app_icon.png';
  static String kAppLogoAsset = 'assets/images/app_logo.png';
  static String kAppSplashAsset = 'assets/images/app_splash.png';

  static String kNetworkImage =
      'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=';
  final String kRandomImage =
      'https://picsum.photos/200/300?date=${DateTime.now().toIso8601String()}';
  static String kAssetImage = 'assets/images/null.jpg';

  static String kGoogleMapsApiKeys =
      'https://samplelib.com/lib/preview/mp4/sample-5s.mp4';
  static String kGoogleMapsApiKey =
      'https://samplelib.com/lib/preview/mp4/sample-5s.mp4';
}
