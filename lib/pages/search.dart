import 'dart:typed_data';

import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/musiclist.dart';
import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as mat;

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
 // final autoSuggestBox = TextEditingController();

  String query = '';
  bool status = false;
  late Map listOfSearchResults = {};
  late List<Artists> artists = [];
  late List<Albums> albums = [];
  late List<Songs> songs = [];
  late List<CommunityPlaylist> communityPlaylists = [];
  bool fetched = false;
  //late  ScrollController controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //controller = ScrollController();
    // SearchMusic().getArtists('new');
    autoSuggestBox.text = query;
    WidgetsBinding.instance?.addPostFrameCallback((_){
      //controller = ScrollController(keepScrollOffset: true,initialScrollOffset: 0.0);
      //write or call your logic
      //code will run when widget rendering complete
    });
  }

  @override
  void dispose() {
   // controller.dispose();
    //autoSuggestBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);


    if (!status) {
      status = true;
      SearchMusic.getArtists(query == '' ? widget.incomingquery : query)
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
    return fluent.ScaffoldPage(
      //padding: EdgeInsets.only(left: 20,right: 10),
        header: fluent.PageHeader(title: SearchBar()),
        content: (!fetched)
            ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: context.watch<AppTheme>().color, size: 300),
            )
            : Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 8.0),
              child: ListView(
                //controller: controller,
                  clipBehavior: Clip.hardEdge,
                  primary: false,

                    children: [
                      Text(
                        query == ''
                            ? 'Results for \"${widget.incomingquery}\"'
                            : 'Results for \"$query\"',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 30.0,
                        ),
                      ),
                      biggerSpacer,

                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Songs"
                            ),
                            Button(child: Text('Show more'), onPressed: () {},)
                          ],
                        ),

                      ),
                      spacer,
                      SizedBox(
                        height: MediaQuery.of(context).size.height *1/3,
                        child:
                          Placeholder()
                        //MusicList(isExpandedPage: false, incomingquery : 'home', songs: songs, toSongsList: query == '' ? widget.incomingquery : query),
                      ),
                      biggerSpacer,
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                "Artists"
                            ),
                            Button(child: const Text('Show more'), onPressed: () {},)
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
                            const Text(
                                "Albums"
                            ),
                            Button(child: const Text('Show more'), onPressed: () {},)
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
                            const Text(
                                "Albums"
                            ),
                            Button(child: const Text('Show more'), onPressed: () {},)
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







                    ],
                  ),
                ),
            );
  }
}

final autoSuggestBox = TextEditingController();

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            children: [
              Navigator.of(context).canPop()
                  ? mat.Material(
                      child: Row(
                        children: [
                          mat.InkWell(
                              child: const Icon(
                                  fluent.FluentIcons.chevron_left_med),
                              hoverColor: Colors.red,
                              onTap: () {
                                Navigator.of(context).pop();
                              }),
                          const fluent.SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Provider.of<AppTheme>(context, listen: false)
                            .color)),
                width: MediaQuery.of(context).size.width * 3 / 5,
                child: AutoSuggestBox(
                  clearButtonEnabled: true,
                  //controller: autoSuggestBox,
                  items: const [
                    'Blue',
                    'Green',
                    'Red',
                    'Yellow',
                    'Grey',
                  ],
                  onSelected: (text) {
                    print(text);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
