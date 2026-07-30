import 'package:flutter/material.dart';
import 'app_colors_extension.dart';

abstract final class AppTheme {
  static const _seedColor = Color(0xFF1E88E5);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    extensions: const [AppColorsExtension()],
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    extensions: const [AppColorsExtension()],
  );
}
