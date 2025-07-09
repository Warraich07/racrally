import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_fonts.dart';
class AppTheme {
  // Colors #
  static const Color primaryColorHover = Color(0xFF1E40FF); // Slightly darker
  static const Color secondaryColorHover =
  Color(0xFF3A3A3A); // Slightly lighter
  static const Color headingTextColor = Color(0xFF1A1A1A); // Dark for headings
  static const Color bodyTextColor = Color(0xFF4A4A4A); // Neutral for body text
  static const Color captionTextColor =
  Color(0xFF9E9E9E); // Light grey for captions
  // static const Color backgroundColor = Color(0xFFF9F9FB); //ultra light grey
  // static const Color backgroundColor = Color(0xFFFAFAFD); //warm white
  // static const Color backgroundColor =
  //     Color(0xFFF8F7FC); // Light purple background #
//Light Theme
// Modern purple color

  static const Color backgroundColor = Color(0xFFF5F8FF); //Blue tint
  static const Color errorColor = Colors.red;
  static const Color greyColor = Color.fromARGB(255, 113, 14, 14);
  static const Color whiteColor = Colors.white;
  static const Color greenColor = Color(0xFF4CAF50); // Modern green color
  static const Color shadowColor = Color(0x1A000000); // Subtle shadow color #
  static const Color drawerGreyColor = Color(0xFF606060);
  static const Color inputBorderColor =
  Color(0xFFD2D2D2); // Subtle shadow color
  // Dark Theme Colors
  // in use
  static const Color darkPrimaryColor = Color(0xFF342C83);
  static const Color lightPrimaryColor = Color(0xFF4834CE);
  static const Color secondaryColor =  Color(0xFF625CF5);
  static const Color primaryColor = Color(0xFFFCFCFD);
  static const Color dividerColor = Color(0xFFE3E8EF);
  static const Color primaryLittleDarkColor = Color(0xFFEEF2F6);
  static const Color primaryCardColor = Color(0xFF16B364);
  static const Color primaryDarkColor = Color(0xFFEEF1FF);
  static const Color primaryExtraLightColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkGreyColor = Color(0xFF697586);
  static const Color mediumGreyColor = Color(0xFF2E2E2E);
  static const Color lightGreyColor = Color(0xFF9AA4B2);
  static const Color extraLightGreyColor = Color(0xFFF8FAFC);
  static const Color green =  Color(0xFF16B364);
  static const Color lightGreen =  Color(0xFFEDFCF2);
  static const Color red = Color(0xFFEC4F47);
  static const Color lightRed = Color(0xFFFEF3F2);
  static const Color orange =  Color(0xFFEF6820);
  static const Color yellow =   Color(0xFFEAAA08);

