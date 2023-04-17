import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: FlexThemeData.light(
      scheme: FlexScheme.aquaBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts.merriweatherSans().fontFamily,
      appBarBackground: FlexColorScheme.light().appBarBackground,
    ),
    AppTheme.darkTheme: FlexThemeData.dark(
      scheme: FlexScheme.aquaBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      appBarBackground: FlexColorScheme.dark().appBarBackground,
    ),
  };
}




// final ThemeData lightTheme = FlexThemeData.light(
//   scheme: FlexScheme.aquaBlue,
//   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//   blendLevel: 7,
//   subThemesData: const FlexSubThemesData(
//     blendOnLevel: 10,
//     blendOnColors: false,
//     useM2StyleDividerInM3: true,
//   ),
//   visualDensity: FlexColorScheme.comfortablePlatformDensity,
//   useMaterial3: true,
//   swapLegacyOnMaterial3: true,
//   // To use the playground font, add GoogleFonts package and uncomment
//   fontFamily: GoogleFonts.notoSans().fontFamily,
//   appBarBackground: FlexColorScheme.light().appBarBackground,
// );
// final ThemeData darkTheme = FlexThemeData.dark(
//   scheme: FlexScheme.aquaBlue,
//   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//   blendLevel: 13,
//   subThemesData: const FlexSubThemesData(
//     blendOnLevel: 20,
//     useM2StyleDividerInM3: true,
//   ),
//   visualDensity: FlexColorScheme.comfortablePlatformDensity,
//   useMaterial3: true,
//   swapLegacyOnMaterial3: true,
//   fontFamily: GoogleFonts.notoSans().fontFamily,
//   appBarBackground: FlexColorScheme.dark().appBarBackground,
// );