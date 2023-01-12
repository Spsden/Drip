import 'dart:async';
import 'dart:io';

import 'package:drip/customwidgets/custom_left_pane.dart';
import 'package:drip/datasources/audiofiles/playback.dart';
import 'package:drip/pages/audioplayerbar.dart';
import 'package:drip/pages/currentplaylist.dart' deferred as currentplaylist;
import 'package:drip/pages/settings.dart' deferred as settings;
import 'package:drip/providers/providers.dart';
import 'package:drip/theme.dart';
import 'package:drip/utils/deferred_widget.dart';
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

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _pageController;
  int index = 0;
  Map<int?, GlobalKey?> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey()
  };

  late List<Widget> allStacks;
  String searchQuery = '';

  Future<void> loadPages() async {
    allStacks = [
      FirstPageStack(navigatorKey: navigatorKeys[0]),
      SecondPageStack(searchArgs: searchQuery, navigatorKey: navigatorKeys[1]),
      DeferredWidget(currentplaylist.loadLibrary,
          () => currentplaylist.CurrentPlaylist(fromMainPage: true)),
      DeferredWidget(settings.loadLibrary, () => settings.SettingsPage()),
    ];
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPages();
    _pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

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
      appBar: mat.AppBar(
        titleSpacing: 0,
        centerTitle: true,
        leadingWidth: 75,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
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
          ],
        ),
        title: DragToMoveArea(
          child: Align(
              alignment: AlignmentDirectional.centerStart,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Drip',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
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
                      onChanged: (text, reason) {
                        if (text.trim().isNotEmpty) {
                          if (index != 1) {
                            ref.read(currentPageIndexProvider.notifier).state =
                                1;
                          }
                        }
                        ref.read(searchQueryProvider.notifier).state = text;
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
                                          .read(
                                              currentPageIndexProvider.notifier)
                                          .state = 1;
                                    }
                                    ref
                                        .read(searchQueryProvider.notifier)
                                        .state = item;
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
                const SizedBox(
                  width: 20,
                ),
              ])),
        ),
        toolbarHeight: 50,
        actions: Platform.isWindows ? [const WindowButtons()] : null,
      ),
      body: Stack(
        children: [
          Row(
            children: [
              const CustomLeftBar(),
              // CustomLeftBar(
              //   indexCallBack: () {},
              //   onIndexChange: (callBackIndex) {
              //     // setState(() {
              //     //   index = callBackIndex;
              //     // });
              //     // _pageController.animateToPage(index,
              //     //     duration: const Duration(milliseconds: 500),
              //     //     curve: Curves.fastLinearToSlowEaseIn);
              //   },
              // ),
              Expanded(
                  child: PageView(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: allStacks,
              ))
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Consumer(builder: (context, ref, child) {
              return Acrylic(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: Acrylic(

                    child:
                        //SizedBox()
                        Platform.isWindows
                            ? const AudioPlayerBar()
                            : const SizedBox.shrink()

                    //),
                    ),
              );
            }),
          ),
          Platform.isWindows
              ? const Positioned(
                  bottom: 55, left: 8, right: 8, child: SeekBar())
              : const SizedBox.shrink()
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

class SeekBar extends ConsumerWidget {
  const SeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(ref.watch(audioControlCentreProvider).player.streams.position);
    return av.ProgressBar(
        thumbGlowColor: Colors.blue,
        baseBarColor: ref.watch(themeProvider).color.withOpacity(0.3),
        thumbColor: ref.watch(themeProvider).color,
        progressBarColor: ref.watch(themeProvider).color,
        progress: ref.watch(audioControlCentreProvider).position,
        // buffered: value.buffered,
        total: ref.watch(audioControlCentreProvider).duration,
        onSeek: (position) =>
            ref.read(audioControlCentreProvider).seek(position));
  }
}
