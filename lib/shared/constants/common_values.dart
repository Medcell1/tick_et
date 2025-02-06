import 'package:flutter/material.dart';

class CommonValues {
  const CommonValues._();

  static const Color kCanvasColor = Colors.white;

  static const double maxWidth = 720;
  static const int pickyModalSheetMaxItems = 12;
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration snackBarDismissAnimationDuration = Duration(seconds: 3);
  static const double tapRegionInflation = 16;

  static const String defaultCountryCode = 'GB';
  static const String defaultCountryDialCode = '+229';
  static const String defaultCurrencyCode = 'EUR';

  static const Duration apiRequestDebounceTime = Duration(milliseconds: 300);
}
