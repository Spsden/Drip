
import 'package:drip/datasources/searchresults/requests/youtubehomedata.dart';
import 'package:drip/pages/explore_page/trending_header.dart';
import 'package:drip/pages/playlistmainpage.dart';
import 'package:drip/providers/providers.dart';
import 'package:drip/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:flutter/material.dart';
import 'package:known_extents_list_view_builder/sliver_known_extents_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive/hive.dart';

import 'package:url_launcher/url_launcher.dart';

bool status = false;
List searchedList = Hive.box('cache').get('ytHome', defaultValue: []) as List;
List headList = Hive.box('cache').get('ytHomeHead', defaultValue: []) as List;

class YouTubeHomeScreen extends ConsumerStatefulWidget {
  const YouTubeHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _YouTubeHomeScreenState createState() => _YouTubeHomeScreenState();
}

String message = "";

class _YouTubeHomeScreenState extends ConsumerState<YouTubeHomeScreen>
    with AutomaticKeepAliveClientMixin<YouTubeHomeScreen> {
  // List ytSearch =
  //     Hive.box('settings').get('ytSearch', defaultValue: []) as List;
  // bool showHistory =
  //     Hive.box('settings').get('showHistory', defaultValue: true) as bool;
  // final TextEditingController _controller = TextEditingController();


  late List<ScrollController> _listViewControllers;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _listViewControllers =
        List.generate(searchedList.length, (index) => ScrollController());
    // _scrollController.addListener(_scrollListener);
    if (!status) {
      ApiYouTube().ymusicHomePageData().then((value) {
        status = true;
        if (value.isNotEmpty) {
          setState(() {
            searchedList = value['body'] ?? [];
            headList = value['head'] ?? [];

            Hive.box('cache').put('ytHome', value['body']);
            Hive.box('cache').put('ytHomeHead', value['head']);
          });
        } else {
          status = false;
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    //_controller.dispose();
    Hive.box('cache').close();
    super.dispose();
    for (var element in _listViewControllers) {
      element.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode _themeMode = ref.watch(themeProvider).mode;
    fluent.Typography typography = fluent.FluentTheme.of(context).typography;
    super.build(context);
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    double boxSize = !rotated
        ? MediaQuery.of(context).size.width / 2.5
        : MediaQuery.of(context).size.height / 3;
    if (boxSize > 250) boxSize = 250;
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: size.height / 2,
          collapsedHeight: 30,
          toolbarHeight: 10,
          stretch: true,
          pinned: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
              background: TrendingHeader(
            headList: headList,
          )),
        ),
        SliverKnownExtentsList(
            delegate: SliverChildBuilderDelegate(
              addAutomaticKeepAlives: true,

                childCount: searchedList.length, (context, index) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 7, 0, 5),
                            child: Text(
                              '${searchedList[index]["title"]}',
                              style: typography.title,
                              textAlign: fluent.TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: boxSize + 15,
                        width: double.infinity,
                        child: ListView.builder(
                          // shrinkWrap: true,
                          controller: _listViewControllers[index],
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          itemCount:
                              (searchedList[index]['playlists'] as List).length,
                          itemBuilder: (context, idx) {
                            final item = searchedList[index]['playlists'][idx];
                            return GestureDetector(
                              onTap: () {
                                if (item['type'] == 'video') {
                                  var query = item['title'].toString();
                                  launchUrl(Uri.parse('https://www.youtube.com/results?search_query=$query')
                                      );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlaylistMain(
                                              playlistId: item['playlistId']
                                                  .toString())));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color:
                                          _themeMode == fluent.ThemeMode.dark ||
                                                  _themeMode ==
                                                      fluent.ThemeMode.system
                                              ? fluent.Colors.grey[150]
                                                  .withOpacity(0.4)
                                              : fluent.Colors.grey[30]),
                                  margin: const EdgeInsets.only(right: 10),
                                  width: item['type'] != 'playlist'
                                      ? (boxSize - 30) * (16 / 9)
                                      : boxSize - 30,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          margin:
                                              const EdgeInsets.only(top: 15.0),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: ExtendedImage.network(
                                            item['image'].toString(),
                                            fit: fluent.BoxFit.cover,

                                            cache: true,
                                            // loadStateChanged: loadingWidget(context),

                                            clearMemoryCacheIfFailed: true,
                                            // filterQuality: fluent.FilterQuality.medium,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        '${item["title"]}',
                                        textAlign: TextAlign.left,
                                        softWrap: false,
                                        style: const fluent.TextStyle(
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, left: 5, right: 5),
                                        child: Text(
                                          item['type'] != 'video'
                                              ? '${item["count"]} Tracks | ${item["description"]}'
                                              : '${item["count"]} | ${item["description"]}',
                                          textAlign: TextAlign.center,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .color,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const fluent.SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Positioned.fill(
                    right: 10,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton.small(
                                heroTag: null,
                                onPressed: () {
                                  _listViewControllers[index].animateTo(
                                    _listViewControllers[index]
                                        .position
                                        .minScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                foregroundColor: ref.watch(themeProvider).color,
                                backgroundColor: ref.watch(themeProvider).cardColor,
                                elevation: 5.0,
                                child: const Icon(
                                  Icons.navigate_before_rounded,
                                  size: 40.0,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            FloatingActionButton.small(
                              heroTag: null,
                                onPressed: () {
                                  _listViewControllers[index].animateTo(
                                    _listViewControllers[index]
                                        .position
                                        .maxScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                foregroundColor: ref.watch(themeProvider).color,
                                backgroundColor: ref.watch(themeProvider).cardColor,
                                elevation: 5.0,
                                child: const Icon(
                                  Icons.navigate_next_rounded,
                                  size: 40.0,
                                )),
                          ],
                        )),
                  )
                ],
              );
            }),
            itemExtents: List.generate(searchedList.length, (index) => 350.0))

        // SingleChildScrollView(
        //       dragStartBehavior: DragStartBehavior.start,
        //       controller: _scrollController,
        //
        //       physics: const BouncingScrollPhysics(),
        //       padding: const EdgeInsets.fromLTRB(10, 30, 10, 35),
        //       child: Column(
        //         children: [
        //
        //
        //
        //           ListView.builder(
        //             itemCount: searchedList.length,
        //             physics: const BouncingScrollPhysics(),
        //
        //
        //             //padding: const EdgeInsets.only(bottom: 50),
        //             itemBuilder: (context, index) {
        //               return
        //
        //               Stack(
        //                 children: [
        //                   Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           Padding(
        //                             padding: const EdgeInsets.fromLTRB(7, 7, 0, 5),
        //                             child: Text(
        //                               '${searchedList[index]["title"]}',
        //                               style: typography.title,
        //                               textAlign: fluent.TextAlign.left,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height: boxSize + 15,
        //                         width: double.infinity,
        //                         child: ListView.builder(
        //                           shrinkWrap: true,
        //                           controller: _listViewControllers[index],
        //                           physics: const BouncingScrollPhysics(),
        //                           scrollDirection: Axis.horizontal,
        //                           padding: const EdgeInsets.symmetric(horizontal: 2),
        //                           itemCount:
        //                           (searchedList[index]['playlists'] as List)
        //                               .length,
        //                           itemBuilder: (context, idx) {
        //                             final item =
        //                             searchedList[index]['playlists'][idx];
        //                             return GestureDetector(
        //                               onTap: () {
        //                                 if (item['type'] == 'video') {
        //                                   var query = item['title'].toString();
        //                                   launch(
        //                                       'https://www.youtube.com/results?search_query=$query');
        //                                 } else {
        //                                   Navigator.push(
        //                                       context,
        //                                       MaterialPageRoute(
        //                                           builder: (context) => PlaylistMain(
        //                                               playlistId: item['playlistId']
        //                                                   .toString())));
        //                                 }
        //                               },
        //                               child: Padding(
        //                                 padding:
        //                                 const EdgeInsets.fromLTRB(8, 0, 8, 0),
        //                                 child: Container(
        //                                   decoration: BoxDecoration(
        //                                       borderRadius:
        //                                       BorderRadius.circular(10.0),
        //                                       color: _themeMode ==
        //                                           fluent.ThemeMode.dark ||
        //                                           _themeMode ==
        //                                               fluent.ThemeMode.system
        //                                           ? fluent.Colors.grey[150]
        //                                           .withOpacity(0.4)
        //                                           : fluent.Colors.grey[30]),
        //                                   margin: const EdgeInsets.only(right: 10),
        //                                   width: item['type'] != 'playlist'
        //                                       ? (boxSize - 30) * (16 / 9)
        //                                       : boxSize - 30,
        //                                   child: Column(
        //                                     children: [
        //                                       Expanded(
        //                                         child: Card(
        //                                           margin: const EdgeInsets.only(
        //                                               top: 15.0),
        //                                           elevation: 5,
        //                                           shape: RoundedRectangleBorder(
        //                                             borderRadius:
        //                                             BorderRadius.circular(10.0),
        //                                           ),
        //                                           clipBehavior: Clip.antiAlias,
        //                                           child: ExtendedImage.network(
        //                                             item['image'].toString(),
        //                                             fit: fluent.BoxFit.cover,
        //
        //                                             cache: true,
        //                                             // loadStateChanged: loadingWidget(context),
        //
        //                                             clearMemoryCacheIfFailed: true,
        //                                             // filterQuality: fluent.FilterQuality.medium,
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       const SizedBox(
        //                                         height: 15.0,
        //                                       ),
        //                                       Text(
        //                                         '${item["title"]}',
        //                                         textAlign: TextAlign.left,
        //                                         softWrap: false,
        //                                         style: const fluent.TextStyle(
        //                                             fontWeight: FontWeight.w700),
        //                                         overflow: TextOverflow.ellipsis,
        //                                       ),
        //                                       Container(
        //                                         margin: const EdgeInsets.only(
        //                                             bottom: 15, left: 5, right: 5),
        //                                         child: Text(
        //                                           item['type'] != 'video'
        //                                               ? '${item["count"]} Tracks | ${item["description"]}'
        //                                               : '${item["count"]} | ${item["description"]}',
        //                                           textAlign: TextAlign.center,
        //                                           softWrap: false,
        //                                           overflow: TextOverflow.ellipsis,
        //                                           style: TextStyle(
        //                                             fontSize: 11,
        //                                             color: Theme.of(context)
        //                                                 .textTheme
        //                                                 .caption!
        //                                                 .color,
        //                                           ),
        //                                         ),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             );
        //                           },
        //                         ),
        //                       ),
        //                       const fluent.SizedBox(
        //                         height: 30,
        //                       )
        //                     ],
        //                   ),
        //                   Positioned.fill(
        //
        //                     child: Align(
        //                         alignment: Alignment.topRight,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.end,
        //                           children: [
        //                             FloatingActionButton.small(
        //                                 onPressed: () {
        //                                   _listViewControllers[index].animateTo(
        //                                     _listViewControllers[index]
        //                                         .position
        //                                         .minScrollExtent,
        //                                     duration: Duration(milliseconds: 500),
        //                                     curve: Curves.ease,
        //                                   );
        //                                 },
        //                                 foregroundColor: Colors.white,
        //                                 backgroundColor:
        //                                 ref.watch(themeProvider).color,
        //                                 elevation: 5.0,
        //                                 child: const Icon(
        //                                   Icons.navigate_before_rounded,
        //                                   size: 40.0,
        //                                 )),
        //                             const SizedBox(width: 10,),
        //                             FloatingActionButton.small(
        //                                 onPressed: () {
        //                                   _listViewControllers[index].animateTo(
        //                                     _listViewControllers[index]
        //                                         .position
        //                                         .maxScrollExtent,
        //                                     duration: Duration(milliseconds: 500),
        //                                     curve: Curves.ease,
        //                                   );
        //                                 },
        //                                 foregroundColor: Colors.white,
        //                                 backgroundColor:
        //                                 ref.watch(themeProvider).color,
        //                                 elevation: 5.0,
        //                                 child: const Icon(
        //                                   Icons.navigate_next_rounded,
        //                                   size: 40.0,
        //                                 )),
        //                           ],
        //                         )),
        //                   )
        //                 ],
        //               );
        //             },
        //           ),
        //           const SizedBox(
        //             height: 65,
        //           )
        //         ],
        //       )),
      ],
    );
  }
}
