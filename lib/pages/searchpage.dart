import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/navigation/navigationstacks.dart';
import 'package:drip/pages/common/commonlistoftracks.dart';

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
import 'package:lottie/lottie.dart';
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
    // if(widget.searchQuery == ''){
    //   return Container(
    //     child: Text(
    //       'Search Something Dude',
    //           style:  TextStyle(
    //         fontSize: 50
    //     ),
    //     ),
    //   );
    // }
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
             topResult = listOfSearchResults['topresults'];
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
      body:

          // _controller.query.isEmpty ?  Center(
          //   child: Column(
          //     children: [
          //       SizedBox(height: MediaQuery.of(context).size.height/2,),
          //       Lottie.asset('assets/searchanimation.json'),
          //       Text('Search something',style: typography.body,)
          //     ],
          //   ),
          // ) :

          (!fetched)
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: context.watch<AppTheme>().color, size: 300),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 90),
                  child: ScrollConfiguration(
                    behavior: const FluentScrollBehavior(),
                    child: ListView(
                      dragStartBehavior: DragStartBehavior.down,
                      physics: BouncingScrollPhysics(
                          parent: const ClampingScrollPhysics()),
                      //controller: controller,
                      clipBehavior: Clip.hardEdge,
                      primary: false,

                      children: [
                        //mat.RaisedButton(onPressed: () => Navigator.of(context).context.findAncestorStateOfType<NavigatorState>()?.pop()),
                        Text(
                          query == ''
                              ? 'Results for \"${widget.searchQuery}\"'
                              : 'Results for \"$query\"',
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
                            children: [
                              Text(
                                "Top result",
                                style: typography.subtitle
                                    ?.apply(fontSizeFactor: 1.0),
                              ),
                              const SizedBox(height: 15,),
                              if(topResult.resultType == 'video')
                                 Container(
                                   margin: EdgeInsets.only(left: 20,right: 20),
                                   child: TrackCardLarge(data: TrackCardData(
                                     duration: topResult.duration,
                                     album: '',
                                     title: topResult.title,
                                     artist: '',
                                     thumbnail: ''
                                   ),
                                       songIndex: 0,
                                       onTrackTap: ()  {}, color: context.watch<AppTheme>().mode == ThemeMode.dark ||
                                           context.watch<AppTheme>().mode ==
                                               ThemeMode.system
                                           ? Colors.grey[150]
                                           : Colors.grey[30]
                                       , SuperSize: MediaQuery.of(context).size, fromQueue: false),
                                 ),
                              if(topResult.resultType == 'artist')
                                Container(
                                  child: mat.InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed('artistsPage',
                                          arguments: topResult.browseId.toString());
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                      width: 220,
                                      height: 250,
                                      child: mat.Card(
                                        shadowColor: Colors.transparent,
                                        color: Colors.transparent,
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                                backgroundColor: mat.Colors.transparent,
                                                foregroundColor: Colors.transparent,
                                                radius: 100,
                                                backgroundImage: imageProvider,
                                              ),
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) => const Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage('assets/artist.jpg'),
                                              ),
                                              imageUrl:  topResult.thumbnails.last.url.toString(),
                                              placeholder: (context, url) => const Image(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage('assets/artist.jpg')),
                                            ),
                                            //const SizedBox(height: 20,),
                                            Text(
                                              topResult.artist.toString(),
                                              style:
                                              typography.body?.apply(fontSizeFactor: 1.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )


                              //Text(topResult.resultType)




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
                                      arguments: query == ''
                                          ? widget.searchQuery
                                          : query);
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
                                onPressed: () {},
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
                                onPressed: () {},
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
                                onPressed: () {},
                              ),
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
