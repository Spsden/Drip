
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/audiofiles/audiodartclass.dart';
import 'package:drip/datasources/audiofiles/audiodata.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../audioplayerbar.dart';

class MusicList extends StatefulWidget {
  final bool isExpandedPage;
  final String incomingquery;
  final List<Songs> songs ;
  final String toSongsList;


  const MusicList({Key? key, required this.isExpandedPage, required this.incomingquery, required this.songs, required this.toSongsList}) : super(key: key);

  @override
  MusicListState createState() => MusicListState();
}

class MusicListState extends State<MusicList> {


  // static List<Songs> songlist = [];
  // //List<Songs> threesonglist = songs;
  // static int page = 0;
  // int numofresultsload = 10;
  // ScrollController _sc = ScrollController();
  // bool isLoading = false;
  // bool fetched = false;
  // String thispagesearchquery = '';
  // final YoutubeExplode _youtubeExplode = YoutubeExplode();
  //
  // AudioPlayerBarState _audioPlayerBarState = AudioPlayerBarState();
  //
  // late final Music music;
  //
  // // List<Songs> get songs => widget.songs;







  @override
  Widget build(BuildContext context) {
    if (widget.isExpandedPage == false) {
      return MusicListWidget(toSongsList: widget.toSongsList,songs: widget.songs,);
    } else {
      return Container(
        color: Colors.black,
        child: Column(
          children: [
            fluent.SizedBox(
              height: 150,
              child: Column(

                children: [

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
                    child: Row(
                      children: [
                        Navigator.of(context).canPop()
                            ? Row(
                          children: [
                            InkWell(
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
                        ): const SizedBox(),



                      ],
                    ),
                  )
                ],
              )
            ),
            MusicListWidget(toSongsList: widget.toSongsList, songs: widget.songs,),
          ],
        )
      );
    }}
}

class MusicListWidget extends StatefulWidget {
  final List<Songs> songs ;
  final String toSongsList;

  const MusicListWidget({Key? key, required this.songs, required this.toSongsList}) : super(key: key);

  @override
  MusicListWidgetState createState() => MusicListWidgetState();
}

class MusicListWidgetState extends State<MusicListWidget> {


  // static List<Songs> songlist = [];
  // //List<Songs> threesonglist = songs;
  // static int page = 0;
  // int numofresultsload = 10;
  // ScrollController _sc = ScrollController();
  // bool isLoading = false;
  // bool fetched = false;
  // String thispagesearchquery = '';
  // final YoutubeExplode _youtubeExplode = YoutubeExplode();


  static List<Songs> songlist = [];
  //List<Songs> threesonglist = songs;
  static int page = 0;
  int numofresultsload = 10;
  ScrollController _sc = ScrollController();
  bool isLoading = false;
  bool fetched = false;
  String thispagesearchquery = '';
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

 // AudioPlayerBarState _audioPlayerBarState = AudioPlayerBarState();






  @override
  void initState() {

   // music = Music();
    //songLoader(0);
    super.initState();
    //
    // context.watch<MusicListDataManagement>().sc.addListener(() {
    //   if(context.watch<MusicListDataManagement>().sc == context.watch<MusicListDataManagement>().sc.position.maxScrollExtent && !context.watch<MusicListDataManagement>().isLoading ) {
    //     songLoader(context.watch<MusicListDataManagement>().page);
    //   }
    // });

    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent && !isLoading) {
    //     songLoader(page);
    //   }
    // });
  }

