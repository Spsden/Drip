import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/pages/audioplayerbar.dart';

import 'package:drip/pages/currentplaylist.dart';
import 'package:drip/pages/expanded_audio_bar.dart';
import 'package:drip/pages/settings.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'datasources/audiofiles/audiocontrolcentre.dart';
import 'datasources/audiofiles/activeaudiodata.dart';
import 'navigation/navigationstacks.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as av;
import 'theme.dart';

const String appTitle = 'Drip';

bool darkMode = true;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isWindows){
    doWhenWindowReady((){
      appWindow.minSize = const Size(540,540);
      appWindow.size = const Size(900,640);
      appWindow.alignment = Alignment.center;
      appWindow.show();
      appWindow.title = 'Drip';
    });

   // SystemTheme.accentInstance;
  }



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
  //WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isWindows){
  //   await Window.initialize();
  //
  // }
  //await Window.initialize();
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

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
        ],
        child: ChangeNotifierProvider(
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
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 // GlobalKey<FormState> _globalKeyF = GlobalKey();


  bool value = false;

  int index = 0;
  late int _selectedIndex;

  late PageController _pageController;
  late List<Widget> screens;

  bool sheetCollapsed = true;
  late SheetController _sheetController;

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

      const SecondPageStack(searchArgs: '', fromFirstPage: false),

      //MoodsAndCategories(),
      const CurrentPlaylist(fromMainPage: true),

      const Settings()
    ];
    _pageController = PageController(initialPage: _selectedIndex);

    // _audioPlayerControls = AudioPlayerControls();
    _sheetController = SheetController();

    // setWindowEffect(flutter_acrylic.WindowEffect.acrylic);
  }

  bool onWillPop() {
    if (Navigator.of(context).canPop()) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
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
            appBar:

            NavigationAppBar(
              automaticallyImplyLeading: true,


                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IconButton(

                      onPressed: () {


                        _pageController.previousPage(curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 400));
                      },
                      icon: const Icon(FluentIcons.back)),
                ),

                //leading: BackBu

                title: Platform.isWindows ? const TopBar() : const SizedBox.shrink()),
            pane: NavigationPane(

              selected: _selectedIndex,
              onChanged: (i) {
                index = i;
                _selectedIndex = i;
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
              //setState(() => index = i),
              size: const NavigationPaneSize(


                openWidth: 200,
                openMinWidth: 200,
                openMaxWidth: 200,
              ),
              header: Container(
                  height: kOneLineTileHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: const Text(
                    'Drip',
                    style: TextStyle(fontSize: 20),
                  )),
              displayMode: Platform.isWindows ? PaneDisplayMode.compact : PaneDisplayMode.top,
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
                // PaneItem(
                //   icon: const Icon(FluentIcons.personalize),
                //   title: const Text('Artists'),
                // ),
                PaneItemSeparator(),
                PaneItem(
                  icon: const mat.Icon(FluentIcons.playlist_music),
                  title: const Text('Play queue'),
                ),
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
              // autoSuggestBox: AutoSuggestBox(
              //   controller: TextEditingController(),
              //   onChanged: (String searchQuery,TextChangedReason) async{
              //     playerAlerts.searchVal = 'isdhvvhisd';
              //
              //    await  _pageController.animateToPage(1, duration:  const Duration(milliseconds: 400), curve: Curves.fastLinearToSlowEaseIn,);
              //
              //   },
              //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
              // ),
              autoSuggestBoxReplacement: const Icon(FluentIcons.search),

              // footerItems: [
              //   PaneItemSeparator(),
              //   PaneItem(
              //     icon: const Icon(FluentIcons.settings),
              //     title: const Text('Settings'),
              //   ),
              //   PaneItemAction(
              //     icon: const Icon(FluentIcons.open_source),
              //     title: const Text('Source code'),
              //     onTap: () {
              //       launch('https://github.com/Spsden/Drip.git');
              //     },
              //   ),
              //   // PaneItem(icon: Icon(FluentIcons.settings),
              //   // title: mat.SizedBox(height: 200,))
              //   // ,
              //   // PaneItem(icon: Icon(FluentIcons.settings),
              //   //     title: mat.SizedBox(height: 200,)),
              //   // PaneItem(icon: Icon(FluentIcons.settings),
              //   //     title: mat.SizedBox(height: 200,)),
              //
              //
              // ],
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
                  height: MediaQuery.of(context).size.height-100,
                  color: Colors.transparent,
                  child:

                  const ExpandedAudioBar(),
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

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = context.watch<AppTheme>().mode == ThemeMode.dark ||
            context.watch<AppTheme>().mode == ThemeMode.system
        ? Colors.grey[30]
        : Colors.grey[150];

    return SizedBox(
      height: 35.0,
      child: WindowTitleBarBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
                child: MoveWindow(
              child: Container(
                margin: const mat.EdgeInsets.only(top: 8,left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Image.asset(


                      'assets/driplogocircle.png',
                      filterQuality: FilterQuality.high,
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,

                      //height: 10,
                      //width: 10,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      'Drip',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),

                  ],

                ),
              ),
            )),
            Expanded(child: MoveWindow()),
            Row(
              children: [
                MinimizeWindowButton(
                  colors: WindowButtonColors(iconNormal: color),
                ),
                MaximizeWindowButton(
                    colors: WindowButtonColors(iconNormal: color)),
                CloseWindowButton(colors: WindowButtonColors(iconNormal: color))
              ],
            )
          ],
        ),
      ),
    );
  }
}
