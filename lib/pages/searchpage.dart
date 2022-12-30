// import 'dart:ui';
//
//
// import 'package:drip/datasources/searchresults/albumsdataclass.dart';
// import 'package:drip/datasources/searchresults/artistsdataclass.dart';
// import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
// import 'package:drip/datasources/searchresults/searchresultsservice.dart';
// import 'package:drip/datasources/searchresults/songsdataclass.dart';
//
// import 'package:drip/pages/common/tracklist.dart';
// import 'package:drip/pages/moods_page.dart';
// import 'package:drip/pages/search.dart';
// import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/topresultwidget.dart';
// import 'package:drip/theme.dart';
//
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart' as mat;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';
//
// import 'common/loading_widget.dart';
//
//
//
// class AllSearchResults extends ConsumerStatefulWidget {
//   final GlobalKey? navigatorKey;
//   final String searchQuery;
//
//   const AllSearchResults({Key? key, required this.searchQuery, this.navigatorKey})
//       : super(key: key);
//
//   @override
//   _AllSearchResultsState createState() => _AllSearchResultsState();
// }
//
// class _AllSearchResultsState extends ConsumerState<AllSearchResults> {
//   String query = '';
//   bool fetched = false;
//   bool status = false;
//   late Map<String,dynamic> listOfSearchResults = {};
//   late List<Artists> artists = [];
//   late List<Albums> albums = [];
//   late List<Songs> songs = [];
//   late List<CommunityPlaylist> communityPlaylists = [];
//   final FloatingSearchBarController _controller = FloatingSearchBarController();
//   late dynamic topResult;
//  // var topResult;
//
//   @override
//   void initState() {
//     _controller.query = widget.searchQuery;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String incomq = widget.searchQuery;
//     Typography typography = FluentTheme.of(context).typography;
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//
//     if (!status) {
//       status = true;
//       SearchMusic.getAllSearchResults(_controller.query == '' ? widget.searchQuery  : _controller.query)
//           .then((value) {
//         if (mounted) {
//           setState(() {
//             listOfSearchResults = value;
//             artists = listOfSearchResults['artistsearch'];
//             songs = listOfSearchResults['songsearch'];
//             communityPlaylists = listOfSearchResults['communityplaylistsearch'];
//             albums = listOfSearchResults['albumsearch'];
//              topResult = listOfSearchResults['topresults'];
//             fetched = true;
//           });
//         }
//       });
//     }
//     return SearchFunction(
//         liveSearch: true,
//         controller: _controller,
//         onSubmitted: (searchQuery) async {
//           setState(() {
//             fetched = false;
//            // query = searchQuery;
//             status = false;
//             listOfSearchResults = {};
//
//           });
//         },
//         body:
//
//
//
//             ( _controller.query.isEmpty)
//                 ? const Center(
//                     child: MoodsAndCategories()
//
//
//                   )
//                 : (!fetched) ? Center(
//               child: loadingWidget(context ,ref.watch(themeProvider).color))
//             :
//             Padding(
//                     padding:
//                         const EdgeInsets.only(left: 10.0, right: 10.0, top: 90),
//                     child: ScrollConfiguration(
//
//                       behavior: const FluentScrollBehavior(),
//                       child: SingleChildScrollView(
//
//                         dragStartBehavior: DragStartBehavior.down,
//                         physics: const BouncingScrollPhysics(
//                             parent: ClampingScrollPhysics()),
//                         //controller: controller,
//                         clipBehavior: Clip.hardEdge,
//                         primary: false,
//
//                      child: Column(
//                        children: AnimationConfiguration.toStaggeredList(childAnimationBuilder: (widget) => SlideAnimation(horizontalOffset: 50.0, child: FadeInAnimation(child: widget,)),
//
//                            children: [
//
//                              //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
//                              Text(
//                                _controller.query == ''
//                                    ? 'Results for "${widget.searchQuery}"'
//                                    : 'Results for "${_controller.query}"',
//                                style: typography.display?.apply(fontSizeFactor: 1.0),
//                                maxLines: 2,
//                                overflow: TextOverflow.ellipsis,
//                              ),
//                              biggerSpacer,
//                              if(topResult == null)
//                                const SizedBox.shrink() else
//                              SizedBox(
//                                width: double.infinity,
//                                child: SizedBox(
//                                  child: TopResultsWidget(topResult: topResult),
//
//
//                                ),
//                              ),
//                              biggerSpacer,
//
//                              SizedBox(
//                                width: double.infinity,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Songs",
//                                      style: typography.subtitle
//                                          ?.apply(fontSizeFactor: 1.0),
//                                    ),
//                                    FilledButton(
//                                      child: Row(
//                                        children: const [
//                                          //Icon(FluentIcons.more),
//                                          // spacer,
//                                          Text('Show more',
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.w500)),
//                                        ],
//                                      ),
//                                      onPressed: () {
//                                        Navigator.of(context).pushNamed(
//                                            'songslistpage',
//                                            arguments: _controller.query == ''
//                                                ? widget.searchQuery
//                                                : _controller.query);
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              spacer,
//                              SizedBox(
//                                //height: MediaQuery.of(context).size.height * 1 / 3,
//                                  child: Container(
//                                      alignment: Alignment.centerLeft,
//                                      // child: CommonTrackList(isFromPrimarySearchPage: true,songs: songs,currentTrackIndex: 1,tracklist: [],))
//
//                                      child:
//
//                                      TrackBars(
//                                        songs: songs,
//                                        isFromPrimarySearchPage: true,
//                                      )
//
//
//
//
//                                  )),
//                              biggerSpacer,
//                              SizedBox(
//                                width: double.infinity,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Artists",
//                                      style: typography.subtitle
//                                          ?.apply(fontSizeFactor: 1.0),
//                                    ),
//                                    FilledButton(
//                                      child: Row(
//                                        children: const [
//                                          //Icon(FluentIcons.more),
//                                          // spacer,
//                                          Text('Show more',
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.w500)),
//                                        ],
//                                      ),
//                                      onPressed: () {
//
//                                        // Navigator.of(context).pushNamed(
//                                        //     'artistListPage',
//                                        //     arguments: _controller.query == ''
//                                        //         ? widget.searchQuery
//                                        //         : _controller.query);
//
//                                        Navigator.push(context,
//                                            mat.MaterialPageRoute(builder: (context) => ArtistsSearchResults(artistQuery: _controller.query == ''
//                                                ? widget.searchQuery
//                                                : _controller.query,)));
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              spacer,
//                              artists.isNotEmpty
//                                  ? ArtistsSearch(artists: artists)
//                                  : const Text('No Artists available'),
//                              //biggerSpacer,
//                              SizedBox(
//                                width: double.infinity,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Albums",
//                                      style: typography.subtitle
//                                          ?.apply(fontSizeFactor: 1.0),
//                                    ),
//                                    FilledButton(
//                                      child: Row(
//                                        children: const [
//                                          //Icon(FluentIcons.more),
//                                          // spacer,
//                                          Text('Show more',
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.w500)),
//                                        ],
//                                      ),
//                                      onPressed: () {
//                                        // Navigator.of(context).pushNamed(
//                                        //     'albumsListPage',
//                                        //     arguments: _controller.query == ''
//                                        //         ? widget.searchQuery
//                                        //         : _controller.query);
//
//                                        Navigator.push(context,
//                                            mat.MaterialPageRoute(builder: (context) => AlbumsSearchResults(albumsQuery: _controller.query == ''
//                                                ? widget.searchQuery
//                                                : _controller.query)));
//
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              spacer,
//                              albums.isNotEmpty
//                                  ? AlbumSearch(albums: albums)
//                                  : const Text('No Albums available'),
//                              const SizedBox(
//                                height: 40,
//                              ),
//                              // biggerSpacer,
//                              SizedBox(
//                                width: double.infinity,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Text(
//                                      "Community Playlists",
//                                      style: typography.subtitle
//                                          ?.apply(fontSizeFactor: 1.0),
//                                    ),
//                                    FilledButton(
//                                      child: Row(
//                                        children: const [
//                                          //Icon(FluentIcons.more),
//                                          // spacer,
//                                          Text('Show more',
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.w500)),
//                                          spacer
//                                        ],
//                                      ),
//                                      onPressed: () {
//
//                                        Navigator.push(context,
//                                            mat.MaterialPageRoute(builder: (context) => PlaylistInfinitePaginationWidget(communityPlaylistQuery: _controller.query == ''
//                                                ? widget.searchQuery
//                                                : _controller.query,)));
//
//
//                                        // Navigator.push(context,
//                                        // mat.MaterialPageRoute(builder: (context) => PlaylistSearchResults(playlistParams: communityPlaylists.) ))
//
//
//
//
//
//
//
//                                        showSnackbar(
//                                            context,
//                                            const Snackbar(
//                                              content: Text(
//                                                'Coming Soon',
//                                                style: TextStyle(fontSize: 30),
//                                              ),
//                                            ),
//                                            alignment: Alignment.center,
//                                            duration: const Duration(milliseconds: 200));
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              spacer,
//                              communityPlaylists.isNotEmpty
//                                  ? CommunityPlaylistSearch(
//                                  communityPlaylist: communityPlaylists)
//                                  : const Text('No Playlists available'),
//
//                              biggerSpacer,
//                              biggerSpacer,
//                              biggerSpacer,
//                            ]),
//                      ),
//
//
//                       ),
//                     ),
//                   ),
//       );
//
//   }
// }
//
// class MyCustomScrollBehavior extends mat.MaterialScrollBehavior {
//   // Override behavior methods and getters like dragDevices
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//    PointerDeviceKind.stylus
//
//         // etc.
//       };
// }