  void songLoader(int page) {
    if (!context.watch<MusicListDataManagement>().isLoading) {
      setState(() {
        context.read<MusicListDataManagement>().setIsLoading(true) ;
      });
    }
    SearchMusic.getOnlySongs(
        context.watch<MusicListDataManagement>().thisPageSearchQuery == ''
            ? widget.toSongsList
            : context.watch<MusicListDataManagement>().thisPageSearchQuery,
        context.watch<MusicListDataManagement>().numOfResultsToLoad)
        .then((value) {
      if (this.mounted) {
        setState(() {
          context.read<MusicListDataManagement>().setSongList(value);
          context.read<MusicListDataManagement>().setFetched(true);
          context.read<MusicListDataManagement>().setIsLoading(false);
          context.read<MusicListDataManagement>().setPage();
          context.read<MusicListDataManagement>().setLoad();


          //songlist = value;
          //fetched = true;
          //isLoading = false;
          //page++;
          //numofresultsload += 20;
        });
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
    _youtubeExplode.close();
  }
  Future<String> getAudioUri(String videoId) async{
    final StreamManifest manifest =
    await _youtubeExplode.videos.streamsClient.getManifest(videoId);

    var audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

    return audioUrl;


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (!fetched)
          ? Container(
          alignment: Alignment.center,
          width: 500,
          height: 500,
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.red, size: 300))
          : Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
            itemCount: songlist.length + 1,
            controller: _sc,
            shrinkWrap: true,

            itemBuilder: (context, index) {
              if (index == songlist.length) {
                return Container(
                    alignment: Alignment.center,
                    width: 500,
                    height: 500,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.red, size: 100));
              } else {
                return InkWell(
                  //splashColor: Colors.red,
                  hoverColor: Colors.red.withOpacity(0.4),
                  onDoubleTap: ()  async{
                    var audioUrl;
                    //audioUrl = await getAudioUri(songlist[index].videoId);
                    audioUrl = await getAudioUri(context.watch<MusicListDataManagement>().songList[index].videoId);


                    // AudioPlayerBarState().buffering = true;

                    playerAlerts.buffering = true;

                    // await context
                    //     .read<AudioData>()
                    //     .songDetails(
                    //     audioUrl,
                    //     songlist[index].videoId,
                    //    songlist[index].artists![0].name,
                    //    songlist[index].title,
                    //    songlist[index].thumbnails[0].url);

                    await context.read<ActiveAudioData>().songDetails(audioUrl,
                        context.watch<MusicListDataManagement>().songList[index].videoId,
                        context.watch<MusicListDataManagement>().songList[index].artists![0].name,
                        context.watch<MusicListDataManagement>().songList[index].title,
                        context.watch<MusicListDataManagement>().songList[index].thumbnails[0].url);





                    // music.filePath = audioUrl;
                    // music.networkAlbumArt = songlist[index].thumbnails[0].url;
                    // music.albumArtistName =  songlist[index].artists![0].name;
                    // music.trackName = songlist[index].title;
                    // music.trackId = songlist[index].videoId;



                    // await context
                    //     .read<Music>()
                    //     .songDetails(
                    //     audioUrl,
                    //     songlist[index].videoId,
                    //     songlist[index].artists![0].name,
                    //     songlist[index].title,
                    //     songlist[index].thumbnails[0].url);





                    await AudioControlClass.play(audioUrl: audioUrl);



                  },


                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: fluent.BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.black12
                    ),
                    
                    // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    //color: Colors.brown.withOpacity(0.4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        fluent.MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 40,
                              height: 40,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                errorWidget: (context, _, __) =>
                                const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/cover.jpg'),
                                ),
                                imageUrl:  context.watch<MusicListDataManagement>().songList[index].thumbnails[0].url
                                    .toString(),
                                placeholder: (context, url) =>
                                const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/cover.jpg')),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              context.watch<MusicListDataManagement>().songList[index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            fluent.FluentIcons.play_solid,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              context.watch<MusicListDataManagement>().songList[index].artists![0].name
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 200,
                              child: Text(
                                context.watch<MusicListDataManagement>().songList[index].album
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 150,
                              child: Text(
                                  context.watch<MusicListDataManagement>().songList[index].duration.toString(),
                            // songlist[index].duration.toString(),
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
            //width: 400,
            child: Row(
              children: [
                Navigator.of(context).canPop()
                    ? Row(
                  children: [
                    InkWell(
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
                )
                    : SizedBox(),
                fluent.SizedBox(
                  width: 400,
                  child: CupertinoSearchTextField(
                    style: TextStyle(color: Colors.white),
                    onSubmitted: (_value) async {
                      setState(() {
                       // MusicListWidgetState().songlist.clear();
                        MusicListWidgetState().numofresultsload = 20;
                        MusicListWidgetState.page = 0;
                        MusicListWidgetState().thispagesearchquery = _value;
                        MusicListWidgetState().songLoader(MusicListWidgetState.page);
                        MusicListWidgetState().fetched = true;
                      });
                    },
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
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              MusicListWidgetState().thispagesearchquery == ''
                  ? 'Results for \"${MusicListState().widget.incomingquery}\"'
                  : 'Results for \"$MusicListWidgetState().thispagesearchquery\"',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 40.0,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class MusicListDataManagement extends ChangeNotifier{

   List<Songs> _songList = [];

   int _page = 0;
  int _numOfResultsToLoad = 10;
  ScrollController _sc = ScrollController();
  bool _isLoading = false;
  bool _fetched = false;
  String _thisPageSearchQuery = '';
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  AudioPlayerBarState _audioPlayerBarState = AudioPlayerBarState();

  late final Music music;





  List<Songs> get songList => _songList;
  int get page => _page;
  int get numOfResultsToLoad => _numOfResultsToLoad;
   ScrollController get sc => _sc;
   bool get isLoading =>  _isLoading;
   bool get fetched => _fetched;
   String get thisPageSearchQuery => _thisPageSearchQuery;


   void setSongList(List<Songs> musicList){
     _songList = musicList;
   }

   // void setPage(int pageNum){
   //   _page = pageNum;
   // }
   void setPage(){
     _page++;
   }

   void setLoad(){
     _numOfResultsToLoad += 20;
   }

   void setScroll(fluent.ScrollController scrollControl){
     _sc = scrollControl;
   }

   void setIsLoading(bool loading){
     _isLoading = loading;
   }

   void setFetched(bool fetch){
     _fetched = fetch;
   }

   void setThisPageSearch(String searchQuery){
     _thisPageSearchQuery = searchQuery;
   }



   // MusicListDataManagement(){
   //   void songLoader(int page) {
   //     if (!isLoading) {
   //       setState(() {
   //         context.read<MusicListDataManagement>().setIsLoading(true) ;
   //       });
   //     }
   //     SearchMusic.getOnlySongs(
   //         context.watch<MusicListDataManagement>().thisPageSearchQuery == ''
   //             ? widget.toSongsList
   //             : context.watch<MusicListDataManagement>().thisPageSearchQuery,
   //         context.watch<MusicListDataManagement>().numOfResultsToLoad)
   //         .then((value) {
   //       if (this.mounted) {
   //         setState(() {
   //           context.read<MusicListDataManagement>().setSongList(value);
   //           context.read<MusicListDataManagement>().setFetched(true);
   //           context.read<MusicListDataManagement>().setIsLoading(false);
   //           context.read<MusicListDataManagement>().setPage();
   //           context.read<MusicListDataManagement>().setLoad();
   //
   //
   //           //songlist = value;
   //           //fetched = true;
   //           //isLoading = false;
   //           //page++;
   //           //numofresultsload += 20;
   //         });
   //       }
   //     });
   //   }
   //
   // }






}


