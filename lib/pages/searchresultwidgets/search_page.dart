import 'package:drip/datasources/searchresults/models/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/models/songsdataclass.dart'
    as songs;
import 'package:drip/pages/recently_played.dart';
import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart' as mat;
import 'package:hive/hive.dart';

import '../../datasources/searchresults/models/albumsdataclass.dart';
import '../../datasources/searchresults/models/artistsdataclass.dart';
import '../../datasources/searchresults/models/videodataclass.dart';
import '../../providers/providers.dart';

import '../common/tracklist.dart';
import 'albumsresultwidget.dart';
import 'artistsresultwidget.dart';

// String searchQuery = '';
// final searchQueryProvider = StateProvider((ref) => searchQuery);

// class SearchResultsPage extends ConsumerStatefulWidget {
//   final GlobalKey? navigatorKey;
//   final String searchQuery;
//
//   const SearchResultsPage({
//     Key? key,
//     this.navigatorKey,
//     required this.searchQuery,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
// }
//
// class _SearchResultsPageState extends ConsumerState<SearchResultsPage>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     Typography typography = FluentTheme.of(context).typography;
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//     return ScaffoldPage(
//         content: widget.searchQuery == ''
//             ? const MoodsAndCategories()
//             : CustomFutureLoader(
//                 future: DripSearch.search(query: widget.searchQuery),
//                 builder: (BuildContext context, data) {
//                   List<Songs> songs =
//                       songsFromJson(jsonEncode(data['songResults']));
//                   List<Artists> artists =
//                       ArtistsFromJson(jsonEncode(data['artistsResults']));
//
//                   return Padding(
//                     padding:
//                         const EdgeInsets.only(left: 10.0, right: 10.0, top: 30),
//                     child: ScrollConfiguration(
//                       behavior: const FluentScrollBehavior(),
//                       child: SingleChildScrollView(
//                         dragStartBehavior: DragStartBehavior.down,
//                         physics: const BouncingScrollPhysics(
//                             parent: ClampingScrollPhysics()),
//                         //controller: controller,
//                         clipBehavior: Clip.hardEdge,
//                         primary: false,
//
//                         child: Column(
//                           children: AnimationConfiguration.toStaggeredList(
//                               childAnimationBuilder: (widget) => SlideAnimation(
//                                   horizontalOffset: 50.0,
//                                   child: FadeInAnimation(
//                                     child: widget,
//                                   )),
//                               children: [
//                                 //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
//                                 Text(
//                                   "You searched for ${widget.searchQuery}",
//                                   style: typography.title
//                                       ?.apply(fontSizeFactor: 1.4),
//                                   maxLines: 2,
//                                   textAlign: TextAlign.start,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 biggerSpacer,
//
//                                 data['Top result'] == null
//                                     ? const SizedBox.shrink()
//                                     : const SizedBox(
//                                         width: double.infinity,
//                                         child: SizedBox(
//                                             child: SizedBox.shrink() //
//                                             // TopResultsWidget(topResult: searchResults.topResult,
//                                             //
//                                             //
//                                             // ),
//                                             ),
//                                       ),
//
//                                 biggerSpacer,
//
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Songs",
//                                         style: typography.subtitle
//                                             ?.apply(fontSizeFactor: 1.0),
//                                       ),
//                                       FilledButton(
//                                         child: Row(
//                                           children: const [
//                                             //Icon(FluentIcons.more),
//                                             // spacer,
//                                             Text('Show more',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w500)),
//                                           ],
//                                         ),
//                                         onPressed: () {
//                                           Navigator.of(context).pushNamed(
//                                               'songslistpage',
//                                               arguments: widget.searchQuery);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 spacer,
//                                 songs.isNotEmpty
//                                     ? SizedBox(
//                                         height: 200,
//
//                                         // MediaQuery.of(context).size.height *
//                                         //     1 /
//                                         //     4,
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.green)),
//                                             alignment: Alignment.centerLeft,
//                                             child: TrackBars(
//                                               songs: songs,
//                                               isFromPrimarySearchPage: true,
//                                             )))
//                                     : SizedBox.shrink(),
//
//                                 biggerSpacer,
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Artists",
//                                         style: typography.subtitle
//                                             ?.apply(fontSizeFactor: 1.0),
//                                       ),
//                                       FilledButton(
//                                         child: Row(
//                                           children: const [
//                                             //Icon(FluentIcons.more),
//                                             // spacer,
//                                             Text('Show more',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w500)),
//                                           ],
//                                         ),
//                                         onPressed: () {
//                                           Navigator.push(
//                                               context,
//                                               mat.MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ArtistsSearchResults(
//                                                           artistQuery: widget
//                                                               .searchQuery)));
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 artists.isNotEmpty
//                                     ? ArtistsSearch(artists: artists)
//                                     : const Text('No Artists available'),
//
//                                 //biggerSpacer,
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Albums",
//                                         style: typography.subtitle
//                                             ?.apply(fontSizeFactor: 1.0),
//                                       ),
//                                       FilledButton(
//                                         child: Row(
//                                           children: const [
//                                             //Icon(FluentIcons.more),
//                                             // spacer,
//                                             Text('Show more',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w500)),
//                                           ],
//                                         ),
//                                         onPressed: () {
//                                           // Navigator.of(context).pushNamed(
//                                           //     'albumsListPage',
//                                           //     arguments: _controller.query == ''
//                                           //         ? widget.searchQuery
//                                           //         : _controller.query);
//
//                                           Navigator.push(
//                                               context,
//                                               mat.MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       AlbumsSearchResults(
//                                                           albumsQuery: widget
//                                                               .searchQuery)));
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 biggerSpacer,
//                                 biggerSpacer,
//                                 biggerSpacer
//                               ]),
//                         ),
//                       ),
//                     ),
//                   );
//                 }));
//   }
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }

