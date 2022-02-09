import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../datasources/audiofiles/audiodata.dart';
import '../datasources/searchresults/watchplaylistdataclass.dart';

class CurrentPlaylist extends StatefulWidget {
  const CurrentPlaylist({Key? key}) : super(key: key);

  @override
  _CurrentPlaylistState createState() => _CurrentPlaylistState();
}

class _CurrentPlaylistState extends State<CurrentPlaylist> {
  List<Songs> _songs = [];

  //late List<Track> currentTracks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // currentTracks = tracks;
    //currentTracks = tracks;

    //currentTracks = context.watch<PlayerNotifiers>().track;
    // tracks.map((element)  {
    //   _songs.forEach((subelement) {
    //     subelement.title = element.title!;
    //     subelement.artists![0].name = element.artists![0].name!;
    //    // subelement.duration = element.
    //     subelement.thumbnails[0].url = element.thumbnail![0].url!;
    //     subelement.videoId = element.videoId!;
    //
    //   });
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;
    if (MediaQuery.of(context).size.width > 700) {
      return ValueListenableBuilder<int>(
          valueListenable: currentTrackIndex,
          builder: (_, trck, __) {
            return ValueListenableBuilder<List<Track>>(
                valueListenable: tracklist,
                builder: (_, currentTracks, __) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const AlbumArtCard(),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: size.height - 200,
                          width: size.width / 2.5,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // border: Border.all(
                              //     width: 2,
                              //     color: context.watch<AppTheme>().color)
                          ),
                          child: ListView.builder(
                              itemCount: currentTracks.length,
                              shrinkWrap: true,
                              //controller: _sc,
                              itemBuilder: (context, index) {
                                return HoverButton(
                                  cursor: SystemMouseCursors.copy,
                                  // splashColor: Colors.grey[130],
                                  // customBorder: mat.ShapeBorder(),
                                  //hoverColor: Colors.grey[130],
                                  onPressed: () async {
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
                                            _songs[index].videoId,
                                            _songs[index].artists![0].name,
                                            _songs[index].title,
                                            _songs[index].thumbnails[0].url);

                                    currentMediaIndex = 0;

                                    await AudioControlClass.play(
                                        audioUrl: audioUrl,
                                        videoId:
                                            _songs[index].videoId.toString(),
                                        context: context);
                                  },
                                  builder: (BuildContext, states) {
                                    return AnimatedContainer(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 15),
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: index == trck ? context.watch<AppTheme>().color :
                                              context.watch<AppTheme>().mode ==
                                                          ThemeMode.dark ||
                                                      context
                                                              .watch<AppTheme>()
                                                              .mode ==
                                                          ThemeMode.system
                                                  ? Colors.grey[150]
                                                  : Colors.grey[30]),
                                      duration: FluentTheme.of(context)
                                          .fastAnimationDuration,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(width: 5,),
                                              CachedNetworkImage(
                                                width: 40,
                                                height: 40,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor:
                                                      Colors.transparent,
                                                  radius: 100,
                                                  backgroundImage:
                                                      imageProvider,
                                                ),
                                                fit: BoxFit.cover,
                                                errorWidget: (context, _, __) =>
                                                    const Image(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/cover.jpg'),
                                                ),
                                                imageUrl: currentTracks[index]
                                                    .thumbnail![0]
                                                    .url
                                                    .toString()
                                                    .toString(),

                                                // widget.isFromPrimarySearchPage ? _songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
                                                placeholder: (context, url) =>
                                                    const Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/cover.jpg')),
                                              ),
                                              spacer,

                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    8,
                                                child: Text(
                                                  currentTracks[index]
                                                      .title
                                                      .toString(),
                                                  // widget.isFromPrimarySearchPage ? _songs[index].title.toString() : 'Kuch is tarah',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              spacer,
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    15,
                                                child: Text(
                                                  currentTracks[index]
                                                      .artists![0]
                                                      .name
                                                      .toString(),
                                                  // widget.isFromPrimarySearchPage ? _songs[index].artists![0].name.toString() : 'Atif',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              //spacer,
                                              if (MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  800)
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1 /
                                                      15,
                                                  child: Text(
                                                    currentTracks[index]
                                                        .album!
                                                        .name
                                                        .toString(),
                                                    //  widget.isFromPrimarySearchPage ? _songs[index].album!.name.toString() : 'The jal band',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    25,
                                                child: Text(
                                                  // 'lol',
                                                  currentTracks[index]
                                                      .length
                                                      .toString(),
                                                  //widget.isFromPrimarySearchPage ? _songs[index].duration.toString() : '5:25',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                );
                              }),
                        )
                      ]);
                });
          });
    } else
      return Placeholder();
  }
}

