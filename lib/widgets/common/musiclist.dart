import 'package:drip/datasource/audioplayer/audiodartclass.dart';
import 'package:drip/datasource/audioplayer/audiodata.dart';
import 'package:drip/datasource/audioplayer/audioplayer2.dart';
import 'package:drip/datasource/audioplayer/audioplayerbar.dart';
import 'package:drip/datasource/searchresults/searchresultstwo.dart';
import 'package:drip/datasource/searchresults/songsdataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:cached_network_image/cached_network_image.dart';

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






  @override
  Widget build(BuildContext context) {
    if (widget.isExpandedPage == false) {
      return MusicListWidget(toSongsList: widget.toSongsList,songs: widget.songs,);
    } else {
      return Column(
      children: [
        SearchBar(),
        MusicListWidget(toSongsList: widget.toSongsList, songs: widget.songs,)

      ],
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


  List<Songs> songlist = [];
  //List<Songs> threesonglist = songs;
  static int page = 0;
  int numofresultsload = 10;
  ScrollController _sc = ScrollController();
  bool isLoading = false;
  bool fetched = false;
  String thispagesearchquery = '';
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  AudioPlayerBarState _audioPlayerBarState = AudioPlayerBarState();

  late final Music music;

  // List<Songs> get songs => widget.songs;





  @override
  void initState() {

    music = Music();
    songLoader(page);
    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !isLoading) {
        songLoader(page);
      }
    });
  }

  void songLoader(int page) {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    SearchMusic.getOnlySongs(
        thispagesearchquery == ''
            ? widget.toSongsList
            : thispagesearchquery,
        numofresultsload)
        .then((value) {
      if (this.mounted) {
        setState(() {
          songlist = value;
          fetched = true;
          isLoading = false;
          page++;
          numofresultsload += 20;
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
                  hoverColor: Colors.red.withOpacity(0.4),
                  onDoubleTap: ()  async{
                    var audioUrl;
                    audioUrl = await getAudioUri(songlist[index].videoId);


                    // AudioPlayerBarState().buffering = true;

                    playerAlerts.buffering = true;

                    await context
                        .read<AudioData>()
                        .songDetails(
                        audioUrl,
                        songlist[index].videoId,
                       songlist[index].artists![0].name,
                       songlist[index].title,
                       songlist[index].thumbnails[0].url);





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
                    // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    color: Colors.brown.withOpacity(0.4),
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
                                imageUrl: songlist[index]
                                    .thumbnails[0]
                                    .url
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
                              songlist[index].title.toString(),
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
                              songlist[index]
                                  .artists![0]
                                  .name
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
                                songlist[index]
                                    .album!
                                    .name
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 150,
                              child: Text(
                             songlist[index].duration.toString(),
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
                        MusicListWidgetState().songlist.clear();
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