  static const Color textfieldBorderColor = Color(0xFF9AA4B2);
  // till here
  static const Color darkSecondaryColor = Color(0xFFE0E0E0);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);

  static const Color darkInputBorderColor = Color(0xFF404040);


  // Text Styles


  // in use

  static TextStyle get bodySmallStyleFont600 => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: primaryColor,
  );
  static TextStyle get bodySmallStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: primaryColor,
  );
  static TextStyle get bodySmallGreyStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: darkGreyColor,
  );
  static TextStyle get bodyMediumGreyStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: darkGreyColor,
  );
  static TextStyle get bodyExtraSmallStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: darkGreyColor,
  );
  static TextStyle get bodyExtraSmallWeight400Style => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: darkGreyColor,
  );
  static TextStyle get bodyExtraSmallFontTenStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: primaryDarkColor,
  );
  static TextStyle get bodyExtraSmallFontWeight500Style => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: darkGreyColor,
  );
  static TextStyle get bodyMediumStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color:darkBackgroundColor ,
  );

  static TextStyle get bodyMediumFont600Style => const TextStyle(
    fontFamily: AppFonts.medium,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color:darkBackgroundColor ,
  );
  static TextStyle get headingStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
  static TextStyle get subHeadingStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: darkBackgroundColor,
  );
  static TextStyle get mediumLightHeadingStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkBackgroundColor,
  );
  static TextStyle get mediumHeadingStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: darkBackgroundColor,
  );
  static TextStyle get mediumHeadingFont600Style => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: darkBackgroundColor,
  );
  static TextStyle get subHeadingMediumStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: darkBackgroundColor,
  );
  // till here
  static TextStyle get smallStyle => const TextStyle(
    fontFamily: AppFonts.medium,
    fontSize: 14,
    color: greyColor,
  );
  static const _baseTextSizes = {
    'displayLarge': 24.0,
    'displayMedium': 22.0,
    'displaySmall': 20.0,
    'headlineMedium': 18.0,
    'titleLarge': 16.0,
    'titleMedium': 14.0,
    'bodyLarge': 14.0,
    'bodyMedium': 12.0,
    'bodySmall': 10.0,
  };
  static const _baseTextWeights = {
    'displayLarge': FontWeight.bold,
    'displayMedium': FontWeight.bold,
    'displaySmall': FontWeight.bold,
    'headlineMedium': FontWeight.w600,
    'titleLarge': FontWeight.w600,
    'titleMedium': FontWeight.normal,
    'bodyLarge': FontWeight.normal,
    'bodyMedium': FontWeight.normal,
    'bodySmall': FontWeight.normal,
  };
  // Function to create text theme with consistent sizes and weights
  static TextTheme _createTextTheme() {
    const baseTextTheme = TextTheme();
    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: _baseTextSizes['displayLarge'],
        fontFamily: AppFonts.medium,
        fontWeight: _baseTextWeights['displayLarge'],
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontSize: _baseTextSizes['displayMedium'],
        fontFamily: AppFonts.medium,
        fontWeight: _baseTextWeights['displayMedium'],
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontSize: _baseTextSizes['displaySmall'],
        fontFamily: AppFonts.medium,
        fontWeight: _baseTextWeights['displaySmall'],
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: _baseTextSizes['headlineMedium'],
        fontFamily: AppFonts.medium,
        fontWeight: _baseTextWeights['headlineMedium'],
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontSize: _baseTextSizes['titleLarge'],
        fontFamily: AppFonts.medium,
        fontWeight: _baseTextWeights['titleLarge'],
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontSize: _baseTextSizes['titleMedium'],
        fontFamily: AppFonts.medium,
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontSize: _baseTextSizes['bodyLarge'],
        fontFamily: AppFonts.medium,
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontSize: _baseTextSizes['bodyMedium'],
        fontFamily: AppFonts.medium,
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontSize: _baseTextSizes['bodySmall'],
        fontFamily: AppFonts.medium,
        color: Theme.of(Get.context!).colorScheme.tertiary,
      ),
    );
  }
  // Theme Data
  static ThemeData get lightTheme {
    const baseTextTheme = TextTheme();
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: whiteColor,
        onPrimaryContainer: Colors.white,
        secondary: secondaryColor,
        error: errorColor, onSurfaceVariant: Colors.white,
        surface: backgroundColor,
        inverseSurface: secondaryColor,

        // Black text on surface
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dayPeriodTextColor: Colors.black, // Set AM/PM color to black
        hourMinuteTextColor: whiteColor,
        hourMinuteColor: AppTheme.primaryColor,
        dayPeriodColor: AppTheme.primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
  static ThemeData get darkTheme {
    const baseTextTheme = TextTheme();
    return ThemeData.dark().copyWith(
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor:
      const Color(0xFF1A1A1A), // Slightly lighter dark background
      textTheme: _createTextTheme(),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        // primary: darkPrimaryColor,
        secondary: darkSecondaryColor, // Lighter blue for better contrast
        primaryContainer: Color(0xFF242424),
        error: Color(0xFFFF5252), // Brighter error color
        surface: Color(0xFF242424), // Slightly lighter surface color
        onSurface: Colors.white, // White text on background
        inverseSurface: secondaryColor, // Black text on surface
        onSurfaceVariant: Colors.white,
        onPrimaryContainer: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4, // Added elevation for better depth
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: const Color(0xFF242424), // Matching surface color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dayPeriodTextColor: Colors.white,
        hourMinuteTextColor: Colors.white,
        hourMinuteColor: darkPrimaryColor
            .withOpacity(0.3), // Semi-transparent for better contrast
        dayPeriodColor: darkPrimaryColor.withOpacity(0.3),
        dialHandColor: darkPrimaryColor, // Accent color for the dial hand
        dialBackgroundColor:
        const Color(0xFF3A3A3A), // Slightly lighter for contrast
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C), // Slightly lighter for input fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFF404040)), // Subtle border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkPrimaryColor.withOpacity(0.8)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5252)),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle:
        const TextStyle(color: Color(0xFF9E9E9E)), // More visible hint text
        labelStyle: const TextStyle(
            color: Color(0xFFBDBDBD)), // More visible label text
      ),
    );
  }
}