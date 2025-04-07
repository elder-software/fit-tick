import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280838728),
      surfaceTint: Color(4280838728),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289589958),
      onPrimaryContainer: Color(4278198545),
      secondary: Color(4280706185),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291421951),
      onSecondaryContainer: Color(4278197807),
      tertiary: Color(4287123742),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958275),
      onTertiaryContainer: Color(4281275648),
      error: Color(4287646278),
      onError: Color(4294967295),
      errorContainer: Color(4294957783),
      onErrorContainer: Color(4282059017),
      background: Color(4294376436),
      onBackground: Color(4279704857),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      surfaceVariant: Color(4292797419),
      onSurfaceVariant: Color(4282533710),
      outline: Color(4285757311),
      outlineVariant: Color(4290955215),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4293914871),
      inversePrimary: Color(4287813035),
      primaryFixed: Color(4289589958),
      onPrimaryFixed: Color(4278198545),
      primaryFixedDim: Color(4287813035),
      onPrimaryFixedVariant: Color(4278604338),
      secondaryFixed: Color(4291421951),
      onSecondaryFixed: Color(4278197807),
      secondaryFixedDim: Color(4288007671),
      onSecondaryFixedVariant: Color(4278209391),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4281275648),
      tertiaryFixedDim: Color(4294948733),
      onTertiaryFixedVariant: Color(4285282823),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717492),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278209838),
      surfaceTint: Color(4280838728),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282417501),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278208361),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282415777),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284954115),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288898866),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285411116),
      onError: Color(4294967295),
      errorContainer: Color(4289355611),
      onErrorContainer: Color(4294967295),
      background: Color(4294376436),
      onBackground: Color(4279704857),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      surfaceVariant: Color(4292797419),
      onSurfaceVariant: Color(4282270538),
      outline: Color(4284178279),
      outlineVariant: Color(4285954946),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4293914871),
      inversePrimary: Color(4287813035),
      primaryFixed: Color(4282417501),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280641606),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282415777),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280443270),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288898866),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286992156),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717492),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278200342),
      surfaceTint: Color(4280838728),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278209838),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278199609),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278208361),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281866752),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284954115),
      onTertiaryContainer: Color(4294967295),
      error: Color(4282650383),
      onError: Color(4294967295),
      errorContainer: Color(4285411116),
      onErrorContainer: Color(4294967295),
      background: Color(4294376436),
      onBackground: Color(4279704857),
      surface: Color(4294507007),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292797419),
      onSurfaceVariant: Color(4280230954),
      outline: Color(4282270538),
      outlineVariant: Color(4282270538),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4290247632),
      primaryFixed: Color(4278209838),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278203422),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4278208361),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278202440),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284954115),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282917632),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717492),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287813035),
      surfaceTint: Color(4287813035),
      onPrimary: Color(4278204705),
      primaryContainer: Color(4278604338),
      onPrimaryContainer: Color(4289589958),
      secondary: Color(4288007671),
      onSecondary: Color(4278203470),
      secondaryContainer: Color(4278209391),
      onSecondaryContainer: Color(4291421951),
      tertiary: Color(4294948733),
      onTertiary: Color(4283246080),
      tertiaryContainer: Color(4285282823),
      onTertiaryContainer: Color(4294958275),
      error: Color(4294947757),
      onError: Color(4283899419),
      errorContainer: Color(4285739824),
      onErrorContainer: Color(4294957783),
      background: Color(4279178513),
      onBackground: Color(4292863197),
      surface: Color(4279309336),
      onSurface: Color(4292993768),
      surfaceVariant: Color(4282533710),
      onSurfaceVariant: Color(4290955215),
      outline: Color(4287402393),
      outlineVariant: Color(4282533710),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inverseOnSurface: Color(4281217077),
      inversePrimary: Color(4280838728),
      primaryFixed: Color(4289589958),
      onPrimaryFixed: Color(4278198545),
      primaryFixedDim: Color(4287813035),
      onPrimaryFixedVariant: Color(4278604338),
      secondaryFixed: Color(4291421951),
      onSecondaryFixed: Color(4278197807),
      secondaryFixedDim: Color(4288007671),
      onSecondaryFixedVariant: Color(4278209391),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4281275648),
      tertiaryFixedDim: Color(4294948733),
      onTertiaryFixedVariant: Color(4285282823),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4288076208),
      surfaceTint: Color(4287813035),
      onPrimary: Color(4278197005),
      primaryContainer: Color(4284325496),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4288270844),
      onSecondary: Color(4278196263),
      secondaryContainer: Color(4284389310),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294950281),
      onTertiary: Color(4280750080),
      tertiaryContainer: Color(4291002955),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949300),
      onError: Color(4281533445),
      errorContainer: Color(4291525493),
      onErrorContainer: Color(4278190080),
      background: Color(4279178513),
      onBackground: Color(4292863197),
      surface: Color(4279309336),
      onSurface: Color(4294638335),
      surfaceVariant: Color(4282533710),
      onSurfaceVariant: Color(4291283923),
      outline: Color(4288652203),
      outlineVariant: Color(4286546827),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inverseOnSurface: Color(4280756783),
      inversePrimary: Color(4278801203),
      primaryFixed: Color(4289589958),
      onPrimaryFixed: Color(4278195465),
      primaryFixedDim: Color(4287813035),
      onPrimaryFixedVariant: Color(4278206245),
      secondaryFixed: Color(4291421951),
      onSecondaryFixed: Color(4278194976),
      secondaryFixedDim: Color(4288007671),
      onSecondaryFixedVariant: Color(4278205014),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4280224768),
      tertiaryFixedDim: Color(4294948733),
      onTertiaryFixedVariant: Color(4283837184),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4293853169),
      surfaceTint: Color(4287813035),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288076208),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294573055),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4288270844),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966008),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294950281),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949300),
      onErrorContainer: Color(4278190080),
      background: Color(4279178513),
      onBackground: Color(4292863197),
      surface: Color(4279309336),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282533710),
      onSurfaceVariant: Color(4294638335),
      outline: Color(4291283923),
      outlineVariant: Color(4291283923),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278202652),
      primaryFixed: Color(4289853131),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288076208),
      onPrimaryFixedVariant: Color(4278197005),
      secondaryFixed: Color(4292012799),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4288270844),
      onSecondaryFixedVariant: Color(4278196263),
      tertiaryFixed: Color(4294959565),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294950281),
      onTertiaryFixedVariant: Color(4280750080),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
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


  List<ExtendedColor> get extendedColors => [
  ];
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
