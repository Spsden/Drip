import 'dart:ffi';

import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/musiclist.dart';
import 'package:drip/pages/primarysearchresults.dart';
import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/communityplaylistresultwidget.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as mat;

class SearchFunction extends StatefulWidget {
  final bool liveSearch;
  final Widget body;
  final FloatingSearchBarController controller;
  final Function(String) onSubmitted;

  const SearchFunction({Key? key, required this.liveSearch, required this.body, required this.controller, required this.onSubmitted,}) : super(key: key);

  @override
  _SearchFunctionState createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction> with AutomaticKeepAliveClientMixin<SearchFunction>{
  static const _historyLength = 5;

  List<String> _searchHistory = ['Atif', 'Arijit', 'Sonu', 'Prateek'];
  late List<String> filteredSearchHistory;
   String selectedTerm = '';

  // bool status = false;
  late Map listOfSearchResults = {};
  late List<Artists> artists = [];
  late List<Albums> albums = [];
  late List<Songs> songs = [];
  late List<CommunityPlaylist> communityPlaylists = [];


 /// late bool fetched = false;

  Future<void> getPrimarySearchResults(String search) async {
    SearchMusic.getArtists(search ).then((value) {
      if (mounted) {
        setState(() {

          listOfSearchResults = value;
          artists = listOfSearchResults['artistsearch'];
          songs = listOfSearchResults['songsearch'];
          communityPlaylists = listOfSearchResults['communityplaylistsearch'];
          albums = listOfSearchResults['albumsearch'];
          //fetched = true;
          // _topresults = listOfSearchResults['topresults'];

        });
      }
    });
  }

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > _historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - _historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController floatController;


  @override
  void initState() {
   // selectedTerm = '';
    super.initState();
    filteredSearchHistory = filterSearchTerms(filter: '');
    floatController = FloatingSearchBarController();
  }

  @override
  void dispose() {
    floatController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);



    return mat.Scaffold(
      body: FloatingSearchBar(
        controller: widget.controller,
        body: widget.body,

        // PrimarySearchResults(
        //   searchTerm: 'lol',
        //   songs: songs,
        //   albums: albums,
        //   artists: artists,
        //   communityPlaylists: communityPlaylists,
        // ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(selectedTerm),
        hint: "Let's Play.....",
        actions: [FloatingSearchBarAction.searchToClear()],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) async {
          selectedTerm = query;
          widget.onSubmitted(query);

          //await getPrimarySearchResults(selectedTerm);

          addSearchTerm(query);
          //print(widget.IncomingQuery);

          floatController.close();
        },
        builder: (BuildContext context, Animation<double> transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: mat.Material(
              // color: Colors.white,
              elevation: 4,
              child: mat.Builder(
                builder: (context) {
                  if (filteredSearchHistory.isNotEmpty &&
                      floatController.query.isEmpty) {
                    return mat.Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: mat.TextOverflow.ellipsis,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return mat.ListTile(
                      title: Text(floatController.query),
                      leading: const Icon(FluentIcons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(floatController.query);
                          selectedTerm = floatController.query;
                        });
                        floatController.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => mat.ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: Icon(mat.Icons.history),
                              trailing: IconButton(
                                icon: const Icon(mat.Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                floatController.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return mat.Material(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              mat.Icon(
                mat.Icons.search,
                size: 64,
              ),
              Text(
                'Start searching',
                // style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
      );
    }

    return ListView(
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}

// class SearchPage extends StatefulWidget {
//   final String inComingQuery;
//
//   const SearchPage({
//     Key? key,
//     required this.inComingQuery,
//   }) : super(key: key);
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   // final autoSuggestBox = TextEditingController();
//
//   String query = '';
//   bool status = false;
//   late Map listOfSearchResults = {};
//   late List<Artists> artists = [];
//   late List<Albums> albums = [];
//   late List<Songs> songs = [];
//   late List<CommunityPlaylist> communityPlaylists = [];
//   bool fetched = false;
//
//   // //late  ScrollController controller;
//   // void setFetched(bool fetchedSetter) {
//   //   fetchedSetter = fetched;
//   // }
//   //
//   // void setStatus(bool statusSetter) {
//   //   statusSetter = status;
//   // }
//   //
//   // void setListOfResults(Map listOfResultsSetter) {
//   //   listOfSearchResults = listOfResultsSetter;
//   // }
//   //
//   // void setQuery(String querySetter) {
//   //   query = querySetter;
//   // }
//
//   // @override
//   // bool get wantKeepAlive => true;
//
//   @override
//   void initState() {
//     super.initState();
//     //controller = ScrollController();
//
//     // WidgetsBinding.instance?.addPostFrameCallback((_) {
//     //   //controller = ScrollController(keepScrollOffset: true,initialScrollOffset: 0.0);
//     //   //write or call your logic
//     //   //code will run when widget rendering complete
//     // });
//   }
//
//   @override
//   void dispose() {
//     // controller.dispose();
//
//     super.dispose();
//   }
//
//   // setStateCallBack() {
//   //   if (mounted) {
//   //     setState(() {});
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     //super.build(context);
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//
//     if (!status) {
//       status = true;
//       SearchMusic.getArtists(widget.inComingQuery).then((value) {
//         if (mounted) {
//           setState(() {
//             listOfSearchResults = value;
//             artists = listOfSearchResults['artistsearch'];
//             songs = listOfSearchResults['songsearch'];
//             communityPlaylists = listOfSearchResults['communityplaylistsearch'];
//             albums = listOfSearchResults['albumsearch'];
//             // _topresults = listOfSearchResults['topresults'];
//             fetched = true;
//           });
//         }
//       });
//     }
//     return (!fetched)
//         ? Center(
//             child: LoadingAnimationWidget.staggeredDotsWave(
//                 color: context.watch<AppTheme>().color, size: 300),
//           )
//         : Padding(
//             padding: const EdgeInsets.only(left: 10.0, right: 8.0),
//             child: ListView(
//               //controller: controller,
//               clipBehavior: Clip.hardEdge,
//               primary: false,
//
//               children: [
//                 Text(
//                   query == ''
//                       ? 'Results for \"${widget.inComingQuery}\"'
//                       : 'Results for \"$query\"',
//                   style: const TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     fontSize: 30.0,
//                   ),
//                 ),
//                 biggerSpacer,
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Songs"),
//                       Button(
//                         child: Text('Show more'),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//                 spacer,
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height * 1 / 3,
//                     child: Placeholder()
//                     //MusicList(isExpandedPage: false, incomingquery : 'home', songs: songs, toSongsList: query == '' ? widget.incomingquery : query),
//                     ),
//                 biggerSpacer,
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Artists"),
//                       Button(
//                         child: const Text('Show more'),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//                 spacer,
//                 artists.isNotEmpty
//                     ? ArtistsSearch(artists: artists)
//                     : const Text('No Artists available'),
//                 //biggerSpacer,
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Albums"),
//                       Button(
//                         child: const Text('Show more'),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//                 spacer,
//                 albums.isNotEmpty
//                     ? AlbumSearch(albums: albums)
//                     : Text('No Albums available'),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 // biggerSpacer,
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Albums"),
//                       Button(
//                         child: const Text('Show more'),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//                 spacer,
//                 communityPlaylists.isNotEmpty
//                     ? CommunityPlaylistSearch(
//                         communityPlaylist: communityPlaylists)
//                     : Text('No Playlists available'),
//
//                 biggerSpacer,
//                 biggerSpacer,
//               ],
//             ),
//           );
//   }
// }
