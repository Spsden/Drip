
import 'package:drip/datasources/searchresults/songsdataclass.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart' as mat;

import '../../datasources/searchresults/albumsdataclass.dart';
import '../../datasources/searchresults/artistsdataclass.dart';
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
  List suggestions = ['Hello', 'arijit', 'justin'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String searchQuery = ref.watch(searchQueryProvider);
    final searchPageState = ref.watch(searchResultsProvider);
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    return ScaffoldPage(
        content: searchQuery.isEmpty
            ? const Center(
                child: Text('Suraj Pratap Singh'),
              )
            : searchPageState.when(
                data: (results) {
                  //return Text(results.toString());
                  List<Songs> songs = [];
                  if (results['songSearch'] != null) {
                    songs = results['songSearch'];
                  }

                  List<Artists> artists = [];

                  if (results['artistSearch'] != null) {
                    artists = results['artistSearch'];
                  }

                  List<Albums> albums = [];
                  if (results['albumSearch'] != null) {
                    albums = results['albumSearch'];
                  }

                  Object? topResult = null;
                  if (results['topResults'] != 'LOL') {
                    topResult = results['topResults'];
                  }

                  return Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: ScrollConfiguration(
                          behavior: const FluentScrollBehavior(),
                          child: SingleChildScrollView(
                            dragStartBehavior: DragStartBehavior.down,
                            physics: const BouncingScrollPhysics(
                                parent: ClampingScrollPhysics()),
                            //controller: controller,
                            clipBehavior: Clip.hardEdge,
                            primary: false,

                            child: Column(
                              children: AnimationConfiguration.toStaggeredList(
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                          horizontalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: widget,
                                          )),
                                  children: [
                                    //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
                                    Text(
                                      "You searched for $searchQuery",
                                      style: typography.title
                                          ?.apply(fontSizeFactor: 1.4),
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    biggerSpacer,
                                    topResult != null
                                        ? Align(
                                      alignment: Alignment.centerLeft,
                                        child: topResultWidget(context, results))
                                        : const SizedBox.shrink(),
                                    biggerSpacer,

                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Songs",
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
                                    songs.isNotEmpty
                                        ? SizedBox(
                                            height: 200,

                                            // MediaQuery.of(context).size.height *
                                            //     1 /
                                            //     4,
                                            child: Container(
                                                // decoration: BoxDecoration(
                                                //     border: Border.all(
                                                //         color: Colors.green)),


                                                alignment: Alignment.centerLeft,
                                                child: TrackBars(
                                                  songs: songs,
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
                                    biggerSpacer,
                                    biggerSpacer
                                  ]),
                            ),
                          )));
                },
                error: (error, _) => Text('error'),
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
      topWidget = SizedBox.shrink();

      break;
    case 'song':
      topWidget = TrackBars(
          songs: [...results['topResults']], isFromPrimarySearchPage: true);

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
      const SizedBox(height: 10,),
      topWidget
    ],
  );
}