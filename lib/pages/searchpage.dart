import 'dart:ui';


import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/artistspage.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/moods_page.dart';
import 'package:drip/pages/search.dart';
import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/playlist_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as mat;
import 'package:material_floating_search_bar/material_floating_search_bar.dart';



class AllSearchResults extends StatefulWidget {
  final String searchQuery;

  const AllSearchResults({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _AllSearchResultsState createState() => _AllSearchResultsState();
}

class _AllSearchResultsState extends State<AllSearchResults> {
  String query = '';
  bool fetched = false;
  bool status = false;
  late Map listOfSearchResults = {};
  late List<Artists> artists = [];
  late List<Albums> albums = [];
  late List<Songs> songs = [];
  late List<CommunityPlaylist> communityPlaylists = [];
  final FloatingSearchBarController _controller = FloatingSearchBarController();
  var topResult;

  @override
  void initState() {
    _controller.query = widget.searchQuery;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String incomq = widget.searchQuery;
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);

    if (!status) {
      status = true;
      SearchMusic.getArtists(_controller.query == '' ? widget.searchQuery  : _controller.query)
          .then((value) {
        if (mounted) {
          setState(() {
            listOfSearchResults = value;
            artists = listOfSearchResults['artistsearch'];
            songs = listOfSearchResults['songsearch'];
            communityPlaylists = listOfSearchResults['communityplaylistsearch'];
            albums = listOfSearchResults['albumsearch'];
             topResult = listOfSearchResults['topresults'];
            fetched = true;
          });
        }
      });
    }
    return SearchFunction(
        liveSearch: true,
        controller: _controller,
        onSubmitted: (searchQuery) async {
          setState(() {
            fetched = false;
           // query = searchQuery;
            status = false;
            listOfSearchResults = {};

          });
        },
        body:



            (!fetched || _controller.query.isEmpty)
                ? const Center(
                    child: MoodsAndCategories()

                    // LoadingAnimationWidget.staggeredDotsWave(
                    //     color: context.watch<AppTheme>().color, size: 300),
                  )
                :
            Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 90),
                    child: ScrollConfiguration(

                      behavior: const FluentScrollBehavior(),
                      child: ListView(

                        dragStartBehavior: DragStartBehavior.down,
                        physics: const BouncingScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        //controller: controller,
                        clipBehavior: Clip.hardEdge,
                        primary: false,

                        children: [

                          //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
                          Text(
                            _controller.query == ''
                                ? 'Results for \"${widget.searchQuery}\"'
                                : 'Results for \"${_controller.query}\"',
                            style: typography.display?.apply(fontSizeFactor: 1.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          biggerSpacer,
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [

                                // if(topResult.resultType != null)
                                //
                                //   Text(
                                //     "Top result",
                                //     style: typography.subtitle
                                //         ?.apply(fontSizeFactor: 1.0),
                                //   ),
                                //   const SizedBox(height: 15,),
                                //   if(topResult.resultType == 'video')
                                //
                                //
                                //     Container(
                                //       margin: const EdgeInsets.only(
                                //           left: 20, right: 20),
                                //       child: TrackCardLarge(data: TrackCardData(
                                //           duration: topResult.duration,
                                //           album: '',
                                //           title: topResult.title,
                                //           artist: '${topResult.artists.first
                                //               .name}',
                                //           thumbnail: topResult.thumbnails.first
                                //               .url.toString()
                                //       ),
                                //           songIndex: 0,
                                //           onTrackTap: () async {
                                //             var audioUrl =
                                //             await AudioControlClass.getAudioUri(
                                //                 topResult.videoId.toString());
                                //             // print(audioUrl.toString());
                                //
                                //             playerAlerts.buffering = true;
                                //             await context
                                //                 .read<ActiveAudioData>()
                                //                 .songDetails(
                                //                 audioUrl,
                                //                 topResult.videoId.toString(),
                                //                 topResult.artists[0].name,
                                //                 topResult.title.toString(),
                                //                 topResult
                                //                     .thumbnails[0]
                                //                     .url
                                //                     .toString());
                                //             currentMediaIndex = 0;
                                //
                                //             await AudioControlClass.play(
                                //                 audioUrl: audioUrl,
                                //                 videoId:
                                //                 topResult.videoId.toString(),
                                //                 context: context);
                                //           },
                                //           color: context
                                //               .watch<AppTheme>()
                                //               .mode == ThemeMode.dark ||
                                //               context
                                //                   .watch<AppTheme>()
                                //                   .mode ==
                                //                   ThemeMode.system
                                //               ? Colors.grey[150]
                                //               : Colors.grey[30]
                                //           ,
                                //           SuperSize: MediaQuery
                                //               .of(context)
                                //               .size,
                                //           fromQueue: false),
                                //     ),
                                //
                                //
                                //   if(topResult.resultType == 'artist')
                                //     ArtistCard(artists: Artists(
                                //         artist: topResult.artist,
                                //         browseId: topResult.browseId,
                                //         radioId: topResult.radioId,
                                //         category: topResult.category,
                                //         resultType: topResult.resultType,
                                //         shuffleId: topResult.shuffleId,
                                //         thumbnails: topResult.thumbnails
                                //     ))
                                //






                              ],
                            ),
                          ),
                          biggerSpacer,

                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        'songslistpage',
                                        arguments: _controller.query == ''
                                            ? widget.searchQuery
                                            : _controller.query);
                                  },
                                ),
                              ],
                            ),
                          ),
                          spacer,
                          SizedBox(
                              //height: MediaQuery.of(context).size.height * 1 / 3,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  // child: CommonTrackList(isFromPrimarySearchPage: true,songs: songs,currentTrackIndex: 1,tracklist: [],))

                                  child:

                                  TrackBars(
                                    songs: songs,
                                    isFromPrimarySearchPage: true,
                                  )




                              )),
                          biggerSpacer,
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  onPressed: () {

                                    // Navigator.of(context).pushNamed(
                                    //     'artistListPage',
                                    //     arguments: _controller.query == ''
                                    //         ? widget.searchQuery
                                    //         : _controller.query);

                                    Navigator.push(context,
                                        mat.MaterialPageRoute(builder: (context) => ArtistsSearchResults(artistQuery: _controller.query == ''
                                                 ? widget.searchQuery
                                                 : _controller.query,)));
                                  },
                                ),
                              ],
                            ),
                          ),
                          spacer,
                          artists.isNotEmpty
                              ? ArtistsSearch(artists: artists)
                              : const Text('No Artists available'),
                          //biggerSpacer,
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed(
                                    //     'albumsListPage',
                                    //     arguments: _controller.query == ''
                                    //         ? widget.searchQuery
                                    //         : _controller.query);

                                    Navigator.push(context,
                                        mat.MaterialPageRoute(builder: (context) => AlbumsSearchResults(albumsQuery: _controller.query == ''
                                          ? widget.searchQuery
                                                 : _controller.query)));

                                  },
                                ),
                              ],
                            ),
                          ),
                          spacer,
                          albums.isNotEmpty
                              ? AlbumSearch(albums: albums)
                              : const Text('No Albums available'),
                          const SizedBox(
                            height: 40,
                          ),
                          // biggerSpacer,
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Community Playlists",
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
                                              fontWeight: FontWeight.w500)),
                                      spacer
                                    ],
                                  ),
                                  onPressed: () {

                                    Navigator.push(context,
                                        mat.MaterialPageRoute(builder: (context) => PlaylistInfinitePaginationWidget(communityPlaylistQuery: _controller.query == ''
                                            ? widget.searchQuery
                                            : _controller.query,)));
                                    
                                    
                                    // Navigator.push(context,
                                    // mat.MaterialPageRoute(builder: (context) => PlaylistSearchResults(playlistParams: communityPlaylists.) ))
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    showSnackbar(
                                        context,
                                        const Snackbar(
                                          content: Text(
                                            'Coming Soon',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        duration: const Duration(milliseconds: 200));
                                  },
                                ),
                              ],
                            ),
                          ),
                          spacer,
                          communityPlaylists.isNotEmpty
                              ? CommunityPlaylistSearch(
                                  communityPlaylist: communityPlaylists)
                              : const Text('No Playlists available'),

                          biggerSpacer,
                          biggerSpacer,
                          biggerSpacer,
                        ],
                      ),
                    ),
                  ),
      );

  }
}

class MyCustomScrollBehavior extends mat.MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
   PointerDeviceKind.stylus

        // etc.
      };
}
