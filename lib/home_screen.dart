import 'dart:async';
import 'dart:io';

import 'package:drip/customwidgets/custom_left_pane.dart';
import 'package:drip/datasources/audiofiles/playback.dart';
import 'package:drip/pages/audioplayerbar.dart';
import 'package:drip/pages/currentplaylist.dart' deferred as currentplaylist;
import 'package:drip/pages/settings.dart' deferred as settings;
import 'package:drip/pages/user_library.dart' deferred as userlibrary;
import 'package:drip/providers/audio_player_provider.dart';
import 'package:drip/providers/providers.dart';
import 'package:drip/theme.dart';
import 'package:drip/utils/deferred_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'navigation/navigationstacks.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as av;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WindowListener {
  late PageController _pageController;
  int index = 0;
  Map<int?, GlobalKey?> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };

  late List<Widget> allStacks;
  String searchQuery = '';

  Future<void> loadPages() async {
    allStacks = [

       FirstPageStack(navigatorKey: navigatorKeys[0]),
      SecondPageStack(searchArgs: searchQuery, navigatorKey: navigatorKeys[1]),
      DeferredWidget(currentplaylist.loadLibrary,
          () => currentplaylist.CurrentPlaylist(fromMainPage: true)),
      DeferredWidget(userlibrary.loadLibrary, () => userlibrary.UserLibrary()),
      DeferredWidget(settings.loadLibrary, () => settings.SettingsPage()),
    ];
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();

    loadPages();
    _pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _pageController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  final GlobalKey<mat.ScaffoldState> _scaffoldKey =
      GlobalKey<mat.ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(currentPageIndexProvider, (previous, next) {
      if (previous != next) {
        _pageController.animateToPage(ref.watch(currentPageIndexProvider),
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });

    return mat.Scaffold(

      drawerScrimColor: Colors.black.withOpacity(0.3),
      bottomNavigationBar: Platform.isWindows
          ? Container(
            child: Stack(
                children: [
                  Acrylic(
                    tint: ref.watch(audioPlayerProvider).color,
                    elevation: 10,
                    child: Platform.isWindows
                        ? AudioPlayerBar(
                      scaffoldKey: _scaffoldKey,
                    )
                        : const SizedBox.shrink(),
                  ),
                  const Positioned(
                      bottom: 70, left: 2, right: 2, child: SeekBar())
                ],
              ),
          )
          : const SizedBox.shrink(),
      key: _scaffoldKey,
      endDrawer: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: mat.Radius.circular(8.0),
                bottomLeft: mat.Radius.circular(8.0))),
        margin: const EdgeInsets.only(bottom: 85, top: 46),
        width: 400,
        child: Acrylic(
          tint: ref.watch(nowPlayingPaletteProvider),
          elevation: 10,
          blurAmount: 20,
          luminosityAlpha: 0.4,
          child: DeferredWidget(currentplaylist.loadLibrary,
              () => currentplaylist.CurrentPlaylist(fromMainPage: false)),
        ),
      ),
      appBar: mat.AppBar(
        //foregroundColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        leadingWidth: 75,
        elevation: 0,
         backgroundColor: FluentTheme.of(context).micaBackgroundColor,
        automaticallyImplyLeading: true,
        leading: Button(
            onPressed: () async {
              if (Navigator.canPop(
                  navigatorKeys[ref.read(currentPageIndexProvider)]!
                      .currentState!
                      .context)) {
                await Navigator.maybePop(
                    navigatorKeys[ref.read(currentPageIndexProvider)]!
                        .currentState!
                        .context);
              }
            },
            child: const Icon(FluentIcons.back)),
        title: Row(
          children: [
            const Expanded(
                child: DragToMoveArea(
                    child: SizedBox(
              width: double.infinity,
              height: 75,
            ))),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: AutoSuggestBox(
                  highlightColor: Colors.white,
                  placeholder: 'Search...',
                  placeholderStyle: const TextStyle(fontSize: 16),
                  trailingIcon: SizedBox(
                    child: IconButton(
                      icon: const Icon(
                        mat.Icons.search_rounded,
                        size: 16,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  enableKeyboardControls: true,
                  onChanged: (text, reason) async {
                    if (text.trim().isNotEmpty) {
                      if (index != 1) {
                        ref.read(currentPageIndexProvider.notifier).state = 1;
                      }
                    }
                    EasyDebounce.debounce(
                        'search', const Duration(milliseconds: 600), () {
                      ref.read(searchQueryProvider.notifier).state = text;
                    });
                  },
                  controller: _textEditingController,
                  items: ref.watch(searchSuggestionsProvider).when(
                      data: (suggestions) => suggestions.map((item) {
                            return AutoSuggestBoxItem(
                              label: item.toString(),
                              value: item,
                              onSelected: () async {
                                if (index != 1) {
                                  ref
                                      .read(currentPageIndexProvider.notifier)
                                      .state = 1;
                                }
                                ref.read(searchQueryProvider.notifier).state =
                                    item;
                              },
                            );
                          }).toList(),
                      error: (error, _) {
                        return [
                          AutoSuggestBoxItem(
                            label: 'error',
                            value: 'error',
                            child: const Text('error'),
                            onSelected: () async {},
                          )
                        ];
                      },
                      loading: () {
                        return [
                          AutoSuggestBoxItem(
                            label: 'Loading',
                            value: 'Loading',
                            onSelected: () async {},
                          )
                        ];
                      })),
            ),
            const Expanded(
                child: DragToMoveArea(
                    child: SizedBox(
              width: double.infinity,
              height: 75,
            ))),
          ],
        ),

        toolbarHeight: 50,
        actions: Platform.isWindows ? [const WindowButtons()] : null,
      ),



      body: Stack(
        children: [
          Row(
            children: [
              const CustomLeftBar(),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: allStacks,
              ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onWindowClose() async {
    await windowManager.destroy();
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        backgroundColor: Colors.transparent,
        brightness: theme.brightness,
        // backgroundColor: Colors.transparent,
      ),
    );
  }
}

class SeekBar extends ConsumerWidget {
  const SeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(ref.watch(audioControlCentreProvider).player.streams.position);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: av.ProgressBar(
          thumbGlowColor: Colors.blue,
          baseBarColor: ref.watch(themeProvider).color.withOpacity(0.3),
          thumbColor: ref.watch(themeProvider).color,
          thumbRadius: 5.0,
          thumbGlowRadius: 10.0,
          timeLabelLocation: av.TimeLabelLocation.sides,
          thumbCanPaintOutsideBar: true,
          barHeight: 3.0,
          progressBarColor: ref.watch(themeProvider).color,
          progress: ref.watch(audioPlayerProvider).position,
          // buffered: value.buffered,
          total: ref.watch(audioPlayerProvider).duration,
          onSeek: (position) =>
              ref.read(audioPlayerProvider).seek(position)),
    );
  }
}
