
import 'package:drip/datasources/searchresults/models/artistpagedataclass.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:drip/datasources/searchresults/models/albumsdataclass.dart'
    as albumD;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drip/datasources/searchresults/models/songsdataclass.dart'
    as track;

import '../datasources/searchresults/models/artistsdataclass.dart' as artistD;

class ArtistsPage extends ConsumerStatefulWidget {
  final String channelId;

  const ArtistsPage({Key? key, required this.channelId}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends ConsumerState<ArtistsPage>
    with
        AutomaticKeepAliveClientMixin<ArtistsPage>,
        SingleTickerProviderStateMixin {

  bool status = false;
  bool fetched = false;
  late mat.TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = mat.TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // This is required when using AutomaticKeepAliveClientMixin
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<ArtistPageData>(
      future: SearchMusic.getArtistPage(widget.channelId),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final Output? res = snapshot.data?.output;
          print(res?.name.toString());
          return buildArtistPage(res!, size, spacer, context);
        } else {
          return const Placeholder();
        }
      },
    );
  }

  Widget buildArtistPage(
      Output res, Size size, Widget spacer, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // Rest of your UI code that uses artistData
    final List<SongResults> filteredSongResults = res.songs?.results
        ?.where((item) => item.videoId != null)
        .toList() ?? [];
    final List<SongResults> filteredVideoResults = res.videos?.results
        ?.where((item) => item.videoId != null)
        .toList() ?? [];
    return CustomScrollView(
      //scrollBehavior: const CupertinoScrollBehavior(),
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(),
      slivers: [
        mat.SliverAppBar(
          //leadingWidth: 0,
          titleSpacing: 0,

          toolbarHeight: 10,
          collapsedHeight: 30,
          // titleSpacing: 5,
          pinned: true,
          elevation: 0,
          snap: false,
          floating: false,
          actions: <Widget>[
            mat.IconButton(
              icon: const Icon(mat.Icons.more_horiz_rounded),
              tooltip: 'Comment Icon',
              onPressed: () {},
            ), //IconButton
          ],

          expandedHeight: height / 2,
          stretch: true,
          flexibleSpace: mat.FlexibleSpaceBar(
            titlePadding:
                const mat.EdgeInsets.only(left: 20, bottom: 60, right: 20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 200,
                  child: Column(
                      crossAxisAlignment: mat.CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          res.name.toString(),
                          style: const mat.TextStyle(fontSize: 35),
                        ),
                        Row(
                          children: [
                            const mat.Icon(mat.Icons.subscriptions),
                            spacer,
                            Text(
                              res.subscribers.toString(),
                              style: const mat.TextStyle(
                                  fontSize: 10, letterSpacing: 0.2),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ]),
                ),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    // width: 85,
                    child: mat.ElevatedButton(
                      style: mat.ButtonStyle(
                          backgroundColor: mat.MaterialStateProperty.all(
                              ref.watch(themeProvider).color)),
                      onPressed: () {},
                      child: const Text('Play'),
                    )),
              ],
            ),
            // stretchModes: const [
            //   mat.StretchMode.zoomBackground,
            //   mat.StretchMode.blurBackground,
            // ],
            background: ShaderMask(
              blendMode: BlendMode.luminosity,
              shaderCallback: (bounds) {
                return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])
                    .createShader(bounds);
              },
              child: FadeInImage(
                  placeholder: const AssetImage('assets/artist.jpg'),
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    res.thumbnails!.last.url.toString(),
                  )),
            ),
          ),
          backgroundColor: ref.watch(themeProvider).color,


          bottom: mat.TabBar(
            indicatorWeight: 5,
            indicatorSize: mat.TabBarIndicatorSize.label,
            automaticIndicatorColorAdjustment: true,
            isScrollable: true,


            indicator: mat.UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 4.0, color: ref.watch(themeProvider).color)),
            tabs: const [
              mat.Tab(text: 'Albums'),
              mat.Tab(text: 'Songs'),
              mat.Tab(text: 'Related'),
              mat.Tab(text: 'Singles'),
              mat.Tab(text: 'Videos'),
            ],
            controller: _tabController,
          ),

        ),
        SliverFillRemaining(
          child: mat.TabBarView(

              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                res.albums?.results != null
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1 / 1.3,
                        ),
                        itemCount: res.albums?.results?.length,
                        // shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return mat.Material(
                              child: AlbumCard(
                                  albums: albumD.Albums(
                                      title: res.albums!.results![index].title
                                          .toString(),
                                      year: res.albums!.results![index].year
                                          .toString(),
                                      type: '',
                                      isExplicit: false,
                                      category: "NA",
                                      artists: [],
                                      resultType: 'albums',
                                      duration: Duration.zero,
                                      browseId: res
                                          .albums!.results![index].browseId
                                          .toString(),
                                      thumbnails: res
                                          .albums!.results![index].thumbnails
                                          ?.map((e) => albumD.Thumbnail(
                                              width: e.width ?? 100,
                                              height: e.height ?? 100,
                                              url: e.url.toString()))
                                          .toList())));
                        },
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      )
                    : const Text('No result'),
                Column(
                  children: [
                    Button(child: const Text("Show more"), onPressed: () {}),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredSongResults.length,
                        itemBuilder: ((context, index) {
                          return TrackListItem(
                            songs: track.Songs(
                                duration: "NA",
                                album: track.Album(
                                    name:
                                    filteredSongResults[index].album?.name,
                                    id: "NA"),
                                title:filteredSongResults[index].title ?? "NA",
                                artists: [
                                  track.Album(
                                      name: filteredSongResults[index].artists
                                          ?.map((e) => e.name)
                                          .toList()
                                          .join(" "),
                                      id: "NA")
                                ],
                                category: "NA",
                                durationSeconds: 200,
                                thumbnails: [
                                  track.Thumbnail(
                                      height: 22,
                                      width: 22,
                                      url: filteredSongResults[index].thumbnails
                                              ?.first.url ??
                                          "assets/ytCover.png")
                                ],
                                feedbackTokens: track.FeedbackTokens(
                                    remove: null, add: null),
                                isExplicit:
                                filteredSongResults[index].isExplicit ??
                                        false,
                                resultType: "SONG",
                                videoId: filteredSongResults[index].videoId ??
                                    "dQw4w9WgXcQ",
                                year: "NA"),
                            color: index % 2 != 0
                                ? Colors.transparent
                                : ref.watch(themeProvider).mode ==
                                            ThemeMode.dark ||
                                        ref.watch(themeProvider).mode ==
                                            ThemeMode.system
                                    ? Colors.grey[150]
                                    : Colors.grey[40],
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                // TrackList(songQuery: _artistsPage..toString()),
                res.related?.results != null
                    ? GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1 / 1.5,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        children: List.generate(res.related!.results!.length,
                            (index) {
                          //List<artistD.Thumbnail> thumbs = []

                          return mat.Material(
                            child: ArtistCard(
                              artists: artistD.Artists(
                                subscribers: '',
                                artist: res.related!.results![index].title,
                                browseId: res.related!.results![index].browseId,
                                category: 'null',
                                radioId: 'null',
                                resultType: 'null',
                                shuffleId: 'null',
                                thumbnails: res
                                    .related!.results![index].thumbnails
                                    ?.map((e) => artistD.Thumbnail(
                                        width: 100,
                                        height: 100,
                                        url: e.url.toString()))
                                    .toList(),
                              ),
                            ),
                          );
                        }))
                    : const Text('No result'),
                const Text('lol'),
                Column(
                  children: [
                    Button(child: const Text("Show more"), onPressed: () {}),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredVideoResults.length,
                        itemBuilder: ((context, index) {

                          return TrackListItem(
                            songs: track.Songs(
                                duration: "NA",
                                album: track.Album(
                                    name:
                                   "NA",
                                    id: "NA"),
                                title: filteredVideoResults[index].title ?? "NA",
                                artists: [
                                  track.Album(
                                      name: filteredVideoResults[index].artists
                                          ?.map((e) => e.name)
                                          .toList()
                                          .join(" "),
                                      id: "NA")
                                ],
                                category: "NA",
                                durationSeconds: 200,
                                thumbnails: [
                                  track.Thumbnail(
                                      height: 22,
                                      width: 22,
                                      url: filteredVideoResults[index].thumbnails
                                          ?.first.url ??
                                          "assets/ytCover.png")
                                ],
                                feedbackTokens: track.FeedbackTokens(
                                    remove: null, add: null),
                                isExplicit:
                                filteredVideoResults[index].isExplicit ??
                                    false,
                                resultType: "SONG",
                                videoId : filteredVideoResults[index].videoId ??
                                    "dQw4w9WgXcQ",
                                year: "NA"),
                            color: index % 2 != 0
                                ? Colors.transparent
                                : ref.watch(themeProvider).mode ==
                                ThemeMode.dark ||
                                ref.watch(themeProvider).mode ==
                                    ThemeMode.system
                                ? Colors.grey[150]
                                : Colors.grey[40],
                          );
                        }),
                      ),
                    ),
                  ],
                ),

              ]),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// class MySliverAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//
//   MySliverAppBar({required this.expandedHeight});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     var size = MediaQuery.of(context).size;
//
//     return Stack(
//       fit: StackFit.expand,
//       overflow: Overflow.visible,
//       children: [
//         Opacity(
//           opacity: 1- shrinkOffset / expandedHeight,
//           child:  CachedNetworkImage(
//
//             fit: BoxFit.cover,
//             errorWidget: (context, url, error) => const Image(
//               fit: BoxFit.cover,
//               image: AssetImage('assets/artist.jpg'),
//             ),
//             imageUrl: _,
//             placeholder: (context, url) => const Image(
//                 fit: BoxFit.fill,
//                 image: AssetImage('assets/artist.jpg')),
//           ),
//         ),
//
//         Center(
//           child: Opacity(
//             opacity: shrinkOffset / expandedHeight,
//             child: Text(
//               "MySliverAppBar",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 23,
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
//
//   @override
//   double get maxExtent => expandedHeight;
//
//   @override
//   double get minExtent => mat.kToolbarHeight;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
