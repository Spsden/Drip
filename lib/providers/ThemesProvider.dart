import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_theme/system_theme.dart';

final themesProvider = StateNotifierProvider<ThemesProvider, AppTheme>((ref) {
  return ThemesProvider();
});

ThemeMode getThemeModeFromHive(String themeMode) {
  switch (themeMode) {
    case 'dark':
      return ThemeMode.dark;

    case 'light':
      return ThemeMode.light;

    case 'system':
      return ThemeMode.system;

    default:
      return ThemeMode.system;
  }
}

AccentColor getAccentColorFromHive(String accentColor) {
  switch (accentColor) {
    case 'System':
      return SystemTheme.accentColor.accent.toAccentColor();

    case 'Yellow':
      return Colors.yellow;

    case 'Orange':
      return Colors.orange;

    case 'Red':
      return Colors.red;

    case 'Magenta':
      return Colors.magenta;

    case 'Purple':
      return Colors.purple;
    case 'Blue':
      return Colors.blue;
    case 'Teal':
      return Colors.teal;
    case 'Green':
      return Colors.green;

    default:
      return SystemTheme.accentColor.accent.toAccentColor();
  }
}

class ThemesProvider extends StateNotifier<AppTheme> {
  ThemesProvider()
      : super(AppTheme(
            themeMode: getThemeModeFromHive(
                Hive.box('settings').get('themeMode', defaultValue: 'system')),
            accentColor:
            Colors.blue,
            // getAccentColorFromHive(Hive.box('settings')
            //     .get('accentColor', defaultValue: 'System') ),
            albumArtColor: Colors.blue,
            windowEffect: WindowEffect.tabbed));

  void changeTheme(ThemeMode themeMode) {
    state.themeMode = themeMode;

    Hive.box('settings').put('themeMode', themeMode.name);
  }

  void setAlbumArtColor(Color color) {
    state.albumArtColor = color;
  }

  void setAccentColor(AccentColor color) {
    state.accentColor = color;
    Hive.box('settings').put('accentColor', color.toString());
  }

  void setWindowEffect(WindowEffect windowEffect){
    state.windowEffect = windowEffect;
    if (kDebugMode) {
      print('run');
    }
  }
}

class AppTheme {
  ThemeMode themeMode;

  AccentColor accentColor;

  Color albumArtColor;

  WindowEffect windowEffect;

  AppTheme(
      {required this.themeMode,
      required this.accentColor,
      required this.albumArtColor,
      required this.windowEffect});
}

class Themes {
  static final lightTheme = FluentThemeData(
    brightness: Brightness.light,
    cardColor: Colors.grey[30],

    // For light theming
    // scaffoldBackgroundColor: Colors.grey.,
    // appBarTheme: AppBarTheme(
    //     backgroundColor: Colors.grey.shade100,
    //     titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
    //     centerTitle: false),
// you can add more
  );

  static final darkTheme = FluentThemeData(
      brightness: Brightness.dark,
      cardColor: Colors.grey[150].withOpacity(0.4) // For dark theming
      // scaffoldBackgroundColor: Colors.grey.shade900,
      // appBarTheme: const AppBarTheme(
      //     backgroundColor: Color(0x00049fb6),
      //     titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      //     centerTitle: false),
// you can add more
      );
}
