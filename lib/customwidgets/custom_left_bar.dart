import 'package:drip/providers/providers.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLeftBar extends ConsumerStatefulWidget {
  final VoidCallback indexCallBack;
  final Function(int) onIndexChange;

  const CustomLeftBar(
      {Key? key, required this.indexCallBack, required this.onIndexChange})
      : super(key: key);

  @override
  ConsumerState<CustomLeftBar> createState() => _CustomLeftBarState();
}

class _CustomLeftBarState extends ConsumerState<CustomLeftBar> {
  //int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: Colors.transparent,
       // backgroundColor: fluent.FluentTheme.of(context).scaffoldBackgroundColor,
        indicatorColor: ref.watch(themeProvider).color,
        elevation: 1,
        selectedIconTheme:
            const IconThemeData(color: Colors.deepPurpleAccent, opacity: 1, size: 30),
        unselectedIconTheme: const IconThemeData(color: Colors.black26),
        labelType: NavigationRailLabelType.all,
        onDestinationSelected: (int index) {
          ref.read(currentPageIndexProvider.notifier).state = index;

          print(ref.read(currentPageIndexProvider).toString());

          // widget.onIndexChange(index);
          // setState(() {
          //   _selectedIndex = index;
          // });
        },
        destinations: const [
          NavigationRailDestination(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          NavigationRailDestination(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              label: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              )),
          NavigationRailDestination(
              icon: Icon(
                Icons.playlist_play_rounded,
                color: Colors.white,
              ),
              label: Text(
                'Queue',
                style: TextStyle(color: Colors.white),
              )),
          NavigationRailDestination(
              icon: Icon(
               Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ))
        ],
        selectedIndex: ref.watch(currentPageIndexProvider));
  }
}
