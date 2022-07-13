import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentrejustaudio.dart';
import 'package:drip/pages/audio_player_bar.dart';
import 'package:drip/pages/audioplayerbar.dart';

import 'package:drip/pages/currentplaylist.dart';
import 'package:drip/pages/expanded_audio_bar.dart';
import 'package:drip/pages/settings.dart';
import 'package:drip/utils/responsive.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'datasources/audiofiles/audiocontrolcentre.dart';
import 'datasources/audiofiles/activeaudiodata.dart';

import 'navigation/navigationstacks.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as av;
import 'theme.dart';

const String appTitle = 'Drip';

bool darkMode = true;

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  ].contains(defaultTargetPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    // doWhenWindowReady(() {
    //   appWindow.minSize = const Size(540, 540);
    //   appWindow.size = const Size(900, 640);
    //   appWindow.alignment = Alignment.center;
    //   appWindow.show();
    //   appWindow.title = 'Drip';
    // });

    // SystemTheme.accentInstance;
    setPathUrlStrategy();

    await acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
          windowButtonVisibility: false);

      await windowManager.setSize(const Size(900, 650));
      await windowManager.setMinimumSize(const Size(540, 540));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
    });
  }

  if (Platform.isWindows) {
    await Hive.initFlutter('Drip');
  } else {
    await Hive.initFlutter();
  }

  await openHiveBox('settings');

  await openHiveBox('Favorite Songs');
  await openHiveBox('cache', limit: true);
  DartVLC.initialize();

  // if (Platform.isWindows) {
  //   await acrylic.Window.initialize();
  //   hotKeyManager.unregisterAll();
  //   await HotKeys.initialize();
  // }
  //await Window.initialize();
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/drip/$boxName.hive');
      lockFile = File('$dirPath/drip/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider<AudioControls>(
          //   create: (BuildContext context) {
          //     return AudioControls();
          //   },
          // ),
          ChangeNotifierProvider<ActiveAudioData>(
            create: (BuildContext context) {
              return ActiveAudioData();
            },
          ),
        ],
        child: ChangeNotifierProvider(
            create: (_) => AppTheme(),
            builder: (context, _) {
              final appTheme = context.watch<AppTheme>();
              return FluentApp(
                title: appTitle,
                themeMode: appTheme.mode,
                debugShowCheckedModeBanner: false,
                home: const MyHomePage(),
                // initialRoute: '/',
                // routes: {'/': (_) => const MyHomePage()},
                theme: ThemeData(
                  // scaffoldBackgroundColor: context.watch<ActiveAudioData>()
                  //   .albumExtracted
                  //   .toAccentColor(),

                  accentColor: appTheme.color,
                  // navigationPaneTheme: NavigationPaneThemeData(
                  //   backgroundColor:  Colors.transparent
                  // ),
                  brightness: appTheme.mode == ThemeMode.system
                      ? darkMode
                          ? Brightness.dark
                          : Brightness.light
                      : appTheme.mode == ThemeMode.dark
                          ? Brightness.dark
                          : Brightness.light,
                  visualDensity: VisualDensity.standard,
                  focusTheme: FocusThemeData(
                    glowFactor: is10footScreen() ? 2.0 : 0.0,
                  ),
                ),
              );
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;

  int index = 0;

  late PageController _pageController;
  late List<Widget> screens;

  bool sheetCollapsed = true;

  late SheetController _sheetController;

  final colorsController = ScrollController();
  final settingsController = ScrollController();

  Map<int?, GlobalKey?> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
  };

  @override
  void initState() {
    //windowManager.addListener(this);
    super.initState();

    index = 0;

    screens = [
      FirstPageStack(navigatorKey: navigatorKeys[0]),
      SecondPageStack(
          searchArgs: '', fromFirstPage: false, navigatorKey: navigatorKeys[1]),
      CurrentPlaylist(
        fromMainPage: true,
        navigatorKey: navigatorKeys[2],
      ),
      SettingsPage(
        navigatorKey: navigatorKeys[3],
      )
    ];
    _pageController = PageController(initialPage: index);

    _sheetController = SheetController();
  }

  bool onWillPop() {
    if (Navigator.of(context).canPop()) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    // windowManager.removeListener(this);
    colorsController.dispose();
    settingsController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return SafeArea(
      child: Stack(
        children: [
          NavigationView(
            appBar: NavigationAppBar(
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: IconButton(
                    onPressed: () async {
                      await Navigator.maybePop(
                          navigatorKeys[index]!.currentState!.context);
                    },
                    icon: const Icon(FluentIcons.back)),
              ),
              // title: Platform.isWindows
              //     ? const TopBar()
              //     : const SizedBox.shrink()

              // title: () {
              //   if (kIsWeb) return const Text(appTitle);
              //   return const DragToMoveArea(
              //     child: Align(
              //       alignment: AlignmentDirectional.centerStart,
              //       child: Text(appTitle),
              //     ),
              //   );
              // }(),
              actions:  WindowCaption(title: const Text(appTitle),brightness: FluentTheme.of(context).brightness)

              // kIsWeb
              //     ? null
              //     : DragToMoveArea(
              //       child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: const [Spacer(), WindowCaption()],
              //         ),
              //     ),
            ),
            pane: NavigationPane(
              selected: index,
              scrollController: mat.ScrollController(),
              onChanged: (i) {
                index = i;

                _pageController.animateToPage(index,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 400));
                setState(() {
                  if (!sheetCollapsed) {
                    _sheetController.collapse();
                    sheetCollapsed = true;
                  }
                });
              },
              size: const NavigationPaneSize(
                compactWidth: 60,
                openWidth: 200,
                openMinWidth: 200,
                openMaxWidth: 200,
              ),
              //header:

              // Container(
              //     height: kOneLineTileHeight,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              //     child: const Text(
              //       'Drip',
              //       style: TextStyle(fontSize: 20),
              //     )),
              displayMode: Responsive.isMobile(context)
                  ? PaneDisplayMode.top
                  : PaneDisplayMode.auto,
              // Platform.isWindows
              //     ? PaneDisplayMode.compact
              //     : PaneDisplayMode.top,
              indicator: () {
                switch (appTheme.indicator) {
                  case NavigationIndicators.end:
                    return const EndNavigationIndicator();
                  case NavigationIndicators.sticky:
                  default:
                    return const StickyNavigationIndicator();
                }
              }(),
              items: [
                // It doesn't look good when resizing from compact to open
                // PaneItemHeader(header: Text('User Interaction')),
                PaneItem(
                  icon: const Icon(FluentIcons.home, size: 20),
                  title: const Text('Home'),
                ),
                PaneItem(
                  icon: const Icon(FluentIcons.search, size: 20),
                  title: const Text('Search'),
                ),
                // PaneItem(
                //   icon: const Icon(FluentIcons.personalize),
                //   title: const Text('Artists'),
                // ),
                PaneItemSeparator(),
                PaneItem(
                  icon: const mat.Icon(FluentIcons.playlist_music, size: 20),
                  title: const Text('Play queue'),
                ),
                PaneItemSeparator(),
                PaneItem(
                  icon: const Icon(FluentIcons.settings, size: 20),
                  title: const Text('Settings'),
                ),
                PaneItemAction(
                  icon: const Icon(FluentIcons.open_source, size: 20),
                  title: const Text('Source code'),
                  onTap: () {
                    launch('https://github.com/Spsden/Drip.git');
                  },
                ),
              ],
              autoSuggestBoxReplacement: const Icon(FluentIcons.search),
            ),
            content: PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
            ),
          ),
          SlidingSheet(
            closeOnBackButtonPressed: true,
            color: Colors.transparent,

            closeOnBackdropTap: true,
            duration: const Duration(milliseconds: 200),
            controller: _sheetController,
            //elevation: 8,
            cornerRadius: 3,
            snapSpec: SnapSpec(
              snap: sheetCollapsed,
              snappings: [100, 200, double.infinity],
              positioning: SnapPositioning.pixelOffset,
            ),
            builder: (context, state) {
              return ClipRect(
                child: Container(
                  height: MediaQuery.of(context).size.height - 100,
                  color: Colors.transparent,
                  child: const ExpandedAudioBar(),
                ),
              );
            },
            footerBuilder: (context, state) {
              return Container(
                alignment: Alignment.center,
                height: 100,
                child: Stack(children: [
                  ClipRect(
                    child: mat.Material(
                      child: Acrylic(
                        elevation: 10,
                        shape: mat.RoundedRectangleBorder(
                            borderRadius: mat.BorderRadius.circular(8)),
                        tint: context
                            .watch<ActiveAudioData>()
                            .albumExtracted
                            .toAccentColor(),
                        child: const SizedBox(
                         // width: MediaQuery.of(context).size.width ,
                          height: 100,
                          child: BottomBar(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 3,
                    child: IconButton(
                      icon: const Icon(FluentIcons.playlist_music),
                      onPressed: () {
                        setState(() {
                          if (sheetCollapsed) {
                            _sheetController.expand();
                            sheetCollapsed = false;
                          } else {
                            _sheetController.collapse();
                            sheetCollapsed = true;
                          }
                        });
                      },

                      // hoverColor: Colors.red.shade400,
                    ),
                  )
                ]),
              );
            },
          ),
          Positioned(
            bottom: 70.5,
            left: 5,
            right: 5,
            child: ValueListenableBuilder<ProgressBarState>(
              valueListenable: progressNotifier,
              builder: (_, value, __) {
                return av.ProgressBar(
                  thumbGlowColor: Colors.blue,
                  baseBarColor:
                      context.watch<AppTheme>().color.withOpacity(0.3),
                  thumbColor: context.watch<AppTheme>().color,
                  progressBarColor: context.watch<AppTheme>().color,
                  progress: value.current,
                  // buffered: value.buffered,
                  total: value.total,
                  onSeek: (position) => AudioControlClass.seek(position),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

// class TopBar extends StatelessWidget {
//   const TopBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var color = context.watch<AppTheme>().mode == ThemeMode.dark ||
//             context.watch<AppTheme>().mode == ThemeMode.system
//         ? Colors.grey[30]
//         : Colors.grey[150];
//
//     return SizedBox(
//       height: 35.0,
//       child: WindowTitleBarBox(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//                 child: MoveWindow(
//               child: Container(
//                 margin: const mat.EdgeInsets.only(top: 8, left: 8),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/driplogocircle.png',
//                       filterQuality: FilterQuality.high,
//                       alignment: Alignment.center,
//                       height: 30,
//                       width: 30,
//
//                       //height: 10,
//                       //width: 10,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       'Drip',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//             Expanded(child: MoveWindow()),
//             Row(
//               children: [
//                 MinimizeWindowButton(
//                   colors: WindowButtonColors(iconNormal: color),
//                 ),
//                 MaximizeWindowButton(
//                     colors: WindowButtonColors(iconNormal: color)),
//                 CloseWindowButton(colors: WindowButtonColors(iconNormal: color))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// GetIt locator = GetIt.instance;
//
// void setupLocator() {
//   locator.registerLazySingleton(() => PopNavigationService());
// }
