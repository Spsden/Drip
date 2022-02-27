import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/youtubehomedata.dart';
import 'package:drip/pages/playlistmainpage.dart';
import 'package:drip/pages/searchpage.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hive/hive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


bool status = false;
List searchedList = Hive.box('cache').get('ytHome', defaultValue: []) as List;
List headList = Hive.box('cache').get('ytHomeHead', defaultValue: []) as List;

class YouTubeHomeScreen extends StatefulWidget {

  const YouTubeHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _YouTubeHomeScreenState createState() => _YouTubeHomeScreenState();
}

String message = "";

class _YouTubeHomeScreenState extends State<YouTubeHomeScreen>
    with AutomaticKeepAliveClientMixin<YouTubeHomeScreen> {
  // List ytSearch =
  //     Hive.box('settings').get('ytSearch', defaultValue: []) as List;
  // bool showHistory =
  //     Hive.box('settings').get('showHistory', defaultValue: true) as bool;
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
    return SingleChildScrollView(
        //dragStartBehavior: DragStartBehavior.start,
        controller: _scrollController,
        clipBehavior: Clip.hardEdge,
        primary: false,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 35),
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
                    // Navigator.of(context).pushNamed('searchpage',
                    //     arguments: headList[index]['title'].toString());

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllSearchResults(searchQuery:  headList[index]['title'].toString())));

                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: //FadeInImage(placeholder:
                    // const AssetImage('assets/cover.jpg'),
                    //     width: 37,
                    //     height: 37,
                    //     fit: BoxFit.cover,
                    //
                    //     image:  NetworkImage(
                    //       headList[index]['image'].toString(),
                    //     )),

                    CachedNetworkImage(
                      // memCacheHeight: 80,
                      // memCacheWidth: 80,
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

              //padding: const EdgeInsets.only(bottom: 50),
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
                            textAlign: fluent.TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: boxSize + 15,
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

                              if(item['type'] == 'video'){
                                var query = item['title'].toString();
                                launch('https://www.youtube.com/results?search_query=$query');
                              } else {

                                Navigator.push(context,
                                   MaterialPageRoute(builder: (context) => PlaylistMain(playlistId: item['playlistId'].toString())));



                              }


                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: context.watch<AppTheme>().mode ==
                                                fluent.ThemeMode.dark ||
                                            context.watch<AppTheme>().mode ==
                                                fluent.ThemeMode.system
                                        ? fluent.Colors.grey[150].withOpacity(0.4)
                                        : fluent.Colors.grey[30]

                                    // if(co)

                                    //fluent.Colors.grey[40]

                                    // context.watch<AppTheme>().cardColor

                                    ),
                                margin: const EdgeInsets.only(right: 10),
                                width: item['type'] != 'playlist'
                                    ? (boxSize - 30) * (16 / 9)
                                    : boxSize - 30,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        margin: const EdgeInsets.only(top: 15.0),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child:

                                        // FadeInImage(placeholder:
                                        // const AssetImage('assets/cover.jpg'),
                                        //     width: 37,
                                        //     height: 37,
                                        //     fit: BoxFit.cover,
                                        //
                                        //     image:  NetworkImage(
                                        //         item['image'].toString(),
                                        //     )),

                                        CachedNetworkImage(
                                          // memCacheHeight: 80,
                                          // memCacheWidth: (item['type'] != 'playlist'
                                          //     ? (boxSize - 30) * (16 / 9)
                                          //     : boxSize - 30).toInt(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, _, __) =>
                                              Image(
                                            fit: BoxFit.cover,
                                            image: item['type'] != 'playlist'
                                                ? const AssetImage(
                                                    'assets/ytCover.png',
                                                  )
                                                : const AssetImage(
                                                    'assets/cover.jpg',
                                                  ),
                                          ),
                                          imageUrl: item['image'].toString(),
                                          placeholder: (context, url) => Image(
                                            fit: BoxFit.cover,
                                            image: item['type'] != 'playlist'
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
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      '${item["title"]}',
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      style: const fluent.TextStyle(
                                        fontWeight: FontWeight.w700
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 15,left: 5,right: 5),
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
                    const fluent.SizedBox(height: 30,)
                  ],
                );
              },
            ),
            const SizedBox(
              height: 65,
            )
          ],
        ));
  }
}

