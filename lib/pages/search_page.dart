// import 'package:drip/datasources/searchresults/searchresultsservice.dart';
// import 'package:drip/pages/moods_page.dart';
// import 'package:drip/pages/search.dart';
// import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/topresultwidget.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// import 'package:flutter/material.dart' as mat;
//
// import '../theme.dart';
// import 'common/loading_widget.dart';
// import 'common/tracklist.dart';
//
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
// class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
//   final FloatingSearchBarController _controller = FloatingSearchBarController();
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
//     Typography typography = FluentTheme.of(context).typography;
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//     return ScaffoldPage(
//       content: FutureBuilder(
//         future: SearchMusic.getAllSearchResults(
//             _controller.query == '' ? widget.searchQuery : _controller.query),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.hasData) {
//             return SearchFunction(
//               liveSearch: true,
//               controller: _controller,
//               onSubmitted: (searchQuery) async {
//                 setState(() {});
//               },
//               body: (_controller.query.isEmpty)
//                   ? const Center(
//                       child: MoodsAndCategories(),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.only(
//                           left: 10.0, right: 10.0, top: 90),
//                       child: ScrollConfiguration(
//                         behavior: const FluentScrollBehavior(),
//                         child: SingleChildScrollView(
//                           dragStartBehavior: DragStartBehavior.down,
//                           physics: const BouncingScrollPhysics(
//                               parent: ClampingScrollPhysics()),
//                           //controller: controller,
//                           clipBehavior: Clip.hardEdge,
//                           primary: false,
//
//                           child: Column(
//                             children: AnimationConfiguration.toStaggeredList(
//                                 childAnimationBuilder: (widget) =>
//                                     SlideAnimation(
//                                         horizontalOffset: 50.0,
//                                         child: FadeInAnimation(
//                                           child: widget,
//                                         )),
//                                 children: [
//                                   //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
//                                   Text(
//                                     _controller.query == ''
//                                         ? 'Results for "${widget.searchQuery}"'
//                                         : 'Results for "${_controller.query}"',
//                                     style: typography.display
//                                         ?.apply(fontSizeFactor: 1.0),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   biggerSpacer,
//                                   if (snapshot.data['topresults'] == null)
//                                     const SizedBox.shrink()
//                                   else
//                                     SizedBox(
//                                       width: double.infinity,
//                                       child: SizedBox(
//                                         child: TopResultsWidget(
//                                             topResult:
//                                                 snapshot.data['topresults']),
//                                       ),
//                                     ),
//                                   biggerSpacer,
//
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Songs",
//                                           style: typography.subtitle
//                                               ?.apply(fontSizeFactor: 1.0),
//                                         ),
//                                         FilledButton(
//                                           child: Row(
//                                             children: const [
//                                               //Icon(FluentIcons.more),
//                                               // spacer,
//                                               Text('Show more',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w500)),
//                                             ],
//                                           ),
//                                           onPressed: () {
//                                             Navigator.of(context).pushNamed(
//                                                 'songslistpage',
//                                                 arguments:
//                                                     _controller.query == ''
//                                                         ? widget.searchQuery
//                                                         : _controller.query);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   spacer,
//                                   SizedBox(
//                                       //height: MediaQuery.of(context).size.height * 1 / 3,
//                                       child: Container(
//                                           alignment: Alignment.centerLeft,
//                                           // child: CommonTrackList(isFromPrimarySearchPage: true,songs: songs,currentTrackIndex: 1,tracklist: [],))
//
//                                           child: TrackBars(
//                                             songs: snapshot.data['songsearch'],
//                                             isFromPrimarySearchPage: true,
//                                           ))),
//                                   biggerSpacer,
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Artists",
//                                           style: typography.subtitle
//                                               ?.apply(fontSizeFactor: 1.0),
//                                         ),
//                                         FilledButton(
//                                           child: Row(
//                                             children: const [
//                                               //Icon(FluentIcons.more),
//                                               // spacer,
//                                               Text('Show more',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w500)),
//                                             ],
//                                           ),
//                                           onPressed: () {
//                                             // Navigator.of(context).pushNamed(
//                                             //     'artistListPage',
//                                             //     arguments: _controller.query == ''
//                                             //         ? widget.searchQuery
//                                             //         : _controller.query);
//
//                                             Navigator.push(
//                                                 context,
//                                                 mat.MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ArtistsSearchResults(
//                                                           artistQuery: _controller
//                                                                       .query ==
//                                                                   ''
//                                                               ? widget
//                                                                   .searchQuery
//                                                               : _controller
//                                                                   .query,
//                                                         )));
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   spacer,
//                                   snapshot.data['artistsearch'].isNotEmpty
//                                       ? ArtistsSearch(
//                                           artists:
//                                               snapshot.data['artistsearch'])
//                                       : const Text('No Artists available'),
//                                   //biggerSpacer,
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Albums",
//                                           style: typography.subtitle
//                                               ?.apply(fontSizeFactor: 1.0),
//                                         ),
//                                         FilledButton(
//                                           child: Row(
//                                             children: const [
//                                               //Icon(FluentIcons.more),
//                                               // spacer,
//                                               Text('Show more',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w500)),
//                                             ],
//                                           ),
//                                           onPressed: () {
//                                             // Navigator.of(context).pushNamed(
//                                             //     'albumsListPage',
//                                             //     arguments: _controller.query == ''
//                                             //         ? widget.searchQuery
//                                             //         : _controller.query);
//
//                                             Navigator.push(
//                                                 context,
//                                                 mat.MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         AlbumsSearchResults(
//                                                             albumsQuery: _controller
//                                                                         .query ==
//                                                                     ''
//                                                                 ? widget
//                                                                     .searchQuery
//                                                                 : _controller
//                                                                     .query)));
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   spacer,
//                                   snapshot.data['albumsearch'].isNotEmpty
//                                       ? AlbumSearch(
//                                           albums: snapshot.data['albumsearch'])
//                                       : const Text('No Albums available'),
//                                   const SizedBox(
//                                     height: 40,
//                                   ),
//                                   // biggerSpacer,
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Community Playlists",
//                                           style: typography.subtitle
//                                               ?.apply(fontSizeFactor: 1.0),
//                                         ),
//                                         FilledButton(
//                                           child: Row(
//                                             children: const [
//                                               //Icon(FluentIcons.more),
//                                               // spacer,
//                                               Text('Show more',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w500)),
//                                               spacer
//                                             ],
//                                           ),
//                                           onPressed: () {
//                                             Navigator.push(
//                                                 context,
//                                                 mat.MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         PlaylistInfinitePaginationWidget(
//                                                           communityPlaylistQuery:
//                                                               _controller.query ==
//                                                                       ''
//                                                                   ? widget
//                                                                       .searchQuery
//                                                                   : _controller
//                                                                       .query,
//                                                         )));
//
//                                             // Navigator.push(context,
//                                             // mat.MaterialPageRoute(builder: (context) => PlaylistSearchResults(playlistParams: communityPlaylists.) ))
//
//                                             showSnackbar(
//                                                 context,
//                                                 const Snackbar(
//                                                   content: Text(
//                                                     'Coming Soon',
//                                                     style:
//                                                         TextStyle(fontSize: 30),
//                                                   ),
//                                                 ),
//                                                 alignment: Alignment.center,
//                                                 duration: const Duration(
//                                                     milliseconds: 200));
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   spacer,
//                                   snapshot.data['communityplaylistsearch']
//                                           .isNotEmpty
//                                       ? CommunityPlaylistSearch(
//                                           communityPlaylist: snapshot
//                                               .data['communityplaylistsearch'])
//                                       : const Text('No Playlists available'),
//
//                                   biggerSpacer,
//                                   biggerSpacer,
//                                   biggerSpacer,
//                                 ]),
//                           ),
//                         ),
//                       ),
//                     ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//           return Center(
//               child: loadingWidget(context, ref.watch(themeProvider).color));
//         },
//       ),
//     );
//   }
// }
//
// class AllSearchResults extends ConsumerStatefulWidget {
//   const AllSearchResults({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<AllSearchResults> createState() => _AllSearchResultsState();
// }
//
// class _AllSearchResultsState extends ConsumerState<AllSearchResults> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
