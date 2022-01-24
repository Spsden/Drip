import 'dart:core';

import 'package:drip/datasource/searchresults/albumsdataclass.dart';
import 'package:drip/datasource/searchresults/artistsdataclass.dart';
import 'package:drip/datasource/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasource/searchresults/searchresultstwo.dart';
import 'package:drip/datasource/searchresults/songsdataclass.dart';
import 'package:drip/widgets/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/widgets/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/widgets/searchresultwidgets/communityplaylistresultwidget.dart';
import 'package:drip/widgets/searchresultwidgets/songresultwidget.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
   final String incomingquery;
  const SearchPage({
    Key? key,
    required this.incomingquery,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  final TextEditingController _searchcontroller = TextEditingController();

  String query = '';
  bool status = false;
  late Map listOfSearchResults = {};
  late List<Artists> artists = [];
  late List<Albums> albums = [];
  late List<Songs> songs = [];
  late List<CommunityPlaylist> communityplaylists = [];
  // late List listOfSearchResults = [];
  // late Topresults _topresults;
  // late List<Songs> _searchpageresults;
  bool fetched = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // SearchMusic().getArtists('new');
    _searchcontroller.text = query;
  }

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {

    // final Object? args = ModalRoute.of(context)?.settings.arguments as Map;
    // var incomingquery = args['searchkey'].toString();

    super.build(context);
    //super.build(context);
    // final bool rotated =
    //     MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    // double boxSize = !rotated
    //     ? MediaQuery.of(context).size.width / 2
    //     : MediaQuery.of(context).size.height / 2.5;
    // if (boxSize > 250) boxSize = 250;
    if (!status) {
      status = true;
      SearchMusic.getArtists(query == '' ? widget.incomingquery : query)
          .then((value) {
        if (this.mounted) {
          setState(() {
            listOfSearchResults = value;
            // artists = listOfSearchResults[0];
            // songs = listOfSearchResults[1];
            // communityplaylists = listOfSearchResults[2];
            // albums = listOfSearchResults[3];
            // _topresults = listOfSearchResults[4];
            artists = listOfSearchResults['artistsearch'];
            songs = listOfSearchResults['songsearch'];
            communityplaylists = listOfSearchResults['communityplaylistsearch'];
            albums = listOfSearchResults['albumsearch'];
            // _topresults = listOfSearchResults['topresults'];
            fetched = true;
          });
        }
      });
    }
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
              //width: 400,
              child: Row(
                children: [
                  Navigator.of(context).canPop() ?  Row(
                    children: [

                      GestureDetector(

                          child: const Icon(fluent.FluentIcons.chevron_left_med),
                          onTap: () {Navigator.of(context).pop() ;}),
                      const fluent.SizedBox(width: 20,),

                    ],

                  )
                 : SizedBox(),




                  fluent.SizedBox(

                    width: 400,
                    child: CupertinoSearchTextField(
                      controller: _searchcontroller,

                      // onChanged: (value) {
                      //   url =
                      //       'http://127.0.0.1:5000/search?query=$value&filter=songs&limit=20';
                      // },
                      style: TextStyle(color: Colors.white),
                      onSubmitted: (_value) async {
                        setState(() {
                          fetched = false;
                          query = _value;
                          status = false;
                          listOfSearchResults = {};
                        });
                      },

                      //backgroundColor: Colors.red.shade700.withOpacity(0.3),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 0.5),
                         // color: Colors.red.shade900.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                ],

              ),
            ),
          ),
          Container(
              child: (!fetched)
                  ? Container(
                alignment: Alignment.center,
                      width: 500,
                      height: 500,
                      child: const CircularProgressIndicator(color: Colors.red))
                  : Expanded(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.hardEdge,
                        primary: false,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text( query == '' ? 'Results for \"${widget.incomingquery}\"' :
                                'Results for \"$query\"',
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 40.0,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              padding: const fluent.EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  SongsSearch(songs: songs),
                                  artists.isNotEmpty ?
                                  ArtistsSearch(artists: artists) :
                                      Text('No Artists available'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  albums.isNotEmpty ?
                                  AlbumSearch(albums: albums) :
                                  Text('No Albums available'),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  communityplaylists.isNotEmpty ?
                                  CommunityPlaylistSearch(
                                      communityPlaylist: communityplaylists) : Text('No Playlists available'),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
        ],
      ),
    );
  }
}
