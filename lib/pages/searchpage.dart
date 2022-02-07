import 'dart:ui';

import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/search.dart';
import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/src/provider.dart';

import '../theme.dart';

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
      SearchMusic.getArtists(query == '' ? widget.searchQuery : query)
          .then((value) {
        if (mounted) {
          setState(() {
            listOfSearchResults = value;
            artists = listOfSearchResults['artistsearch'];
            songs = listOfSearchResults['songsearch'];
            communityPlaylists = listOfSearchResults['communityplaylistsearch'];
            albums = listOfSearchResults['albumsearch'];
            // _topresults = listOfSearchResults['topresults'];
            fetched = true;
          });
        }
      });
    }
    return SearchFunction(
      liveSearch: false,
      controller: _controller,
      onSubmitted: (searchQuery) async {
    setState(() {
      fetched = false;
      query = searchQuery;
      status = false;
      listOfSearchResults = {};
    });
      },
      body: (!fetched)
      ? Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: context.watch<AppTheme>().color, size: 300),
        )
      : Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 8.0, top: 100),
          child: ScrollConfiguration(
            behavior: const FluentScrollBehavior(),
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
              //controller: controller,
              clipBehavior: Clip.hardEdge,
              primary: false,

              children: [
                Text(
                  query == ''
                      ? 'Results for \"${widget.searchQuery}\"'
                      : 'Results for \"$query\"',
                  style:  typography.display?.apply(fontSizeFactor: 1.0),
                ),
                biggerSpacer,

                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Songs",
                      style:  typography.subtitle?.apply(fontSizeFactor: 1.0),),
                      Button(
                        child: Text('Show more'
                        ,style:  typography.bodyStrong?.apply(fontSizeFactor: 1.0),),
                        onPressed: () {
                          Navigator.of(context).pushNamed('songslistpage',arguments:  query == '' ? widget.searchQuery : query);
                        },
                      )
                    ],
                  ),
                ),
                spacer,
                SizedBox(
                    //height: MediaQuery.of(context).size.height * 1 / 3,
                    child: TrackBars(songs: songs,isFromPrimarySearchPage: true,)
                    //MusicList(isExpandedPage: false, incomingquery : 'home', songs: songs, toSongsList: query == '' ? widget.incomingquery : query),
                    ),
                biggerSpacer,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Artists",
                        style:  typography.subtitle?.apply(fontSizeFactor: 1.0),
                        ),
                      Button(
                        child:  Text('Show more'
                            ,style:  typography.bodyStrong?.apply(fontSizeFactor: 1.0),),
                        onPressed: () {},
                      )
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
                       Text("Albums",
                         style:  typography.subtitle?.apply(fontSizeFactor: 1.0),),
                      Button(
                        child:  Text('Show more'
                          ,style:  typography.bodyStrong?.apply(fontSizeFactor: 1.0),),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                spacer,
                albums.isNotEmpty
                    ? AlbumSearch(albums: albums)
                    : Text('No Albums available'),
                const SizedBox(
                  height: 40,
                ),
                // biggerSpacer,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Community Playlists"
                       ,style:  typography.subtitle?.apply(fontSizeFactor: 1.0),),
                      Button(
                        child:  Text('Show more'
                          ,style:  typography.bodyStrong?.apply(fontSizeFactor: 1.0),),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                spacer,
                communityPlaylists.isNotEmpty
                    ? CommunityPlaylistSearch(
                        communityPlaylist: communityPlaylists)
                    : Text('No Playlists available'),

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
    // etc.
  };

}
