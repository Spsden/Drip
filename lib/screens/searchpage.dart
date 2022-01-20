import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

import 'package:drip/datasource/searchresults/albumsdataclass.dart';
import 'package:drip/datasource/searchresults/artistsdataclass.dart';
import 'package:drip/datasource/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasource/searchresults/searchmusic.dart';
import 'package:drip/datasource/searchresults/searchresultstwo.dart';
import 'package:drip/datasource/searchresults/songsdataclass.dart';
import 'package:drip/datasource/searchresults/topresultsdataclass.dart';
import 'package:drip/datasource/spreadclassmodels/modelsnew.dart';
import 'package:drip/screens/explorepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:drip/datasource/models.dart';
import 'package:drip/datasource/searchapi.dart';
import 'package:drip/widgets/searchwidget.dart';

class SearchPage extends StatefulWidget {
  //final String incomingquery;
  const SearchPage({
    Key? key,
    //required this.incomingquery,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchcontroller = TextEditingController();

  String query = '';
  bool status = false;
  late Map listOfSearchResults = {};
  late List<Artists> artists = [];
  late List<Albums> albums = [];
  late List<Songs> songs;
  late List<CommunityPlaylist> communityplaylists;
  // late Topresults _topresults;
  // late List<Songs> _searchpageresults;

  bool fetched = false;

  @override
  void initState() {
    super.initState();
    // SearchMusic().getArtists('new');
    //_searchcontroller.text = query;
  }

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }

  //List<Searchresults> searchview = _searchpageresults;
  //SearchApi().fetchd

  @override
  Widget build(BuildContext context) {
    if (!status) {
      status = true;
      SearchMusic.getArtists(query == '' ? 'Trending' : query).then((value) {
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
      });
    }
    return Container(
      color: Colors.black54,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 50),
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
                        width: 1.5),
                    color: Colors.red.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
              child: (!fetched)
                  ? Container(
                      width: 600,
                      height: 100,
                      child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      // child: SelectableText(
                      //     fetched ? artists.length.toString() : 'Loading ...')))

                      child: SelectableText(
                          artists.elementAt(2).artist.toString() +
                              'dedhfutia')))
        ],
      ),
    );
  }
}
