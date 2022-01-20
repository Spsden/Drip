import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:drip/screens/explorepage.dart';
import 'package:drip/screens/searchpage.dart';
import 'package:drip/widgets/noresult.dart';
import 'package:drip/widgets/topbar.dart';
import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;
  Widget _loadedScreen = YouTubeHomeScreen();
  changeIndex(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  List<Widget> screens = [
    YouTubeHomeScreen(),
    SearchPage(),
    // noResult('Error 404!'),
    YouTubeHomeScreen()
  ];

  final _destinations = <AdaptiveScaffoldDestination>[
    const AdaptiveScaffoldDestination(icon: Icons.home, title: 'Home'),
    const AdaptiveScaffoldDestination(icon: Icons.search, title: 'Search'),
    const AdaptiveScaffoldDestination(icon: Icons.playlist_play, title: 'Play'),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
        extendBody: false,
        backgroundColor: Colors.black,
        drawerScrimColor: Colors.black,
        //extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 40,
          flexibleSpace: TopBar(),
        ),
        body: _loadedScreen,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
            _loadedScreen = screens[_selectedIndex];
          });
        },
        selectedIndex: _selectedIndex,
        destinations: _destinations);
  }
}
