import 'dart:math';

import 'package:drip/datasources/audiofiles/playback.dart';
import 'package:drip/pages/common/loading_widget.dart';

import 'package:drip/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../datasources/audiofiles/activeaudiodata.dart';
import '../datasources/searchresults/models/watchplaylistdataclass.dart';
import 'common/track_cards.dart';

class CurrentPlaylist extends ConsumerStatefulWidget {
  final bool fromMainPage;
  final GlobalKey? navigatorKey;

  const CurrentPlaylist(
      {Key? key, required this.fromMainPage, this.navigatorKey})
      : super(key: key);

  @override
  CurrentPlaylistState createState() => CurrentPlaylistState();
}

class CurrentPlaylistState extends ConsumerState<CurrentPlaylist> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    var size = MediaQuery.of(context).size;
    final currentTracks = ref.watch(audioControlCentreProvider).tracks;

    return Container(

      child:  currentTracks.isEmpty
          ?  loadingWidget(context, Colors.red)
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Play queue',
            //   style: TextStyle(
            //       fontSize: 40, fontWeight: mat.FontWeight.w600),
            // ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: currentTracks.length,

                        //controller: _sc,
                        itemBuilder: (context, index) {
                          TrackCardData trackCardData = TrackCardData(
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
                                  .toString());

                          void play() {
                            CurrentMusicInstance currentMusicInstance =
                            CurrentMusicInstance(
                                title: currentTracks[index]
                                    .title
                                    .toString(),
                                author: currentTracks[index]
                                    .artists
                                    ?.map((e) => e.name.toString())
                                    .toList() ??
                                    [],
                                thumbs: currentTracks[index]
                                    .thumbnail
                                    ?.map((e) => e.url.toString())
                                    .toList() ??
                                    [],
                                urlOfVideo: 'NA',
                                videoId: currentTracks[index]
                                    .videoId
                                    .toString());
                            ref
                                .read(audioControlCentreProvider)
                                .open(currentMusicInstance);
                          }

                          return Padding(
                              padding: const EdgeInsets.all(8),
                              child: widget.fromMainPage
                                  ? TrackCardLarge(
                                data: trackCardData,
                                songIndex: index,
                                onTrackTap: () async {
                                  play();
                                },
                                color: index % 2 != 0
                                    ? Colors.transparent
                                    : ref.watch(themeProvider).mode ==
                                    ThemeMode.dark ||
                                    ref
                                        .watch(
                                        themeProvider)
                                        .mode ==
                                        ThemeMode.system
                                    ? Colors.grey[150]
                                    : Colors.grey[40],
                                SuperSize: size,
                                widthy: 800,
                                fromQueue: true,
                              )
                                  :


                              TrackCardSmall(
                                  color: index % 2 != 0
                                      ? Colors.transparent
                                      : ref.watch(themeProvider).mode ==
                                      ThemeMode.dark ||
                                      ref
                                          .watch(
                                          themeProvider)
                                          .mode ==
                                          ThemeMode.system
                                      ? Colors.grey[150]
                                      : Colors.grey[40],
                                  data: trackCardData,
                                  onTrackTap: () async {
                                    print("fjdk");
                                    play();
                                  })


                          );
                        }),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                        padding: const EdgeInsets.all(5),
                        width: constraints.maxWidth,
                        color: Colors.transparent,
                        child: Text('Up Next',
                            style:
                            typography.title?.copyWith(fontSize: 20))),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );



  }
}

class AlbumArtCard extends ConsumerWidget {
  final int trck;
  final List<Track> tracks;

  const AlbumArtCard({Key? key, required this.trck, required this.tracks})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Typography typography = FluentTheme.of(context).typography;
    return Column(
      crossAxisAlignment: mat.CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          // constraints: BoxConstraints(
          //   maxHeight: size.width > 1000 ? 500 : size.width / 2.5,
          //   maxWidth: size.width > 1000 ? 500 : size.width / 2.5,
          // ),

          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),

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
                                    colors: [Colors.transparent, Colors.black])
                                .createShader(bounds);
                          },
                          child: ExtendedImage.network(
                            ref
                                .watch(activeAudioDataNotifier)
                                .thumbnailLarge
                                .toString(),
                            height: min(
                                constraints.maxHeight, constraints.maxWidth),
                            width: min(
                                constraints.maxHeight, constraints.maxWidth),
                            fit: BoxFit.cover,
                            cache: false,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          // CachedNetworkImage(
                          //   height: min(constraints.maxHeight,constraints.maxWidth),
                          //   width: min(constraints.maxHeight,constraints.maxWidth),
                          //   fit: BoxFit.cover,
                          //   errorWidget: (context, url, error) =>
                          //   const Image(
                          //     fit: BoxFit.cover,
                          //     image: AssetImage('assets/artist.jpg'),
                          //   ),
                          //   imageUrl: context.watch<ActiveAudioData>().activeThumbnail!.last.toString(),
                          //
                          //   placeholder: (context, url) => const Image(
                          //       fit: BoxFit.cover,
                          //       image: AssetImage('assets/artist.jpg')),
                          // ),
                        ),
                        SizedBox(
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
                                Text("Now Playing",
                                    style: typography.title?.copyWith(
                                        color: Colors.white, fontSize: 30)

                                    // const mat.TextStyle(
                                    //   fontSize: 20,
                                    // ),

                                    ),
                                Text(ref.watch(activeAudioDataNotifier).title,
                                    style: typography.title?.copyWith(
                                        color: Colors.white, fontSize: 20)

                                    // const mat.TextStyle(
                                    //   fontSize: 20,
                                    // ),

                                    ),
                                Text(
                                    "${ref.watch(activeAudioDataNotifier).artists}  ",
                                    textAlign: mat.TextAlign.left,
                                    style: typography.subtitle?.copyWith(
                                        color: Colors.white, fontSize: 15)),
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
