import 'dart:io';

import 'package:drip/screens/explorepage.dart';
import 'package:drip/screens/searchpage.dart';
import 'package:drip/screens/searchpagerevision.dart';
import 'package:drip/widgets/noresult.dart';

import 'package:drip/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(1000, 600));

  if (Platform.isWindows) {
    await Hive.initFlutter('Drip');
  } else {
    await Hive.initFlutter();
  }

  await openHiveBox('settings');
  await openHiveBox('Favorite Songs');
  await openHiveBox('cache', limit: true);
  runApp(const MyApp());
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drip',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // Widget _loadscreen = YouTubeHomeScreen();

  Widget _loadscreen = SearchPage();

  List<Widget> screens = [
    YouTubeHomeScreen(),

    SearchPage(),
    //SearchPage(),
    // SearchPage()
    noResult('Error 404!'),
    //YouTubeHomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WindowBorder(
        child: Row(
          children: [
            NavigationRail(
              minWidth: 20,
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                child: Text(
                  'Drip',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Colors.black87,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  _loadscreen = screens[_selectedIndex];

                  //TopBar();
                });
              },
              labelType: NavigationRailLabelType.selected,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    label: Text('Home'),
                    icon: Icon(
                      fluent.FluentIcons.home,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(
                      fluent.FluentIcons.home,
                      color: Colors.red,
                    )),
                NavigationRailDestination(
                    label: Text('Search'),
                    icon: Icon(
                      fluent.FluentIcons.search,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(
                      fluent.FluentIcons.search,
                      color: Colors.red,
                    )),
                NavigationRailDestination(
                    label: Text('Playlists'),
                    icon: Icon(
                      fluent.FluentIcons.stream_playlist,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(
                      Icons.playlist_play,
                      color: Colors.red,
                    ))
              ],
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TopBar()),
                    Expanded(child: _loadscreen),
                  ],
                ),
              ),
            )
          ],
        ),
        color: Colors.red.shade800.withOpacity(0.8),
        width: 0,
        //child: SideBar(),
      ),
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
