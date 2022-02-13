import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/youtubehomedata.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hive/hive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../datasources/audiofiles/audiodata.dart';

bool status = false;
List searchedList = Hive.box('cache').get('ytHome', defaultValue: []) as List;
List headList = Hive.box('cache').get('ytHomeHead', defaultValue: []) as List;

class YouTubeHomeScreen extends StatefulWidget {
  // final ValueChanged<String>? onPushSearch;
  const YouTubeHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _YouTubeHomeScreenState createState() => _YouTubeHomeScreenState();
}

String message = "";

class _YouTubeHomeScreenState extends State<YouTubeHomeScreen>
    with AutomaticKeepAliveClientMixin<YouTubeHomeScreen> {
  List ytSearch =
      Hive.box('settings').get('ytSearch', defaultValue: []) as List;
  bool showHistory =
      Hive.box('settings').get('showHistory', defaultValue: true) as bool;
  final TextEditingController _controller = TextEditingController();

  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  _scrollListener() {
    //Curves.easeInOutSine;
    ScrollDirection scrollDirection =
        _scrollController.position.userScrollDirection;
    if (scrollDirection != ScrollDirection.idle) {
      double scrollEnd = _scrollController.offset +
          (scrollDirection == ScrollDirection.reverse ? 30.0 : -30.0);
      scrollEnd = min(_scrollController.position.maxScrollExtent,
          max(_scrollController.position.minScrollExtent, scrollEnd));
      _scrollController.jumpTo(scrollEnd);
    }
  }

  //Color cardColor = fluent.Colors.grey[40];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fluent.Typography typography = FluentTheme.of(context).typography;
    super.build(context);
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    double boxSize = !rotated
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return  SingleChildScrollView(
        //dragStartBehavior: DragStartBehavior.start,
        controller: _scrollController,
        clipBehavior: Clip.hardEdge,

        primary: false,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          children: [
            // const Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'Hi, Suraj',
            //     style: TextStyle(fontSize: 40.0),
            //   ),
            // ),
            if (headList.isNotEmpty)
              CarouselSlider.builder(
                // PageView.builder(
                // controller: _pageController,
                // physics: const BouncingScrollPhysics(),
                itemCount: headList.length,
                options: CarouselOptions(
                  height: boxSize + 20,
                  viewportFraction: rotated ? 0.36 : 1.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                // onPageChanged: (int value) {
                // _currentPage = value;
                // },
                itemBuilder: (
                  BuildContext context,
                  int index,
                  int pageViewIndex,
                ) =>
                    GestureDetector(
                  onTap: () {
                    //onPushSearch?.call(headList[index]['title'].toString());
                    Navigator.of(context).pushNamed('searchpage',
                        arguments: headList[index]['title'].toString());
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     opaque: false,
                    //     pageBuilder: (_, __, ___) => SearchPage(
                    //       incomingquery: headList[index]['title'].toString(),
                    //     ),
                    //   ),
                    // );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      errorWidget: (context, _, __) => const Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/ytCover.png',
                        ),
                      ),
                      imageUrl: headList[index]['image'].toString(),
                      placeholder: (context, url) => const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/ytCover.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ListView.builder(
              itemCount: searchedList.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 7, 0, 5),
                          child: Text(
                            '${searchedList[index]["title"]}',
                            style: typography.title,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: boxSize + 10,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        itemCount:
                            (searchedList[index]['playlists'] as List).length,
                        itemBuilder: (context, idx) {
                          final item = searchedList[index]['playlists'][idx];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('playlists',
                                  arguments: item['playlistId'].toString()

                                 // arguments: headList[index]['title'].toString()


                              );
                              // Navigator.of(context).pushNamed('searchpage',
                              //     arguments: headList[index]['title'].toString());



                              //   item['type'] == 'video'
                              //       ? Navigator.push(
                              //           context,
                              //           PageRouteBuilder(
                              //             opaque: false,
                              //             pageBuilder: (_, __, ___) =>
                              //                 YouTubeSearchPage(
                              //               query:
                              //                   item['title'].toString(),
                              //             ),
                              //           ),
                              //         )
                              //       : Navigator.push(
                              //           context,
                              //           PageRouteBuilder(
                              //             opaque: false,
                              //             pageBuilder: (_, __, ___) =>
                              //                 YouTubePlaylist(
                              //               playlistId: item['playlistId']
                              //                   .toString(),
                              //               playlistImage:
                              //                   item['imageStandard']
                              //                       .toString(),
                              //               playlistName:
                              //                   item['title'].toString(),
                              //             ),
                              //           ),
                              //         );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:  context.watch<AppTheme>().mode == fluent.ThemeMode.dark || context.watch<AppTheme>().mode == fluent.ThemeMode.system ? fluent.Colors.grey[150] : fluent.Colors.grey[30]


                                   // if(co)


                                    //fluent.Colors.grey[40]

                                    // context.watch<AppTheme>().cardColor

                                ),
                                margin: EdgeInsets.all(10),
                                width: item['type'] != 'playlist'
                                    ? (boxSize - 30) * (16 / 9)
                                    : boxSize - 30,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        margin: EdgeInsets.only(top: 15.0),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          errorWidget: (context, _, __) =>
                                              Image(
                                            fit: BoxFit.cover,
                                            image:
                                                item['type'] != 'playlist'
                                                    ? const AssetImage(
                                                        'assets/ytCover.png',
                                                      )
                                                    : const AssetImage(
                                                        'assets/cover.jpg',
                                                      ),
                                          ),
                                          imageUrl:
                                              item['image'].toString(),
                                          placeholder: (context, url) =>
                                              Image(
                                            fit: BoxFit.cover,
                                            image:
                                                item['type'] != 'playlist'
                                                    ? const AssetImage(
                                                        'assets/ytCover.png',
                                                      )
                                                    : const AssetImage(
                                                        'assets/cover.jpg',
                                                      ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      '${item["title"]}',
                                      textAlign: TextAlign.center,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
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
                  ],
                );
              },
            ),
            SizedBox(
              height: 65,
            )
          ],

    ));
  }
}

