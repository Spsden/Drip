
import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/pages/audioplayerbar.dart';
import 'package:drip/pages/common/musiclist.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/explorepage.dart';
import 'package:drip/pages/playlistmain.dart';
import 'package:drip/pages/settings.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'datasources/audiofiles/audiocontrolcentre.dart';
import 'datasources/audiofiles/audiodata.dart';
import 'navigation/navigationstacks.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as av;
import 'theme.dart';

const String appTitle = 'Drip';

 bool darkMode = true;

/// Checks if the current environment is a desktop environment.
// bool get isDesktop {
//   if (kIsWeb) return false;
//   return [
//     TargetPlatform.windows,
//     TargetPlatform.linux,
//     TargetPlatform.macOS,
//   ].contains(defaultTargetPlatform);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await DesktopWindow.setMinWindowSize(const Size(480, 540));
   // DesktopWindow.setWindowSize(Size(755,545));




  setPathUrlStrategy();

  if (Platform.isWindows) {
    await Hive.initFlutter('Drip');
  } else {
    await Hive.initFlutter();
  }

  await openHiveBox('settings');
  await openHiveBox('Favorite Songs');
  await openHiveBox('cache', limit: true);
  DartVLC.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isWindows){
  //   await Window.initialize();
  //
  // }
  await Window.initialize();
  //WidgetsFlutterBinding.ensureInitialized();
  //await Window.initialize();
  //LWM.initialize();
  runApp(const MyApp());

  // The platforms the plugin support (01/04/2021 - DD/MM/YYYY):
  //   - Windows
  //   - Web
  //   - Android
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    darkMode = await SystemTheme.darkMode;
    await SystemTheme.accentInstance.load();
  } else {
    darkMode = true;
  }
  if (!kIsWeb &&
      [TargetPlatform.windows, TargetPlatform.linux]
          .contains(defaultTargetPlatform)) {
    //await flutter_acrylic.Window.initialize();
  }

  runApp(const MyApp());

  // if (isDesktop) {
  //   doWhenWindowReady(() {
  //     final win = appWindow;
  //     win.minSize = const Size(410, 540);
  //     win.size = const Size(755, 545);
  //     win.alignment = Alignment.center;
  //     win.title = appTitle;
  //     win.show();
  //   });
  // }
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/mibe/$boxName.hive');
      lockFile = File('$dirPath/mibd/$boxName.lock');
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

    return MultiProvider(providers: [
      ChangeNotifierProvider<PlayerNotifiers>(
        create: (BuildContext context) {
          return PlayerNotifiers();
        },
      ),
      ChangeNotifierProvider<ActiveAudioData>(
        create: (BuildContext context) {
          return ActiveAudioData();
        },
      ),
      // ChangeNotifierProvider<MusicListDataManagement>(
      //   create: (BuildContext context) {
      //     return MusicListDataManagement();
      //   },
      // ),
      // ChangeNotifierProvider<AppTheme>(
      //   create: (BuildContext context) {
      //     return AppTheme();
      //   },
      // ),

    ]
    ,
    child:
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {'/': (_) => const MyHomePage()},
          theme: ThemeData(
            accentColor: appTheme.color,
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
          ));


  })
    );}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;

  int index = 0;
  late int _selectedIndex;

  late PageController _pageController;
  late List<Widget> screens;

  bool sheetCollapsed = true;
  late SheetController _sheetcontroller;

  final colorsController = ScrollController();
  final settingsController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    _selectedIndex = 0;
    screens = [
      const FirstPageStack(),
      //const YouTubeHomeScreen(),
      const SecondPageStack(),

      const PlayListMain(),


      Settings(controller: settingsController,)
    ];
    _pageController = PageController(initialPage: _selectedIndex);


    // _audioPlayerControls = AudioPlayerControls();
    _sheetcontroller = SheetController();
  }

  @override
  void dispose() {
    colorsController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      appBar: const NavigationAppBar(

        title: TopBar()

      ),
      // appBar: NavigationAppBar(
      //   // height: !kIsWeb ? appWindow.titleBarHeight : 31.0,
      //   title: () {
      //     if (kIsWeb) return const Text(appTitle);
      //     return MoveWindow(
      //       child: const Align(
      //         alignment: Alignment.centerLeft,
      //         child: Text(appTitle),
      //       ),
      //     );
      //   }(),
      //   actions: kIsWeb
      //       ? null
      //       : MoveWindow(
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: const [Spacer(), WindowButtons()],
      //           ),
      //         ),
      // ),
      pane: NavigationPane(

        selected: _selectedIndex,
        onChanged: (i) {
          index = i;
          _selectedIndex = i;
          _pageController.animateToPage(index,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 400));
          setState(() {

          });

        } ,
        //setState(() => index = i),
        size: const NavigationPaneSize(
          openWidth: 200,
          openMinWidth: 200,
          openMaxWidth: 200,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
          child: const Text('Drip',
          style:TextStyle(
            fontSize: 20
          ) ,)
        ),
        displayMode: PaneDisplayMode.compact,
        indicatorBuilder: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return NavigationIndicator.end;
            case NavigationIndicators.sticky:
            default:
              return NavigationIndicator.sticky;
          }
        }(),
        items: [
          // It doesn't look good when resizing from compact to open
          // PaneItemHeader(header: Text('User Interaction')),
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.search),
            title: const Text('Search'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.playlist_music),
            title: const Text('Song'),
          ),
          PaneItemSeparator(),

        ],
        // autoSuggestBox: AutoSuggestBox(
        //   controller: TextEditingController(),
        //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        // ),
        // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('Source code'),
            onTap: () {
              launch('https://github.com/Spsden/Drip.git');
            },
          ),
        ],
      ),
      content: Stack(
        children: [
          Positioned.fill(child: PageView(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: screens,
          )),
          // NavigationBody(index: index, children: const [
          //   // const YouTubeHomeScreen(),
          //   FirstPageStack(),
          //   //const YouTubeHomeScreen(),
          //   SecondPageStack(),
          //   Settings(),
          //   // const SearchPage(
          //   //   incomingquery: 'Home',
          //   // ),
          //   // noResult('Error 404!'),
          //
          // ]),
          Stack(
            children: [
              SlidingSheet(
                color: Colors.transparent,

                closeOnBackdropTap: true,
                duration: const Duration(milliseconds: 200),
                controller: _sheetcontroller,
                //elevation: 8,
                cornerRadius: 3,
                snapSpec: SnapSpec(
                  snap: sheetCollapsed,
                  snappings: [100, 200, double.infinity],
                  positioning: SnapPositioning.pixelOffset,
                ),
                builder: (context, state) {
                  return ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: Container(
                        height: MediaQuery.of(context).size.height -40,
                        color: Colors.transparent,
                        child: const Center(
                          child: Text('Test between'),
                        ),
                      ),
                    ),
                  );
                },
                footerBuilder: (context, state) {
                  return Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: Stack(children: [
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                          child: const SizedBox(
                            child: AudioPlayerBar(),
                            width: double.infinity,
                            height: 100,
                            //: 100.0,
                          ),
                        ),
                      ),


                      Positioned(
                        bottom: 20,
                        right : 3,
                        child: IconButton(

                          icon: const Icon(FluentIcons.playlist_music),
                          onPressed: () {
                            setState(() {
                              if (sheetCollapsed) {
                                _sheetcontroller.expand();
                                sheetCollapsed = false;

                              } else {
                                _sheetcontroller.collapse();
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
                child:  ValueListenableBuilder<ProgressBarState>(
                  valueListenable: progressNotifier,
                  builder: (_, value, __) {
                    return av.ProgressBar(
                      thumbColor: context.watch<AppTheme>().color,
                      progressBarColor: context.watch<AppTheme>().color,
                      progress: value.current,
                      // buffered: value.buffered,
                      total: value.total,
                      onSeek: (position) => AudioControlClass.seek(position),
                    );
                  },
                ),),

            ],

          ),

        ],

      ),
    );
  }
}

// class WindowButtons extends StatelessWidget {
//   const WindowButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasFluentTheme(context));
//     assert(debugCheckHasFluentLocalizations(context));
//     final ThemeData theme = FluentTheme.of(context);
//     final buttonColors = WindowButtonColors(
//       iconNormal: theme.inactiveColor,
//       iconMouseDown: theme.inactiveColor,
//       iconMouseOver: theme.inactiveColor,
//       mouseOver: ButtonThemeData.buttonColor(
//           theme.brightness, {ButtonStates.hovering}),
//       mouseDown: ButtonThemeData.buttonColor(
//           theme.brightness, {ButtonStates.pressing}),
//     );
//     final closeButtonColors = WindowButtonColors(
//       mouseOver: Colors.red,
//       mouseDown: Colors.red.dark,
//       iconNormal: theme.inactiveColor,
//       iconMouseOver: Colors.red.basedOnLuminance(),
//       iconMouseDown: Colors.red.dark.basedOnLuminance(),
//     );
//     return Row(children: [
//       Tooltip(
//         message: FluentLocalizations.of(context).minimizeWindowTooltip,
//         child: MinimizeWindowButton(colors: buttonColors),
//       ),
//       Tooltip(
//         message: FluentLocalizations.of(context).restoreWindowTooltip,
//         child: WindowButton(
//           colors: buttonColors,
//           iconBuilder: (context) {
//             if (appWindow.isMaximized) {
//               return RestoreIcon(color: context.iconColor);
//             }
//             return MaximizeIcon(color: context.iconColor);
//           },
//           onPressed: appWindow.maximizeOrRestore,
//         ),
//       ),
//       Tooltip(
//         message: FluentLocalizations.of(context).closeWindowTooltip,
//         child: CloseWindowButton(colors: closeButtonColors),
//       ),
//     ]);
//   }
// }

class TopBar extends StatelessWidget {



  const TopBar({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      child: SizedBox(
        height: 40.0,
        child: WindowTitleBarBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MoveWindow(
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            7,
                            0,
                            0,
                          ),
                          child: Center(
                            child: Text('Drip',
                            style: TextStyle(fontSize: 20),),
                          ),

                        ),

                      ],

                    ),
                  )),

              Expanded(child: MoveWindow()),
              Row(
                children: [
                  MinimizeWindowButton(
                    colors: WindowButtonColors(iconNormal: Colors.white),
                  ),
                  MaximizeWindowButton(
                      colors: WindowButtonColors(iconNormal: Colors.white)),
                  CloseWindowButton(
                      colors: WindowButtonColors(iconNormal: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

