import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF286A48),
      surfaceTint: Color(0xFF286A48),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color.from(
        alpha: 1,
        red: 0.678,
        green: 0.949,
        blue: 0.776,
      ),
      onPrimaryContainer: Color(0xFF002111),
      secondary: Color(0xFF266489),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFC9E6FF),
      onSecondaryContainer: Color(0xFF001E2F),
      tertiary: Color(0xFF88511E),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFDCC3),
      onTertiaryContainer: Color(0xFF2F1500),
      error: Color(0xFF904A46),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD7),
      onErrorContainer: Color(0xFF3B0909),
      background: Color(0xFFF6FBF4),
      onBackground: Color(0xFF171D19),
      surface: Color(0xFFF8F9FF),
      onSurface: Color(0xFF191C20),
      surfaceVariant: Color(0xFFDEE3EB),
      onSurfaceVariant: Color(0xFF42474E),
      outline: Color(0xFF73777F),
      outlineVariant: Color(0xFFC2C7CF),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2E3035),
      inverseOnSurface: Color(0xFFEFF0F7),
      inversePrimary: Color(0xFF92D5AB),
      primaryFixed: Color(0xFFADF2C6),
      onPrimaryFixed: Color(0xFF002111),
      primaryFixedDim: Color(0xFF92D5AB),
      onPrimaryFixedVariant: Color(0xFF065232),
      secondaryFixed: Color(0xFFC9E6FF),
      onSecondaryFixed: Color(0xFF001E2F),
      secondaryFixedDim: Color(0xFF95CDF7),
      onSecondaryFixedVariant: Color(0xFF004B6F),
      tertiaryFixed: Color(0xFFFFDCC3),
      onTertiaryFixed: Color(0xFF2F1500),
      tertiaryFixedDim: Color(0xFFFFB77D),
      onTertiaryFixedVariant: Color(0xFF6C3A07),
      surfaceDim: Color(0xFFD8DAE0),
      surfaceBright: Color(0xFFF8F9FF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF2F3FA),
      surfaceContainer: Color(0xFFECEDF4),
      surfaceContainerHigh: Color(0xFFE7E8EE),
      surfaceContainerHighest: Color(0xFFE1E2E8),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF006A60),
      surfaceTint: Color(0xFF3B9D91),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF53BCAF),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF006964),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF53B9B3),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF70D0C3),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF94F2E2),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFFD84315),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFED6A5A),
      onErrorContainer: Color(0xFFFFFFFF),
      background: Color(0xFFF8FAF6),
      onBackground: Color(0xFF3E4948),
      surface: Color(0xFFF9FBF7),
      onSurface: Color(0xFF414D4C),
      surfaceVariant: Color(0xFFE3E7E4),
      onSurfaceVariant: Color(0xFF858D8A),
      outline: Color(0xFF9FABA8),
      outlineVariant: Color(0xFFADB8B5),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF475B58),
      inverseOnSurface: Color(0xFFE9ECEB),
      inversePrimary: Color(0xFF75CEC3),
      primaryFixed: Color(0xFF53BCAF),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF3BAEA1),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF53B9B3),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF3AAD9E),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF94F2E2),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF6FD8C2),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFF4F7F0),
      surfaceBright: Color(0xFFF9FBF7),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF6F8F4),
      surfaceContainer: Color(0xFFF3F6F1),
      surfaceContainerHigh: Color(0xFFF1F4EF),
      surfaceContainerHighest: Color(0xFFEFEFED),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF004C45),
      surfaceTint: Color(0xFF3B9D91),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF006A60),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF003733),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF006964),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF5CACA0),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF70D0C3),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFFD32F2F),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFD84315),
      onErrorContainer: Color(0xFFFFFFFF),
      background: Color(0xFFF8FAF6),
      onBackground: Color(0xFF3E4948),
      surface: Color(0xFFF9FBF7),
      onSurface: Color(0xFF000000),
      surfaceVariant: Color(0xFFE3E7E4),
      onSurfaceVariant: Color(0xFF797E7C),
      outline: Color(0xFF858D8A),
      outlineVariant: Color(0xFF858D8A),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF475B58),
      inverseOnSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFF99F0E5),
      primaryFixed: Color(0xFF006A60),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF00564E),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF006964),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF00564C),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF70D0C3),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF568C83),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFF4F7F0),
      surfaceBright: Color(0xFFF9FBF7),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF6F8F4),
      surfaceContainer: Color(0xFFF3F6F1),
      surfaceContainerHigh: Color(0xFFF1F4EF),
      surfaceContainerHighest: Color(0xFFEFEFED),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF75CEC3),
      surfaceTint: Color(0xFF75CEC3),
      onPrimary: Color(0xFF00413D),
      primaryContainer: Color(0xFF00514A),
      onPrimaryContainer: Color(0xFF91F3E8),
      secondary: Color(0xFF77D1C7),
      onSecondary: Color(0xFF003F3A),
      secondaryContainer: Color(0xFF004B45),
      onSecondaryContainer: Color(0xFFCAF7F1),
      tertiary: Color(0xFFFFF7F0),
      onTertiary: Color(0xFF663D00),
      tertiaryContainer: Color(0xFF7E5D28),
      onTertiaryContainer: Color(0xFFFFFAF4),
      error: Color(0xFFFFB4A9),
      onError: Color(0xFF8C1D18),
      errorContainer: Color(0xFFAD2C28),
      onErrorContainer: Color(0xFFFFDAD4),
      background: Color(0xFF1A1C1A),
      onBackground: Color(0xFFDBE5E1),
      surface: Color(0xFF1C1F1D),
      onSurface: Color(0xFFEFEFED),
      surfaceVariant: Color(0xFF5C645F),
      onSurfaceVariant: Color(0xFFDDE3DE),
      outline: Color(0xFFA5B5B0),
      outlineVariant: Color(0xFF5C645F),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFEFEFED),
      inverseOnSurface: Color(0xFF475B58),
      inversePrimary: Color(0xFF3B9D91),
      primaryFixed: Color(0xFF91F3E8),
      onPrimaryFixed: Color(0xFF00201D),
      primaryFixedDim: Color(0xFF75CEC3),
      onPrimaryFixedVariant: Color(0xFF00514A),
      secondaryFixed: Color(0xFFCAF7F1),
      onSecondaryFixed: Color(0xFF001F1B),
      secondaryFixedDim: Color(0xFF77D1C7),
      onSecondaryFixedVariant: Color(0xFF004B45),
      tertiaryFixed: Color(0xFFFFFAF4),
      onTertiaryFixed: Color(0xFF402100),
      tertiaryFixedDim: Color(0xFFFFF7F0),
      onTertiaryFixedVariant: Color(0xFF7E5D28),
      surfaceDim: Color(0xFF1C1F1D),
      surfaceBright: Color(0xFF2C3A36),
      surfaceContainerLowest: Color(0xFF131715),
      surfaceContainerLow: Color(0xFF212622),
      surfaceContainer: Color(0xFF252A26),
      surfaceContainerHigh: Color(0xFF2C322E),
      surfaceContainerHighest: Color(0xFF353B37),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF79D6CB),
      surfaceTint: Color(0xFF75CEC3),
      onPrimary: Color(0xFF002927),
      primaryContainer: Color(0xFF52968D),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFF7AD9CE),
      onSecondary: Color(0xFF00221F),
      secondaryContainer: Color(0xFF52A79E),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFFFFFBF9),
      onTertiary: Color(0xFF694000),
      tertiaryContainer: Color(0xFFF26F1B),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFFB4B4),
      onError: Color(0xFF5B1211),
      errorContainer: Color(0xFFE36F65),
      onErrorContainer: Color(0xFF000000),
      background: Color(0xFF1A1C1A),
      onBackground: Color(0xFFDBE5E1),
      surface: Color(0xFF1C1F1D),
      onSurface: Color(0xFFFFF9F5),
      surfaceVariant: Color(0xFF5C645F),
      onSurfaceVariant: Color(0xFFDDE9E2),
      outline: Color(0xFFB2D2C9),
      outlineVariant: Color(0xFFA1B9B1),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFEFEFED),
      inverseOnSurface: Color(0xFF2C322E),
      inversePrimary: Color(0xFF00625A),
      primaryFixed: Color(0xFF91F3E8),
      onPrimaryFixed: Color(0xFF001F1D),
      primaryFixedDim: Color(0xFF75CEC3),
      onPrimaryFixedVariant: Color(0xFF00413D),
      secondaryFixed: Color(0xFFCAF7F1),
      onSecondaryFixed: Color(0xFF001F1C),
      secondaryFixedDim: Color(0xFF77D1C7),
      onSecondaryFixedVariant: Color(0xFF003F3A),
      tertiaryFixed: Color(0xFFFFFAF4),
      onTertiaryFixed: Color(0xFF5C3500),
      tertiaryFixedDim: Color(0xFFFFF7F0),
      onTertiaryFixedVariant: Color(0xFF663D00),
      surfaceDim: Color(0xFF1C1F1D),
      surfaceBright: Color(0xFF2C3A36),
      surfaceContainerLowest: Color(0xFF131715),
      surfaceContainerLow: Color(0xFF212622),
      surfaceContainer: Color(0xFF252A26),
      surfaceContainerHigh: Color(0xFF2C322E),
      surfaceContainerHighest: Color(0xFF353B37),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFDDFFF1),
      surfaceTint: Color(0xFF75CEC3),
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFF79D6CB),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFFFFFBF1),
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFF7AD9CE),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFFFFFF98),
      onTertiary: Color(0xFF000000),
      tertiaryContainer: Color(0xFFFFFAF4),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFFFEF9),
      onError: Color(0xFF000000),
      errorContainer: Color(0xFFFFB4B4),
      onErrorContainer: Color(0xFF000000),
      background: Color(0xFF1A1C1A),
      onBackground: Color(0xFFDBE5E1),
      surface: Color(0xFF1C1F1D),
      onSurface: Color(0xFFFFFFFF),
      surfaceVariant: Color(0xFF5C645F),
      onSurfaceVariant: Color(0xFFFFF9F5),
      outline: Color(0xFFDDE9E2),
      outlineVariant: Color(0xFFDDE9E2),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFEFEFED),
      inverseOnSurface: Color(0xFF000000),
      inversePrimary: Color(0xFF006058),
      primaryFixed: Color(0xFF97F7EA),
      onPrimaryFixed: Color(0xFF000000),
      primaryFixedDim: Color(0xFF79D6CB),
      onPrimaryFixedVariant: Color(0xFF002927),
      secondaryFixed: Color(0xFFE3FDF6),
      onSecondaryFixed: Color(0xFF000000),
      secondaryFixedDim: Color(0xFF7AD9CE),
      onSecondaryFixedVariant: Color(0xFF00221F),
      tertiaryFixed: Color(0xFFFFFEFD),
      onTertiaryFixed: Color(0xFF000000),
      tertiaryFixedDim: Color(0xFFFFFAF4),
      onTertiaryFixedVariant: Color(0xFF694000),
      surfaceDim: Color(0xFF1C1F1D),
      surfaceBright: Color(0xFF2C3A36),
      surfaceContainerLowest: Color(0xFF131715),
      surfaceContainerLow: Color(0xFF212622),
      surfaceContainer: Color(0xFF252A26),
      surfaceContainerHigh: Color(0xFF2C322E),
      surfaceContainerHighest: Color(0xFF353B37),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
