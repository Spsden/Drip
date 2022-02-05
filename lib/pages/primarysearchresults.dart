// import 'package:drip/datasources/searchresults/albumsdataclass.dart';
// import 'package:drip/datasources/searchresults/artistsdataclass.dart';
// import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
// import 'package:drip/datasources/searchresults/searchresultstwo.dart';
// import 'package:drip/datasources/searchresults/songsdataclass.dart';
// import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
// import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/src/provider.dart';
//
// import '../theme.dart';
//
// class PrimarySearchResults extends StatefulWidget {
//   final String searchTerm;
//    final List<Artists> artists ;
//    final List<Albums> albums ;
//    final List<Songs> songs ;
//   final  List<CommunityPlaylist> communityPlaylists  ;
//
//   // final bool status;
//
//   // final Map listOfSearchResults;
//
//    PrimarySearchResults(
//       {Key? key,
//       required this.searchTerm,
//       // required this.status,
//     required this.artists, required this.albums, required this.songs, required this.communityPlaylists,
//
//       // required this.listOfSearchResults
//       })
//       : super(key: key);
//
//   @override
//   PrimarySearchResultsState createState() => PrimarySearchResultsState();
// }
//
// class PrimarySearchResultsState extends State<PrimarySearchResults> {
//   late String searchQuery;
//
//   String query = '';
//   late bool status = false;
//   late Map listOfSearchResults = {};
//   // late List<Artists> artists = [];
//   // late List<Albums> albums = [];
//   // late List<Songs> songs = [];
//   // late List<CommunityPlaylist> communityPlaylists = [];
//   late bool fetched = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//     if (widget.searchTerm.isEmpty) {
//       return Center(
//         child: Text(
//           'Search Something ',
//           style: TextStyle(fontSize: 40),
//         ),
//       );
//     } else {
//       // if (!status) {
//       //   status = true;
//       //   SearchMusic.getArtists(widget.searchTerm).then((value) {
//       //     if (mounted) {
//       //       setState(() {
//       //         listOfSearchResults = value;
//       //         artists = listOfSearchResults['artistsearch'];
//       //         songs = listOfSearchResults['songsearch'];
//       //         communityPlaylists =
//       //             listOfSearchResults['communityplaylistsearch'];
//       //         albums = listOfSearchResults['albumsearch'];
//       //         // _topresults = listOfSearchResults['topresults'];
//       //         fetched = true;
//       //       });
//       //     }
//       //   });
//      // }
//        return
//        (!fetched)
//           ? Center(
//               child: LoadingAnimationWidget.staggeredDotsWave(
//                   color: context.watch<AppTheme>().color, size: 300),
//             ):
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 8.0, top: 100),
//               child: ListView(
//                 //controller: controller,
//                 clipBehavior: Clip.hardEdge,
//                 primary: false,
//
//                 children: [
//                   Text(
//                     query == ''
//                         ? 'Results for \"${widget.searchTerm}\"'
//                         : 'Results for \"$query\"',
//                     style: const TextStyle(
//                       overflow: TextOverflow.ellipsis,
//                       fontSize: 30.0,
//                     ),
//                   ),
//                   biggerSpacer,
//
//                   SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Songs"),
//                         Button(
//                           child: Text('Show more'),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ),
//                   spacer,
//                   SizedBox(
//                       height: MediaQuery.of(context).size.height * 1 / 3,
//                       child: Placeholder()
//                       //MusicList(isExpandedPage: false, incomingquery : 'home', songs: songs, toSongsList: query == '' ? widget.incomingquery : query),
//                       ),
//                   biggerSpacer,
//                   SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text("Artists"),
//                         Button(
//                           child: const Text('Show more'),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ),
//                   spacer,
//                   widget.artists.isNotEmpty
//                       ? ArtistsSearch(artists: widget.artists)
//                       : const Text('No Artists available'),
//                   //biggerSpacer,
//                   SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text("Albums"),
//                         Button(
//                           child: const Text('Show more'),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ),
//                   spacer,
//                   widget.albums.isNotEmpty
//                       ? AlbumSearch(albums: widget.albums)
//                       : Text('No Albums available'),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   // biggerSpacer,
//                   SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text("Albums"),
//                         Button(
//                           child: const Text('Show more'),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ),
//                   spacer,
//                  widget. communityPlaylists.isNotEmpty
//                       ? CommunityPlaylistSearch(
//                           communityPlaylist: widget.communityPlaylists)
//                       : Text('No Playlists available'),
//
//                   biggerSpacer,
//                   biggerSpacer,
//                 ],
//               ),
//             );
//     }
//     // return Container(
//     //   child: Center(
//     //     child: Text(searchQuery),
//     //   ),
//     // );
//   }
// }
