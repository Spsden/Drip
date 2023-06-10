import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive/hive.dart';

import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;




enum NavigationIndicators { sticky, end }
//enum CardColors {Colors.grey[150] }

class AppTheme extends ChangeNotifier {
  String themeMode =
      Hive.box('settings').get('themeMode', defaultValue: 'system') ;

  String accentColor =
      Hive.box('settings').get('accentColor', defaultValue: 'System') ;

  AppTheme() {
    @override
    void dispose() {}
  }

  late Color _albumArtColor = Colors.blue;

  Color get albumArtColor => _albumArtColor;


  set albumArtColor(Color color) {
    _albumArtColor = color;
    print(_albumArtColor.toString());
    notifyListeners();
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

      case 'Magneta':
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

  late AccentColor _color = getAccentColorFromHive(accentColor);

  AccentColor get color => _color;

  set color(AccentColor color) {
    _color = color;
    //Hive.box('settings').put('accentColor', color.toString());
  //  print(color.toString());
    notifyListeners();
  }

  Color _cardColor = Colors.grey[150];

  Color get cardColor => _cardColor;

  set cardCol(Color color) {
    _cardColor = cardColor;
    notifyListeners();
  }

//ThemeSetters

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

  late ThemeMode _mode = getThemeModeFromHive(themeMode);
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    Hive.box('settings').put('themeMode', mode.name);
    //print(Hive.box('settings').get('themeMode'));
    notifyListeners();
  }




  PaneDisplayMode _displayMode = PaneDisplayMode.auto;

  PaneDisplayMode get displayMode => _displayMode;

  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;

  NavigationIndicators get indicator => _indicator;

  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    notifyListeners();
  }

 // late WindowEffect winEffect = WindowEffect.tabbed;

  WindowEffect _windowEffect = WindowEffect.tabbed;

  WindowEffect get windowEffect => _windowEffect;

  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    notifyListeners();
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }




}

final themeProvider = ChangeNotifierProvider<AppTheme>((ref) => AppTheme());

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
