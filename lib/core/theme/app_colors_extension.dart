import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    this.brandBackground = const Color(0xFF1B38A0),
    this.onBrandBackground = Colors.white,
  });

  final Color brandBackground;
  final Color onBrandBackground;

  @override
  AppColorsExtension copyWith({
    Color? brandBackground,
    Color? onBrandBackground,
  }) {
    return AppColorsExtension(
      brandBackground: brandBackground ?? this.brandBackground,
      onBrandBackground: onBrandBackground ?? this.onBrandBackground,
    );
  }

  @override
  AppColorsExtension lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      brandBackground: Color.lerp(brandBackground, other.brandBackground, t)!,
      onBrandBackground: Color.lerp(
        onBrandBackground,
        other.onBrandBackground,
        t,
      )!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
