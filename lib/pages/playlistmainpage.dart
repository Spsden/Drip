import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/searchresults/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/pages/common/backButton.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart'
    as watch;

import '../datasources/audiofiles/activeaudiodata.dart';
import '../theme.dart';
import 'common/track_cards.dart';

class PlaylistMain extends StatefulWidget {
  final String playlistId;

  const PlaylistMain({Key? key, required this.playlistId}) : super(key: key);

  @override
  _PlaylistMainState createState() => _PlaylistMainState();
}

class _PlaylistMainState extends State<PlaylistMain> {
  late Playlists _playlists;

  List<Track> _tracks = [];
  List<watch.Track> tracks2 = [];

  bool status = false;
  bool fetched = false;
 // final myProducts = List<String>.generate(100, (i) => 'Product $i');

  @override
  void initState() {

    super.initState();


  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;
    if (!status) {
      status = true;
      SearchMusic.getPlaylist(widget.playlistId, 10).then((value) => {
            if (mounted)
              {
                setState(() {
                  _playlists = value;
                  _tracks = _playlists.tracks;

                  // _playlists = value;
                  // _tracks = _playlists.tracks;
                  //
                  fetched = true;
                })
              }
          });
    }

    return Stack(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: FloatingBackButton(onPressed: () {
        //     Navigator.of(context).pop();
        //   },)
        //
        //
        //   // mat.FloatingActionButton.small(
        //   //     child: Icon(FluentIcons.back),
        //   //     onPressed: () {
        //   //
        //   //     }),
        // ),



        (!fetched)
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: context.watch<AppTheme>().color, size: 300),
              )
            : SingleChildScrollView(
                // padding: EdgeInsets.all(15),
                // controller: _scrollController,
                clipBehavior: Clip.hardEdge,
                primary: false,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),

                /// padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(08),
                          color: context.watch<AppTheme>().mode ==
                                      ThemeMode.dark ||
                                  context.watch<AppTheme>().mode ==
                                      ThemeMode.system
                              ? Colors.grey[150].withOpacity(0.6)
                              : Colors.grey[30].withOpacity(0.9)),
                      width: size.width * 0.9,
                      height: size.width > 500
                          ? size.height * 0.27
                          : size.height * 0.23,
                      child: LayoutBuilder(
                        builder: (context, constraints) => Row(
                          children: [
                            CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),

                              width: size.width > 500
                                  ? size.height / 4.4
                                  : constraints.maxWidth / 2.8,
                              height: size.width > 500
                                  ? size.height / 4.4
                                  : constraints.maxWidth / 2.8,

                              fit: BoxFit.cover,
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              imageUrl:
                                  _playlists.thumbnails.last.url.toString(),

                              placeholder: (context, url) => const Image(
                                  // width: size.width,
                                  //   height: size.width,
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg')),
                            ),
                            spacer,
                            Column(
                              crossAxisAlignment:
                                  mat.CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth / 1.7,
                                  child: Text(
                                    _playlists.title.toString(),
                                    style: typography.titleLarge,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                spacer,
                                Text(
                                  '${_playlists.trackCount.toString()}  items   ',
                                  softWrap: true,
                                  // maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth / 2,
                                  child: Text(
                                    _playlists.description.toString(),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight / 12,
                                ),
                                FilledButton(
                                  child: Row(
                                    children: const [
                                      Icon(FluentIcons.play),
                                      spacer,
                                      Text(
                                        'Shuffle',
                                          style: TextStyle(
                                              color: Colors.white,fontWeight: FontWeight.w500
                                          )
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(15),
                        itemCount: _tracks.length,

                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                            child: TrackCardLarge(
                              data: TrackCardData(
                                  title: _tracks[index].title.toString(),
                                  artist: _tracks[index]
                                      .artists
                                      .first
                                      .name
                                      .toString(),
                                  album: 'Drip',
                                  duration:
                                      _tracks[index].duration.toString(),
                                  thumbnail: _tracks[index]
                                      .thumbnails![0]
                                      .url
                                      .toString()),
                              songIndex: index,
                              onTrackTap: () async {
                                var audioUrl =
                                    await AudioControlClass.getAudioUri(
                                        _tracks[index].videoId.toString());
                                // print(audioUrl.toString());

                                playerAlerts.buffering = true;
                                await context
                                    .read<ActiveAudioData>()
                                    .songDetails(
                                        audioUrl,
                                        _tracks[index].videoId.toString(),
                                        _tracks[index].artists![0].name,
                                        _tracks[index].title.toString(),
                                        _tracks[index]
                                            .thumbnails[0]
                                            .url
                                            .toString(),
                                    _tracks[index].thumbnails.map((e) => ThumbnailLocal(height: e.height, url: e.url.toString(), width: e.width)).toList(),
                                _tracks[index].thumbnails.last.url.toString());
                                currentMediaIndex = 0;

                                await AudioControlClass.play(
                                    audioUrl: audioUrl,
                                    videoId:
                                        _tracks[index].videoId.toString(),
                                    context: context);
                              },
                              color: index % 2 != 0
                                  ? Colors.transparent
                                  : context.watch<AppTheme>().mode == ThemeMode.dark ||
                                  context.watch<AppTheme>().mode ==
                                      ThemeMode.system
                                  ? Colors.grey[150]
                                  : Colors.grey[30] , fromQueue: false, SuperSize: size,
                            ),
                          );


                        }),
                    SizedBox(height: 120,)
                  ],
                ),
              ),
        Positioned.fill(
          top: 10,
          left: 10,
          child: Align(
              alignment: Alignment.topLeft,
              child: FloatingBackButton(onPressed: () {
                Navigator.of(context).pop();
              },)
          ),
        ),
      ],
    );
  }
}