List<songs.Songs> videosToSongs(List<Video> videos) {
  return videos
      .map((e) => songs.Songs(
          album: songs.Album(name: 'na', id: 'na'),
          artists: e.artists
              ?.map((e) => songs.Album(id: e.id, name: e.name))
              .toList(),
          category: e.category,
          duration: e.duration,
          durationSeconds: e.durationSeconds,
          feedbackTokens: songs.FeedbackTokens(add: 'na', remove: 'na'),
          isExplicit: false,
          resultType: e.resultType,
          thumbnails: e.thumbnails!
              .map((e) =>
                  songs.Thumbnail(height: e.height, url: e.url, width: e.width))
              .toList(),
          title: e.title,
          videoId: e.videoId,
          year: e.year))
      .toList();
}

class AllSearchResults extends ConsumerStatefulWidget {
  final GlobalKey? navigatorKey;
  final String searchQuery;

  const AllSearchResults(
      {Key? key, this.navigatorKey, required this.searchQuery})
      : super(key: key);

  @override
  ConsumerState<AllSearchResults> createState() => _AllSearchResultsState();
}

class _AllSearchResultsState extends ConsumerState<AllSearchResults>
    with AutomaticKeepAliveClientMixin {
  // List<songs.Songs> videosToSongs(List<Video> videos) {
  //   return videos.map((e) =>
  //       songs.Songs(album: songs.Album(name: 'na',id: 'na'),
  //           artists: e.artists?.map((e) => songs.Album(id: e.id,name: e.name)).toList(),
  //           category: e.category,
  //           duration: e.duration,
  //           durationSeconds: e.durationSeconds,
  //           feedbackTokens: songs.FeedbackTokens(add: 'na',remove: 'na'),
  //           isExplicit: false,
  //           resultType: e.resultType,
  //           thumbnails:e.thumbnails!.map((e) => songs.Thumbnail(height: e.height,url: e.url,width: e.width)).toList(),
  //           title: e.title,
  //           videoId: e.videoId,
  //           year: e.year
  //
  //
  //       )).toList();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
   // Hive.box('recentlyPlayed').close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final String searchQuery = ref.watch(searchQueryProvider);
    final searchPageState = ref.watch(searchResultsProvider);
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    return mat.Scaffold(
        body: searchQuery.isEmpty
            ? const Center(
                child: RecentlyPlayed(),
              )
            : searchPageState.when(
                data: (results) {
                  //return Text(results.toString());
                  List<songs.Songs> songss = [];
                  if (results['songSearch'] != null) {
                    songss = results['songSearch'];
                  }

                  List<Artists> artists = [];

                  if (results['artistSearch'] != null) {
                    artists = results['artistSearch'];
                  }

                  List<Albums> albums = [];
                  if (results['albumSearch'] != null) {
                    albums = results['albumSearch'];
                  }
                  List<CommunityPlaylist> featuredPlaylist = [];
                  if (results['featuredPlayListSearch'] != null) {
                    featuredPlaylist = results['featuredPlayListSearch'];
                  }
                  List<CommunityPlaylist> communityPlaylist = [];
                  if (results['communityPlaylistSearch'] != null) {
                    communityPlaylist = results['communityPlaylistSearch'];
                  }
                  // print(featuredPlaylist.length);
                  List<Video> videos = [];
                  if (results['videoSearch'] != null) {
                    videos = results['videoSearch'];
                  }

                  songss.addAll(videosToSongs(videos));

                  Object? topResult;
                  String topResultType = 'NA';
                  if (results['topResults'] != 'LOL') {
                    topResult = results['topResults'];
                    topResultType = results['topResultType'];
                  }


                  return ScrollConfiguration(
                      behavior: const FluentScrollBehavior(),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        dragStartBehavior: DragStartBehavior.down,
                        physics: const BouncingScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        //controller: controller,
                        clipBehavior: Clip.hardEdge,
                        primary: false,

                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                              childAnimationBuilder: (widget) => SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: widget,
                                  )),
                              children: [
                                topResult != null
                                    ? Container(
                                        height: topResultType == 'video' ||
                                                topResultType == 'song'
                                            ? 100
                                            : 300,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: FluentTheme.of(context)
                                                .cardColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child:
                                            topResultWidget(context, results))
                                    : const SizedBox.shrink(),
                                biggerSpacer,

                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Songs & Videos",
                                        style: typography.subtitle
                                            ?.apply(fontSizeFactor: 1.0),
                                      ),
                                      FilledButton(
                                        child: Row(
                                          children: const [
                                            //Icon(FluentIcons.more),
                                            // spacer,
                                            Text('Show more',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              'songslistpage',
                                              arguments: searchQuery);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                spacer,
                                songss.isNotEmpty
                                    ? SizedBox(
                                        height: 400,

                                        // MediaQuery.of(context).size.height *
                                        //     1 /
                                        //     4,
                                        child: Container(
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(
                                            //         color: Colors.green)),

                                            alignment: Alignment.centerLeft,
                                            child: TrackBars(
                                              songs: songss,
                                              isFromPrimarySearchPage: true,
                                            )))
                                    : const SizedBox.shrink(),

                                biggerSpacer,
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Artists",
                                        style: typography.subtitle
                                            ?.apply(fontSizeFactor: 1.0),
                                      ),
                                      FilledButton(
                                        child: Row(
                                          children: const [
                                            //Icon(FluentIcons.more),
                                            // spacer,
                                            Text('Show more',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              mat.MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArtistsSearchResults(
                                                          artistQuery: widget
                                                              .searchQuery)));
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                artists.isNotEmpty || artists != null
                                    ? ArtistsSearch(artists: artists)
                                    : const Text('No Artists available'),

                                //biggerSpacer,

                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Albums",
                                        style: typography.subtitle
                                            ?.apply(fontSizeFactor: 1.0),
                                      ),
                                      FilledButton(
                                        child: Row(
                                          children: const [
                                            //Icon(FluentIcons.more),
                                            // spacer,
                                            Text('Show more',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              mat.MaterialPageRoute(
                                                  builder: (context) =>
                                                      AlbumsSearchResults(
                                                        albumsQuery:
                                                            searchQuery,
                                                      )));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                spacer,
                                albums.isEmpty || albums != null
                                    ? AlbumSearch(albums: albums)
                                    : const Text('No albums available'),
                                biggerSpacer,

                                spacer,
                                featuredPlaylist.isNotEmpty
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Featured playlists",
                                                  style: typography.subtitle
                                                      ?.apply(
                                                          fontSizeFactor: 1.0),
                                                ),
                                                FilledButton(
                                                  child: Row(
                                                    children: const [
                                                      //Icon(FluentIcons.more),
                                                      // spacer,
                                                      Text('Show more',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        mat.MaterialPageRoute(
                                                            builder: (context) =>
                                                                PlaylistInfinitePaginationWidget(
                                                                  communityPlaylistQuery:
                                                                      searchQuery,
                                                                )));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          CommunityPlaylistSearch(
                                              communityPlaylist:
                                                  featuredPlaylist)
                                        ],
                                      )
                                    : const Text(
                                        'No Featured Playlists available'),

                                biggerSpacer,

                                communityPlaylist.isNotEmpty
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Community playlists",
                                                  style: typography.subtitle
                                                      ?.apply(
                                                          fontSizeFactor: 1.0),
                                                ),
                                                FilledButton(
                                                  child: Row(
                                                    children: const [
                                                      //Icon(FluentIcons.more),
                                                      // spacer,
                                                      Text('Show more',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        mat.MaterialPageRoute(
                                                            builder: (context) =>
                                                                PlaylistInfinitePaginationWidget(
                                                                  communityPlaylistQuery:
                                                                      searchQuery,
                                                                )));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          spacer,
                                          CommunityPlaylistSearch(
                                              communityPlaylist:
                                                  communityPlaylist)
                                        ],
                                      )
                                    : const Text('No Playlists available'),

                                biggerSpacer,
                                biggerSpacer,
                                biggerSpacer
                              ]),
                        ),
                      ));
                },
                error: (error, _) => const Text('error'),
                loading: () => const Center(
                      child: ProgressRing(),
                    )));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget topResultWidget(BuildContext context, dynamic results) {
  Typography typography = FluentTheme.of(context).typography;

  Widget topWidget = const SizedBox();
  switch (results['topResultType']) {
    case 'artist':
      topWidget = ArtistCard(artists: results['topResults']);

      break;

    case 'album':
      topWidget = AlbumCard(albums: results['topResults']);

      break;

    case 'video':
      topWidget = TrackListItem(
        songs: videosToSongs([results['topResults']]).first,
        color: Colors.transparent,
      );
      break;
    case 'song':
      topWidget = TrackListItem(
        songs: [results['topResults']].first,
        color: Colors.transparent,
      );

      // TrackBars(
      // songs: [...results['topResults']], isFromPrimarySearchPage: true);

      break;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top result",
              style: typography.subtitle?.apply(fontSizeFactor: 1.0),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(child: topWidget)
    ],
  );
}