// const int DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS = 250;
// const int DEFAULT_SCROLL_SPEED = 100;

// class SmoothScrollWeb extends StatelessWidget {
//   ///Same ScrollController as the child widget's.
//   final ScrollController controller;

//   ///Child scrollable widget.
//   final Widget child;

//   ///Scroll speed px/scroll.
//   final int scrollSpeed;

//   ///Scroll animation length in milliseconds.
//   final int scrollAnimationLength;

//   ///Curve of the animation.
//   final Curve curve;

//   double _scroll = 0;

//   SmoothScrollWeb({
//     required this.controller,
//     required this.child,
//     this.scrollSpeed = DEFAULT_SCROLL_SPEED,
//     this.scrollAnimationLength = DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS,
//     this.curve = Curves.linear,
//   });

//   @override
//   Widget build(BuildContext context) {
//     controller.addListener(() {
//       if (controller.position.activity is IdleScrollActivity) {
//         _scroll = controller.position.extentBefore;
//       }
//     });

//     return Listener(
//       onPointerSignal: (pointerSignal) {
//         int millis = scrollAnimationLength;
//         if (pointerSignal is PointerScrollEvent) {
//           if (pointerSignal.scrollDelta.dy > 0) {
//             _scroll += scrollSpeed;
//           } else {
//             _scroll -= scrollSpeed;
//           }
//           if (_scroll > controller.position.maxScrollExtent) {
//             _scroll = controller.position.maxScrollExtent;
//             millis = scrollAnimationLength ~/ 2;
//           }
//           if (_scroll < 0) {
//             _scroll = 0;
//             millis = scrollAnimationLength ~/ 2;
//           }

//           controller.animateTo(
//             _scroll,
//             duration: Duration(milliseconds: millis),
//             curve: curve,
//           );
//         }
//       },
//       child: child,
//     );
//   }
// }
