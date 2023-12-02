import 'package:drip/theme.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class CustomLeftBar extends ConsumerStatefulWidget {
  const CustomLeftBar({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomLeftBar> createState() => _CustomLeftBarState();
}

class _CustomLeftBarState extends ConsumerState<CustomLeftBar> {
  SideMenuController sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    // sideMenuController.addListener((p0) {
    //   ref.read(currentPageIndexProvider.notifier).state = p0;
    // });
  }

  final List<Widget> textwids =
      List<Widget>.generate(10, (i) => Text(i.toString()));

  @override
  Widget build(BuildContext context) {
    sideMenuController.changePage(ref.watch(currentPageIndexProvider));
    final ThemeMode themeMode = ref.watch(themeProvider).mode;

    final Size size = MediaQuery.of(context).size;

    // ref.listen(currentPageIndexProvider, (previous, next) {
    //    sideMenuController.changePage(ref.read(currentPageIndexProvider));
    //
    //  });
    return SideMenu(
      // showToggle: true,

      // title: Container(
      //   margin: const EdgeInsets.symmetric(vertical: 10),
      //   child: ExtendedImage.asset(
      //     'assets/driplogocircle.png',
      //     width: 40,
      //   ),
      // ),

      displayModeToggleDuration: const Duration(milliseconds: 100),

      style: SideMenuStyle(
        toggleColor: ref.watch(themeProvider).color,

        compactSideMenuWidth: 75,
        openSideMenuWidth: 200,

        showTooltip: false,

        displayMode: MediaQuery.of(context).size.width > 1000
            ? SideMenuDisplayMode.open
            : SideMenuDisplayMode.compact,
        hoverColor: ref.watch(themeProvider).color,
        selectedColor: ref.watch(themeProvider).color.withOpacity(0.4),
        indicatorColor: Colors.white,

        backgroundColor: fluent.FluentTheme.of(context).cardColor,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        unselectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
        unselectedIconColor: themeMode == fluent.ThemeMode.dark ||
                themeMode == fluent.ThemeMode.system
            ? Colors.white
            : Colors.black,
        itemInnerSpacing: 8,
        itemOuterPadding:
            const EdgeInsets.symmetric(vertical: 3, horizontal: 5),

        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        // backgroundColor: Colors.blueGrey[700]
      ),
      items: [
        SideMenuItem(
          // priority: 0,
          title: 'Home',
          onTap: (index, controller) {
            ref.read(currentPageIndexProvider.notifier).state = index;
            //sideMenuController.changePage(index);
          },
          icon: const Icon(
            Icons.home,
          ),
        ),
        SideMenuItem(
          // priority: 1,
          title: 'Search',
          onTap: (index, controller) {
            ref.read(currentPageIndexProvider.notifier).state = index;
            // sideMenuController.changePage(index);
          },
          icon: const Icon(
            Icons.search_rounded,
          ),
        ),
        SideMenuItem(
          // priority: 2,
          title: 'Queue',
          onTap: (index, controller) {
            ref.read(currentPageIndexProvider.notifier).state = index;
            //sideMenuController.changePage(index);
          },
          icon: const Icon(Icons.playlist_play_rounded),
        ),
        SideMenuItem(
          //priority: 3,
          title: 'Library',
          onTap: (index, controller) {
            ref.read(currentPageIndexProvider.notifier).state = index;
            //sideMenuController.changePage(index);
          },
          icon: const Icon(Icons.library_add_check_rounded),
        ),
        SideMenuItem(
          // priority: 4,
          title: 'Settings',
          onTap: (index, controller) {
            ref.read(currentPageIndexProvider.notifier).state = index;
            //sideMenuController.changePage(index);
          },
          icon: const Icon(Icons.settings),
        ),
        SideMenuItem(
          //   priority: 5,


          builder: (context, displayMode) {
            return ExpansionTile(

                // height: 50,
                title: IconToText(),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("submenu $index"),
                      );
                    },
                  )
                ]);
          },
        )
      ],
      controller: sideMenuController,
    );
  }
}

class IconToText extends StatefulWidget {
  const IconToText({super.key});

  @override
  State<IconToText> createState() => _IconToTextState();
}

class _IconToTextState extends State<IconToText> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth >= 100
            ? Text('Playlist')
            : Icon(CupertinoIcons.play_arrow_solid, size: 30);
      },
    );
  }
}
