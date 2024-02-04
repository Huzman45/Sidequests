import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme colourScheme(BuildContext context) => Theme.of(context).colorScheme;

class ThemeConstants {
  static Color get earthBrown => const Color.fromARGB(255, 159, 101, 47);
  static Color get neonGreen => const Color(0xFF01be02);
  static Color get vibrantYellow => const Color(0xFFffd224);
  static Color get commonBlue => const Color(0xFF98ccfe);
  static Color get rarePurple => const Color(0xFFa335ee);
}

ThemeData get lightMode => ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: GoogleFonts.stickTextTheme(),
      typography: Typography.material2021(),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ThemeConstants.neonGreen,
        onPrimary: ThemeConstants.earthBrown,
        primaryContainer: ThemeConstants.earthBrown,
        onPrimaryContainer: Colors.white,
        secondary: ThemeConstants.earthBrown,
        onSecondary: Colors.white,
        secondaryContainer: ThemeConstants.earthBrown,
        onSecondaryContainer: Colors.white,
        tertiary: ThemeConstants.earthBrown,
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
        inversePrimary: ThemeConstants.neonGreen,
        shadow: Colors.black.withOpacity(0.35),
        scrim: ThemeConstants.earthBrown,
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
