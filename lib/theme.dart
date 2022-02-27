
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

enum NavigationIndicators { sticky, end }
//enum CardColors {Colors.grey[150] }

class AppTheme extends ChangeNotifier {

  bool _isDark =
  Hive.box('settings').get('darkMode', defaultValue: true) as bool;

  String themeMode = Hive.box('settings').get('themeMode',defaultValue: 'system') as String;


  bool _useSystemTheme =
  Hive.box('settings').get('useSystemTheme', defaultValue: false) as bool;

  String accentColor =
  Hive.box('settings').get('themeColor', defaultValue: 'Teal') as String;



  AppTheme(){

    @override
    void dispose(){

    }
  }








  Color? _albumArtColor = Colors.transparent;

  Color? get albumArtColor => _albumArtColor;

  set albumArtColor(Color? color) {
    _albumArtColor = color;

    print(_albumArtColor.toString());
    notifyListeners();
  }

  AccentColor _color = systemAccentColor;
  AccentColor get color => _color;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }



  Color _cardColor = Colors.grey[150];
  Color get cardColor => _cardColor;
  set cardCol(Color color) {
    _cardColor = cardColor;
    notifyListeners();
  }





  ThemeMode getThemeModeFromHive(String themeMode){
    switch(themeMode){
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





  late ThemeMode _mode = getThemeModeFromHive(themeMode) ;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {

    _mode = mode;
    Hive.box('settings').put('themeMode', mode.name);
    print(Hive.box('settings').get('themeMode'));
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

  flutter_acrylic.WindowEffect _acrylicEffect =
      flutter_acrylic.WindowEffect.disabled;

  flutter_acrylic.WindowEffect get acrylicEffect => _acrylicEffect;

  set acrylicEffect(flutter_acrylic.WindowEffect acrylicEffect) {
    _acrylicEffect = acrylicEffect;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentInstance.darkest,
      'darker': SystemTheme.accentInstance.darker,
      'dark': SystemTheme.accentInstance.dark,
      'normal': SystemTheme.accentInstance.accent,
      'light': SystemTheme.accentInstance.light,
      'lighter': SystemTheme.accentInstance.lighter,
      'lightest': SystemTheme.accentInstance.lightest,
    });
  }
  return Colors.blue;


}









