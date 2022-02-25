import 'package:flutter/foundation.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import '../main.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

enum Color {
  black,
  white,
  sysTheme,
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    final tooltipThemeData = TooltipThemeData(decoration: () {
      const radius = BorderRadius.zero;
      final shadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 10.0,
        ),
      ];
      final border = Border.all(color: Colors.grey[100], width: 0.5);
      if (FluentTheme.of(context).brightness == Brightness.light) {
        return BoxDecoration(
          color: Colors.white,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      } else {
        return BoxDecoration(
          color: Colors.grey,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      }
    }());

    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    return ScaffoldPage(
      header: const PageHeader(
          title: Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      )),
      content: ListView(
        padding: EdgeInsets.only(
          bottom: kPageDefaultVerticalPadding,
          left: PageHeader.horizontalPadding(context),
          right: PageHeader.horizontalPadding(context),
        ),
        controller: ScrollController(),
        children: [
          Text('Theme mode',
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          ...List.generate(ThemeMode.values.length, (index) {
            final mode = ThemeMode.values[index];
            // final color = mode == ThemeMode.dark ? Colors.grey[50] : Colors.grey[150];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.mode == mode,
                onChanged: (value) {
                  if (value) {
                    appTheme.mode = mode;

                    //appTheme.cardCol = color;
                  }
                },
                content: Text('$mode'.replaceAll('ThemeMode.', '')),
              ),
            );
          }),
          biggerSpacer,
          Text(
            'Navigation Pane Display Mode ',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          Text(
            'Keep it at compact for optimised scaling \n Buggy now :(  ',
            style: FluentTheme.of(context).typography.caption,
          ),
          spacer,
          ...List.generate(PaneDisplayMode.values.length, (index) {
            final mode = PaneDisplayMode.values[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.displayMode == mode,
                onChanged: (value) {
                  if (value) appTheme.displayMode = mode;
                },
                content: Text(
                  mode.toString().replaceAll('PaneDisplayMode.', ''),
                ),
              ),
            );
          }),
          biggerSpacer,
          Text('Navigation Indicator',
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          ...List.generate(NavigationIndicators.values.length, (index) {
            final mode = NavigationIndicators.values[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.indicator == mode,
                onChanged: (value) {
                  if (value) appTheme.indicator = mode;
                },
                content: Text(
                  mode.toString().replaceAll('NavigationIndicators.', ''),
                ),
              ),
            );
          }),
          biggerSpacer,
          Text('Accent Color',
              style: FluentTheme.of(context).typography.subtitle),
          spacer,
          Wrap(children: [
            Tooltip(
              style: tooltipThemeData,
              child: _buildColorBlock(appTheme, systemAccentColor),
              message: accentColorNames[0],
            ),
            ...List.generate(Colors.accentColors.length, (index) {
              final color = Colors.accentColors[index];
              return Tooltip(
                style: tooltipThemeData,
                message: accentColorNames[index + 1],
                child: _buildColorBlock(appTheme, color),
              );
            }),
          ]),
          if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) ...[
            biggerSpacer,
            Text('Window Transparency',
                style: FluentTheme.of(context).typography.subtitle),
            spacer,
            ...List.generate(flutter_acrylic.WindowEffect.values.length,
                (index) {
              final mode = flutter_acrylic.WindowEffect.values[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.acrylicEffect == mode,
                  onChanged: (value) {
                    if (value) {
                      appTheme.acrylicEffect = mode;
                      flutter_acrylic.Window.setEffect(
                        effect: mode,
                        color: FluentTheme.of(context)
                            .acrylicBackgroundColor
                            .withOpacity(0.2),
                        dark: darkMode,
                      );
                    }
                  },
                  content: Text(
                    mode.toString().replaceAll('AcrylicEffect.', ''),
                  ),
                ),
              );
            }),
            biggerSpacer,
            Text('About', style: FluentTheme.of(context).typography.subtitle),
            spacer,
            Table(
              children: [
                const TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text('Version'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text('0.1.0-alpha'),
                  )
                ]),

              ],

            ),
            const Text(
              'Contact',
            ),

            Container(
              margin: EdgeInsets.only(top:5),
              height: 40,
              width: 40,
              child: Row(
                crossAxisAlignment: mat.CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Image.asset('assets/githubDarkMode.png'),
                      onPressed: () {
                        launch('https://github.com/Spsden/Drip.git');
                      }),

                  IconButton(
                      icon: Image.asset('assets/telegram.png'),
                      onPressed: () {
                        launch('https://t.me/Regiment_Raucous');
                      }),
                ],
              ),
            ),

            biggerSpacer,
            biggerSpacer
          ],
        ],
      ),
    );
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.color = color;
        },
        style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
        child: Container(
          height: 40,
          width: 40,
          color: color,
          alignment: Alignment.center,
          child: appTheme.color == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}

