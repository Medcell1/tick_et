import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTypography {
  static  TextStyle headline = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
  );
  static  TextStyle priceStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.accentPink,
    ),
  );
  static  TextStyle subtitle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    )
  );
  static  TextStyle body = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    )
  );

  static const TextStyle button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
