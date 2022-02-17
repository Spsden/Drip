import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/commonlistoftracks.dart';

import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../datasources/audiofiles/activeaudiodata.dart';
import '../datasources/searchresults/watchplaylistdataclass.dart';

class CurrentPlaylist extends StatefulWidget {
  final bool fromMainPage;

  const CurrentPlaylist({Key? key, required this.fromMainPage})
      : super(key: key);

  @override
  _CurrentPlaylistState createState() => _CurrentPlaylistState();
}

class _CurrentPlaylistState extends State<CurrentPlaylist> {
  List<Songs> _songs = [];

  //late List<Track> currentTracks = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;

    return ValueListenableBuilder<int>(
        valueListenable: currentTrackIndex,
        builder: (_, trck, __) {
          return ValueListenableBuilder<List<Track>>(
              valueListenable: tracklist,
              builder: (_, currentTracks, __) {
                // return CommonPlaylist(currentTracks: currentTracks, trck: trck,);

                if (currentTracks.isEmpty) {
                  return Text('Oops no playlist loaded');
                } else if (size.width > 900) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Play queue',
                          style: TextStyle(
                              fontSize: 40, fontWeight: mat.FontWeight.w600),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: size.height *70/100,
                          // margin: Edge,
                          decoration: BoxDecoration(
                            color: context.watch<AppTheme>().mode ==
                                        ThemeMode.dark ||
                                    context.watch<AppTheme>().mode ==
                                        ThemeMode.system
                                ? Colors.grey[150].withOpacity(0.6)
                                : Colors.grey[30],
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             AlbumArtCard(trck: trck, tracks: tracks),
                                   Expanded(
                                     child: Stack(
                                       children: [

                                         Container(
                                           margin : EdgeInsets.only(top : 40,),
                                           child: ListView.builder(

                                               controller: _scrollController,
                                               physics: const BouncingScrollPhysics(),
                                               shrinkWrap: true,
                                               itemCount: currentTracks.length,

                                               //controller: _sc,
                                               itemBuilder: (context, index) {
                                                 return  Padding(

                                                   padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                   child: TrackCardLarge(
                                                     data: TrackCardData(
                                                         title: currentTracks[index].title.toString(),
                                                         artist: currentTracks[index]
                                                             .artists![0]
                                                             .name
                                                             .toString(),
                                                         album: 'Drip',
                                                         duration:
                                                         currentTracks[index].length.toString(),
                                                         thumbnail: currentTracks[index]
                                                             .thumbnail![0]
                                                             .url
                                                             .toString()),
                                                     songIndex: index,
                                                     onTrackTap: () async {
                                                       var audioUrl =
                                                       await AudioControlClass.getAudioUri(
                                                           currentTracks[index].videoId.toString());
                                                       print(audioUrl.toString());

                                                       playerAlerts.buffering = true;
                                                       await context
                                                           .read<ActiveAudioData>()
                                                           .songDetails(
                                                           audioUrl,
                                                           currentTracks[index].videoId.toString(),
                                                           currentTracks[index].artists![0].name.toString(),
                                                           currentTracks[index].title.toString(),
                                                           currentTracks[index]
                                                               .thumbnail![0]
                                                               .url
                                                               .toString());
                                                       currentMediaIndex = 0;

                                                       await AudioControlClass.play(
                                                           audioUrl: audioUrl,
                                                           videoId:
                                                           currentTracks[index].videoId.toString(),
                                                           context: context);
                                                     },
                                                     color: index % 2 != 0
                                                         ? Colors.transparent
                                                         : context.watch<AppTheme>().mode == ThemeMode.dark ||
                                                         context.watch<AppTheme>().mode ==
                                                             ThemeMode.system
                                                         ? Colors.grey[150]
                                                         : Colors.grey[40], SuperSize: size,
                                                     widthy: 800,
                                                     fromQueue: true,
                                                   ),
                                                 );


                                               }),
                                         ),
                                         LayoutBuilder(
                                           builder: (context, constraints) =>
                                            Container(
                                              padding: EdgeInsets.all(5),
                                             width:constraints.maxWidth,
                                             color: Colors.transparent,
                                               child: Text('Up Next',
                                                 style :  typography.title
                                                       ?.copyWith(color: Colors.white,fontSize: 20)

                                               )),
                                         ),
                                       ],

                                     ),
                                   ),

                            ],
                          ),
                        )
                      ],
                    ),
                  );

                  //   Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     AlbumArtCard(tracks: currentTracks,trck: trck,),
                  //     Expanded(
                  //       child: ListView.builder(
                  //
                  //           controller: _scrollController,
                  //           physics: const BouncingScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: currentTracks.length,
                  //
                  //           //controller: _sc,
                  //           itemBuilder: (context, index) {
                  //             return  Padding(
                  //               padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
                  //               child: TrackCardLarge(
                  //                 data: TrackCardData(
                  //                     title: currentTracks[index].title.toString(),
                  //                     artist: currentTracks[index]
                  //                         .artists![0]
                  //                         .name
                  //                         .toString(),
                  //                     album: 'Drip',
                  //                     duration:
                  //                     currentTracks[index].length.toString(),
                  //                     thumbnail: currentTracks[index]
                  //                         .thumbnail![0]
                  //                         .url
                  //                         .toString()),
                  //                 songIndex: index,
                  //                 onTrackTap: () async {
                  //                   var audioUrl =
                  //                   await AudioControlClass.getAudioUri(
                  //                       currentTracks[index].videoId.toString());
                  //                    print(audioUrl.toString());
                  //
                  //                   playerAlerts.buffering = true;
                  //                   await context
                  //                       .read<ActiveAudioData>()
                  //                       .songDetails(
                  //                       audioUrl,
                  //                       currentTracks[index].videoId.toString(),
                  //                       currentTracks[index].artists![0].name.toString(),
                  //                       currentTracks[index].title.toString(),
                  //                       currentTracks[index]
                  //                           .thumbnail![0]
                  //                           .url
                  //                           .toString());
                  //                   currentMediaIndex = 0;
                  //
                  //                   await AudioControlClass.play(
                  //                       audioUrl: audioUrl,
                  //                       videoId:
                  //                       currentTracks[index].videoId.toString(),
                  //                       context: context);
                  //                 },
                  //                 color: index % 2 != 0
                  //                     ? Colors.transparent
                  //                     : context.watch<AppTheme>().mode == ThemeMode.dark ||
                  //                     context.watch<AppTheme>().mode ==
                  //                         ThemeMode.system
                  //                     ? Colors.grey[150]
                  //                     : Colors.grey[30], SuperSize: size,
                  //                 widthy: 800,
                  //                 fromQueue: true,
                  //               ),
                  //             );
                  //
                  //
                  //           }),
                  //     )
                  //
                  //
                  //   ],
                  // );
                } else {
                  return CustomScrollView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    slivers: [
                      mat.SliverAppBar(
                        expandedHeight: size.height * 0.4,
                        //pinned: true,
                        stretch: true,
                        snap: true,
                        elevation: 0,
                        //pinned: true,

                        floating: true,
                        stretchTriggerOffset: size.height / 6,

                        flexibleSpace: mat.FlexibleSpaceBar(
                          title: Text(
                            '${context.watch<ActiveAudioData>().title}  \n"',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          centerTitle: true,
                          titlePadding: const EdgeInsetsDirectional.only(
                            start: 72,
                            bottom: 16,
                            end: 120,
                          ),
                          background: Stack(
                            children: [
                              SizedBox.expand(
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return const LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                    ).createShader(
                                      Rect.fromLTRB(
                                        0,
                                        0,
                                        rect.width,
                                        rect.height,
                                      ),
                                    );
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: CachedNetworkImage(
                                    width: size.width,
                                    height: size.width,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) =>
                                        const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/cover.jpg'),
                                    ),
                                    imageUrl: currentTracks[trck]
                                            .thumbnail!
                                            .last
                                            .url
                                            .toString() ??
                                        'https://rukminim1.flixcart.com/image/416/416/poster/3/r/d/cute-cats-hd-poster-art-bshi4736-bshil4736-large-original-imaehwdptnnqz2sp.jpeg?q=70',
                                    placeholder: (context, url) => const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      SliverFillRemaining(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentTracks.length,

                              //controller: _sc,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                                  child: TrackCardLarge(
                                    data: TrackCardData(
                                        title: currentTracks[index]
                                            .title
                                            .toString(),
                                        artist: currentTracks[index]
                                            .artists![0]
                                            .name
                                            .toString(),
                                        album: 'Drip',
                                        duration: currentTracks[index]
                                            .length
                                            .toString(),
                                        thumbnail: currentTracks[index]
                                            .thumbnail![0]
                                            .url
                                            .toString()),
                                    songIndex: index,
                                    onTrackTap: () async {
                                      var audioUrl =
                                          await AudioControlClass.getAudioUri(
                                              currentTracks[index]
                                                  .videoId
                                                  .toString());
                                      print(audioUrl.toString());

                                      playerAlerts.buffering = true;
                                      await context
                                          .read<ActiveAudioData>()
                                          .songDetails(
                                              audioUrl,
                                              currentTracks[index]
                                                  .videoId
                                                  .toString(),
                                              currentTracks[index]
                                                  .artists![0]
                                                  .name
                                                  .toString(),
                                              currentTracks[index]
                                                  .title
                                                  .toString(),
                                              currentTracks[index]
                                                  .thumbnail![0]
                                                  .url
                                                  .toString());
                                      currentMediaIndex = 0;

                                      await AudioControlClass.play(
                                          audioUrl: audioUrl,
                                          videoId: currentTracks[index]
                                              .videoId
                                              .toString(),
                                          context: context);
                                    },
                                    color: index % 2 != 0
                                        ? Colors.transparent
                                        : context.watch<AppTheme>().mode ==
                                                    ThemeMode.dark ||
                                                context
                                                        .watch<AppTheme>()
                                                        .mode ==
                                                    ThemeMode.system
                                            ? Colors.grey[150]
                                            : Colors.grey[30],
                                    SuperSize: size,
                                    widthy: 800,
                                    fromQueue: true,
                                  ),
                                );
                              }))
                    ],
                  );
                }
              });
        });
  }
}

