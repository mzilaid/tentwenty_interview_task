import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeMode themeMode = ThemeMode.light;
}

class AppThemes {
  static const Color primary = Color(0xFF202C43);
  static const Color secondary = Color(0xFF61C3F2);
  static final ThemeData light = ThemeData(
    sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: const RectangularSliderTrackShape(),
        thumbShape: SliderComponentShape.noOverlay),
    scaffoldBackgroundColor: const Color(0xffF6F6FA),
    iconTheme: const IconThemeData(color: Colors.black),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 0.5),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 10,
    ),
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: primary,
      displayColor: primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF2E2739),
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xFF827D88),
      selectedLabelStyle: GoogleFonts.poppins(), // optional
      unselectedLabelStyle: GoogleFonts.poppins(), // optional
    ),
  );
}