class AlbumArtCard extends StatelessWidget {
  const AlbumArtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
          maxHeight: size.width / 2.5, maxWidth: size.width / 2.5),
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
                    ValueListenableBuilder<List<Track>>(
                        valueListenable: tracklist,
                        builder: (_, trck, __) {
                          return ValueListenableBuilder<int>(
                              valueListenable: currentTrackIndex,
                              builder: (_, indx, __) {
                                return CachedNetworkImage(
                                  height: min(constraints.maxHeight,
                                      constraints.maxWidth),
                                  width: min(constraints.maxHeight,
                                      constraints.maxWidth),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, _, __) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/cover.jpg'),
                                  ),
                                  imageUrl:
                                      trck[indx].thumbnail!.last.url.toString() ,
                                  placeholder: (context, url) => const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/cover.jpg')),
                                );
                              });
                        }),
                    // Image.network(
                    //
                    //   "https://wallpaperaccess.com/full/2817687.jpg",
                    //   fit: BoxFit.cover,
                    //   height: min(constraints.maxHeight,
                    //       constraints.maxWidth),
                    //   width: min(constraints.maxHeight,
                    //       constraints.maxWidth),
                    // ),
                    Container(
                      height: min(constraints.maxHeight, constraints.maxWidth),
                      width: min(constraints.maxHeight, constraints.maxWidth),
                      margin: const mat.EdgeInsets.only(bottom: 10),
                      child: mat.Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          text: TextSpan(
                            text: " ${context.watch<ActiveAudioData>().title}  \n",
                            style: typography.title,

                            children:  <TextSpan>[
                              TextSpan(text:  " ${context.watch<ActiveAudioData>().artists}  ", style:typography.subtitle),
                              //TextSpan(text:"${context.watch<ActiveAudioData>().}"),
                            ],
                          ),
                        )
                      ),
                      decoration: const BoxDecoration(
                          gradient: mat.LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            // const Color(0xCC000000),
                            Color(0x00000000),
                            Color(0x00000000),
                           // context.watch<AppTheme>().color.withOpacity(0.5),
                            Color(0xCC000000),
                          ])),
                    )
                  ],
                )),
      ),
    );
  }
}
// class ExtendedCurrentPlayingScreen extends StatelessWidget {
//   const ExtendedCurrentPlayingScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  ListView.builder(
//         itemCount: currentTracks.length,
//         shrinkWrap: true,
//         //controller: _sc,
//         itemBuilder: (context, index) {
//           return HoverButton(
//             cursor: SystemMouseCursors.copy,
//             // splashColor: Colors.grey[130],
//             // customBorder: mat.ShapeBorder(),
//             //hoverColor: Colors.grey[130],
//             onPressed: () async {
//               var audioUrl =
//               await AudioControlClass.getAudioUri(
//                   currentTracks[index]
//                       .videoId
//                       .toString());
//               print(audioUrl.toString());
//
//               playerAlerts.buffering = true;
//               await context
//                   .read<ActiveAudioData>()
//                   .songDetails(
//                   audioUrl,
//                   _songs[index].videoId,
//                   _songs[index].artists![0].name,
//                   _songs[index].title,
//                   _songs[index].thumbnails[0].url);
//
//               currentMediaIndex = 0;
//
//               await AudioControlClass.play(
//                   audioUrl: audioUrl,
//                   videoId:
//                   _songs[index].videoId.toString(),
//                   context: context);
//             },
//             builder: (BuildContext, states) {
//               return AnimatedContainer(
//                 margin: const EdgeInsets.only(
//                     left: 10, right: 10, bottom: 15),
//                 padding: const EdgeInsets.only(
//                     top: 5, bottom: 5),
//                 decoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(8),
//                     color: index == trck ? context.watch<AppTheme>().color :
//                     context.watch<AppTheme>().mode ==
//                         ThemeMode.dark ||
//                         context
//                             .watch<AppTheme>()
//                             .mode ==
//                             ThemeMode.system
//                         ? Colors.grey[150]
//                         : Colors.grey[30]),
//                 duration: FluentTheme.of(context)
//                     .fastAnimationDuration,
//                 child: ClipRRect(
//                     borderRadius:
//                     BorderRadius.circular(10),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceAround,
//                       children: [
//                         SizedBox(width: 5,),
//                         CachedNetworkImage(
//                           width: 40,
//                           height: 40,
//                           imageBuilder:
//                               (context, imageProvider) =>
//                               CircleAvatar(
//                                 backgroundColor:
//                                 Colors.transparent,
//                                 foregroundColor:
//                                 Colors.transparent,
//                                 radius: 100,
//                                 backgroundImage:
//                                 imageProvider,
//                               ),
//                           fit: BoxFit.cover,
//                           errorWidget: (context, _, __) =>
//                           const Image(
//                             fit: BoxFit.cover,
//                             image: AssetImage(
//                                 'assets/cover.jpg'),
//                           ),
//                           imageUrl: currentTracks[index]
//                               .thumbnail![0]
//                               .url
//                               .toString()
//                               .toString(),
//
//                           // widget.isFromPrimarySearchPage ? _songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
//                           placeholder: (context, url) =>
//                           const Image(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                   'assets/cover.jpg')),
//                         ),
//                         spacer,
//
//                         SizedBox(
//                           width: MediaQuery.of(context)
//                               .size
//                               .width *
//                               1 /
//                               8,
//                           child: Text(
//                             currentTracks[index]
//                                 .title
//                                 .toString(),
//                             // widget.isFromPrimarySearchPage ? _songs[index].title.toString() : 'Kuch is tarah',
//                             overflow:
//                             TextOverflow.ellipsis,
//                           ),
//                         ),
//                         spacer,
//                         SizedBox(
//                           width: MediaQuery.of(context)
//                               .size
//                               .width *
//                               1 /
//                               15,
//                           child: Text(
//                             currentTracks[index]
//                                 .artists![0]
//                                 .name
//                                 .toString(),
//                             // widget.isFromPrimarySearchPage ? _songs[index].artists![0].name.toString() : 'Atif',
//                             overflow:
//                             TextOverflow.ellipsis,
//                           ),
//                         ),
//                         //spacer,
//                         if (MediaQuery.of(context)
//                             .size
//                             .width >
//                             800)
//                           SizedBox(
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width *
//                                 1 /
//                                 15,
//                             child: Text(
//                               currentTracks[index]
//                                   .album!
//                                   .name
//                                   .toString(),
//                               //  widget.isFromPrimarySearchPage ? _songs[index].album!.name.toString() : 'The jal band',
//                               overflow:
//                               TextOverflow.ellipsis,
//                             ),
//                           ),
//                         SizedBox(
//                           width: MediaQuery.of(context)
//                               .size
//                               .width *
//                               1 /
//                               25,
//                           child: Text(
//                             // 'lol',
//                             currentTracks[index]
//                                 .length
//                                 .toString(),
//                             //widget.isFromPrimarySearchPage ? _songs[index].duration.toString() : '5:25',
//                             overflow:
//                             TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     )),
//               );
//             },
//           );
//         }),;
//   }
// }


