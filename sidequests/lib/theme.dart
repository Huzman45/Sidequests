import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme colourScheme(BuildContext context) => Theme.of(context).colorScheme;

class ThemeConstants {
  static Color get earthBrown => const Color.fromARGB(255, 159, 101, 47);
  static Color get neonGreen => const Color(0xFF01be02);
}

ThemeData get lightMode => ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: GoogleFonts.poorStoryTextTheme(),
      typography: Typography.material2021(),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ThemeConstants.neonGreen,
        onPrimary: const Color(0x009f662f),
        primaryContainer: const Color(0xFF757B82),
        onPrimaryContainer: const Color(0x009f662f),
        secondary: const Color(0x009f662f),
        onSecondary: Colors.white,
        secondaryContainer: const Color(0x9f662f),
        onSecondaryContainer: Colors.white,
        tertiary: const Color(0x009f662f),
        onTertiary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.red.withAlpha(120),
        onErrorContainer: Colors.white,
        outline: Color(0x9f662f),
        outlineVariant: Color(0x9f662f),
        background: ThemeConstants.earthBrown,
        onBackground: Color(0x9f662f),
        surface: ThemeConstants.earthBrown,
        onSurface: Colors.white,
        surfaceVariant: Colors.transparent,
        onSurfaceVariant: Colors.white,
        inverseSurface: Colors.white,
        onInverseSurface: Colors.white,
        inversePrimary: const Color(0x009f662f),
        shadow: Colors.black.withOpacity(0.35),
        scrim: const Color(0x009f662f),
        surfaceTint: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        visualDensity: VisualDensity(vertical: -4, horizontal: -4),
        contentPadding: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4.0,
        iconSize: 24.0,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          padding: EdgeInsets.zero,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        ),
      ),
    );