//
// class Settings extends StatelessWidget {
//   const Settings({Key? key, this.controller}) : super(key: key);
//
//   final ScrollController? controller;
//
//   @override
//   Widget build(BuildContext context) {
//     final appTheme = context.watch<AppTheme>();
//     final tooltipThemeData = TooltipThemeData(decoration: () {
//       const radius = BorderRadius.zero;
//       final shadow = [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.2),
//           offset: const Offset(1, 1),
//           blurRadius: 10.0,
//         ),
//       ];
//       final border = Border.all(color: Colors.grey[100], width: 0.5);
//       if (FluentTheme.of(context).brightness == Brightness.light) {
//         return BoxDecoration(
//           color: Colors.white,
//           borderRadius: radius,
//           border: border,
//           boxShadow: shadow,
//         );
//       } else {
//         return BoxDecoration(
//           color: Colors.grey,
//           borderRadius: radius,
//           border: border,
//           boxShadow: shadow,
//         );
//       }
//     }());
//
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//     return ScaffoldPage(
//       header: const PageHeader(
//           title: Text(
//         'Settings',
//         style: TextStyle(fontSize: 40),
//       )),
//       content: ListView(
//         padding: EdgeInsets.only(
//           bottom: kPageDefaultVerticalPadding,
//           left: PageHeader.horizontalPadding(context),
//           right: PageHeader.horizontalPadding(context),
//         ),
//         controller: controller,
//         children: [
//           Text('Theme mode',
//               style: FluentTheme.of(context).typography.subtitle),
//           spacer,
//           ...List.generate(ThemeMode.values.length, (index) {
//             final mode = ThemeMode.values[index];
//             // final color = mode == ThemeMode.dark ? Colors.grey[50] : Colors.grey[150];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: RadioButton(
//                 checked: appTheme.mode == mode,
//                 onChanged: (value) {
//                   if (value) {
//                     appTheme.mode = mode;
//
//                     //appTheme.cardCol = color;
//                   }
//                 },
//                 content: Text('$mode'.replaceAll('ThemeMode.', '')),
//               ),
//             );
//           }),
//           biggerSpacer,
//           Text(
//             'Navigation Pane Display Mode ',
//             style: FluentTheme.of(context).typography.subtitle,
//           ),
//           Text(
//             'Keep it at compact for optimised scaling \n Buggy now :(  ',
//             style: FluentTheme.of(context).typography.caption,
//           ),
//           spacer,
//           ...List.generate(PaneDisplayMode.values.length, (index) {
//             final mode = PaneDisplayMode.values[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: RadioButton(
//                 checked: appTheme.displayMode == mode,
//                 onChanged: (value) {
//                   if (value) appTheme.displayMode = mode;
//                 },
//                 content: Text(
//                   mode.toString().replaceAll('PaneDisplayMode.', ''),
//                 ),
//               ),
//             );
//           }),
//           biggerSpacer,
//           Text('Navigation Indicator',
//               style: FluentTheme.of(context).typography.subtitle),
//           spacer,
//           ...List.generate(NavigationIndicators.values.length, (index) {
//             final mode = NavigationIndicators.values[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: RadioButton(
//                 checked: appTheme.indicator == mode,
//                 onChanged: (value) {
//                   if (value) appTheme.indicator = mode;
//                 },
//                 content: Text(
//                   mode.toString().replaceAll('NavigationIndicators.', ''),
//                 ),
//               ),
//             );
//           }),
//           biggerSpacer,
//           Text('Accent Color',
//               style: FluentTheme.of(context).typography.subtitle),
//           spacer,
//           Wrap(children: [
//             Tooltip(
//               style: tooltipThemeData,
//               child: _buildColorBlock(appTheme, systemAccentColor),
//               message: accentColorNames[0],
//             ),
//             ...List.generate(Colors.accentColors.length, (index) {
//               final color = Colors.accentColors[index];
//               return Tooltip(
//                 style: tooltipThemeData,
//                 message: accentColorNames[index + 1],
//                 child: _buildColorBlock(appTheme, color),
//               );
//             }),
//           ]),
//           if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) ...[
//             biggerSpacer,
//             Text('Window Transparency',
//                 style: FluentTheme.of(context).typography.subtitle),
//             spacer,
//             ...List.generate(flutter_acrylic.WindowEffect.values.length,
//                 (index) {
//               final mode = flutter_acrylic.WindowEffect.values[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: RadioButton(
//                   checked: appTheme.acrylicEffect == mode,
//                   onChanged: (value) {
//                     if (value) {
//                       appTheme.acrylicEffect = mode;
//                       flutter_acrylic.Window.setEffect(
//                         effect: mode,
//                         color: FluentTheme.of(context)
//                             .acrylicBackgroundColor
//                             .withOpacity(0.2),
//                         dark: darkMode,
//                       );
//                     }
//                   },
//                   content: Text(
//                     mode.toString().replaceAll('AcrylicEffect.', ''),
//                   ),
//                 ),
//               );
//             }),
//             biggerSpacer,
//             biggerSpacer
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Button(
//         onPressed: () {
//           appTheme.color = color;
//         },
//         style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
//         child: Container(
//           height: 40,
//           width: 40,
//           color: color,
//           alignment: Alignment.center,
//           child: appTheme.color == color
//               ? Icon(
//                   FluentIcons.check_mark,
//                   color: color.basedOnLuminance(),
//                   size: 22.0,
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }
