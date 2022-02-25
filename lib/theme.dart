import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

enum NavigationIndicators { sticky, end }
//enum CardColors {Colors.grey[150] }

class AppTheme extends ChangeNotifier {

 bool _isDark = Hive.box('settings').get('darkMode',defaultValue: true ) as bool;

// Color getColor(String)







  Color? _albumArtColor = Colors.transparent;
  Color? get albumArtColor => _albumArtColor;
   set albumArtColor(Color? color){
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
  set cardCol(Color color){
    _cardColor = cardColor;
    notifyListeners();
  }




  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;

    if(ThemeMode == ThemeMode.dark){
      Hive.box('settings').put('darkMode', true);
    }
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