class AlbumArtCard extends StatelessWidget {
  final int trck;
  final List<Track> tracks;

  const AlbumArtCard({Key? key, required this.trck, required this.tracks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: mat.CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: size.width > 1000 ? 500 : size.width / 2.5,
            maxWidth: size.width > 1000 ? 500 : size.width / 2.5,
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8)
          // ),

          child: mat.Card(
            clipBehavior: Clip.antiAlias,
            shape: mat.RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Stack(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.luminosity,
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black
                                ]).createShader(bounds);
                          },
                          child: CachedNetworkImage(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                            const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/artist.jpg'),
                            ),
                            imageUrl: tracks[trck]
                                .thumbnail!
                                .last
                                .url
                                .toString(),
                            placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/artist.jpg')),
                          ),
                        ),
                        Container(
                          height:
                              min(constraints.maxHeight, constraints.maxWidth),
                          width:
                              min(constraints.maxHeight, constraints.maxWidth),
                          //margin: const mat.EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    "Now Playing",
                                    style: typography.title
                                        ?.copyWith(color: Colors.white,fontSize: 30)

                                  // const mat.TextStyle(
                                  //   fontSize: 20,
                                  // ),

                                ),
                                Text(
                                    "${context.watch<ActiveAudioData>().title}",
                                    style: typography.title
                                        ?.copyWith(color: Colors.white,fontSize: 20)

                                    // const mat.TextStyle(
                                    //   fontSize: 20,
                                    // ),

                                    ),
                                Text(
                                    "${context.watch<ActiveAudioData>().artists}  ",
                                    textAlign: mat.TextAlign.left,
                                    style: typography.subtitle
                                        ?.copyWith(color: Colors.white,fontSize: 15)),
                                //TextSpan(text:"${context.watch<ActiveAudioData>().}"),
                              ],
                            ),
                          ),

                        )
                      ],
                    )),
          ),
        ),
      ],
    );
  }
}
