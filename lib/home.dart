import 'package:drip/home_screen.dart';
import 'package:drip/pages/splash_screen.dart';
import 'package:drip/theme.dart';
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FluentApp(

        title: 'Drip',
        themeMode: ref.watch(themeProvider).mode,
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData(
          accentColor: ref.watch(themeProvider).color,
          visualDensity: VisualDensity.standard,
          // focusTheme: FocusThemeData(
          //   glowFactor: is10footScreen() ? 2.0 : 0.0,
          // ),
        ),
        darkTheme: FluentThemeData(


          brightness: Brightness.dark,
          accentColor: ref.watch(themeProvider).color,
          visualDensity: VisualDensity.standard,
          // focusTheme: FocusThemeData(
          //   glowFactor: is10footScreen() ? 2.0 : 0.0,
          // ),
        ),
        home:  const SplashScreen());
  }
}