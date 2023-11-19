import 'package:drip/datasources/searchresults/models/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:extended_image/extended_image.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:drip/datasources/searchresults/models/watchplaylistdataclass.dart'
    as watch;

import '../datasources/audiofiles/activeaudiodata.dart';
import '../datasources/audiofiles/playback.dart';
import '../providers/audio_player_provider.dart';
import '../theme.dart';
import 'common/loading_widget.dart';
import 'common/track_cards.dart';

class PlaylistMain extends ConsumerStatefulWidget {
  final String playlistId;

  const PlaylistMain({Key? key, required this.playlistId}) : super(key: key);

  @override
  _PlaylistMainState createState() => _PlaylistMainState();
}

class _PlaylistMainState extends ConsumerState<PlaylistMain> {
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
                  fetched = true;
                })
              }
          });
    }

    return Stack(
      children: [
        (!fetched)
            ? Center(
                child: loadingWidget(context, ref.watch(themeProvider).color))
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                    mat.SliverAppBar(
                      expandedHeight: size.width > 500
                          ? size.height * 0.27
                          : size.height * 0.23,
                      stretch: true,
                      flexibleSpace: mat.FlexibleSpaceBar(
                        background: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(08),
                              color: ref.watch(themeProvider).mode ==
                                          ThemeMode.dark ||
                                      ref.watch(themeProvider).mode ==
                                          ThemeMode.system
                                  ? Colors.grey[150].withOpacity(0.6)
                                  : Colors.grey[30].withOpacity(0.9)),
                          width: size.width * 0.9,
                          height: size.width > 500
                              ? size.height * 0.27
                              : size.height * 0.23,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Row(
                              //  mainAxisSize: MainAxisSize.min,
                              children: [
                                ExtendedImage.network(
                                  _playlists.thumbnails.last.url.toString(),
                                  width: size.width > 500
                                      ? size.height / 4.4
                                      : constraints.maxWidth / 2.8,
                                  height: size.width > 500
                                      ? size.height / 4.4
                                      : constraints.maxWidth / 2.8,
                                  fit: BoxFit.cover,
                                  cache: false,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
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
                                    SizedBox(
                                      width: constraints.maxWidth / 2,
                                      child: Text(
                                        _playlists.description.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    FilledButton(
                                      child: const Row(
                                        children: [
                                          Icon(FluentIcons.play),
                                          spacer,
                                          Text('Shuffle',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () async {
                                        // AudioControlClass.shuffle(_tracks);

                                        print("pressed here");
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    mat.SliverList(


                        delegate: SliverChildBuilderDelegate(
                          childCount: _tracks.length,
                      (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 50),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 20, 0),
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
                                          .thumbnails[0]
                                          .url
                                          .toString()),
                                  songIndex: index,
                                  onTrackTap: () async {
                                    CurrentMusicInstance currentMusicInstance =
                                        CurrentMusicInstance(
                                            title:
                                                _tracks[index].title.toString(),
                                            author: _tracks[index]
                                                    .artists
                                                    ?.map((e) =>
                                                        e.name.toString())
                                                    .toList() ??
                                                [],
                                            thumbs: _tracks[index]
                                                    .thumbnails
                                                    ?.map(
                                                        (e) => e.url.toString())
                                                    .toList() ??
                                                [],
                                            urlOfVideo: 'NA',
                                            videoId: _tracks[index]
                                                .videoId
                                                .toString());

                                    ref
                                        .read(audioPlayerProvider)
                                        .open(currentMusicInstance);

                                    // await ref.watch(activeAudioDataNotifier)
                                    //     .songDetails(
                                    //         'lol',
                                    //         _tracks[index]
                                    //             .videoId
                                    //             .toString(),
                                    //         _tracks[index].artists[0].name,
                                    //         _tracks[index].title.toString(),
                                    //         _tracks[index]
                                    //             .thumbnails[0]
                                    //             .url
                                    //             .toString(),
                                    //         // _tracks[index]
                                    //         //     .thumbnails
                                    //         //     .map((e) => ThumbnailLocal(
                                    //         //         height: e.height,
                                    //         //         url: e.url.toString(),
                                    //         //         width: e.width))
                                    //         //     .toList(),
                                    //         _tracks[index]
                                    //             .thumbnails
                                    //             .last
                                    //             .url
                                    //             .toString());
                                    // currentMediaIndex = 0;
                                    //
                                    // await AudioControlClass.play(
                                    //     videoId: _tracks[index]
                                    //         .videoId
                                    //         .toString(),
                                    //     context: context);
                                  },
                                  color: index % 2 != 0
                                      ? Colors.transparent
                                      : ref.watch(themeProvider).mode ==
                                                  ThemeMode.dark ||
                                              ref.watch(themeProvider).mode ==
                                                  ThemeMode.system
                                          ? Colors.grey[150]
                                          : Colors.grey[30],
                                  fromQueue: false,
                                  SuperSize: size,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  ]
                // padding: EdgeInsets.all(15),
                // controller: _scrollController,

                ),
        // Positioned.fill(
        //   top: 10,
        //   left: 10,
        //   child: Align(
        //       alignment: Alignment.topLeft,
        //       child: FloatingBackButton(
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //       )),
        // ),
      ],
    );
  }
}
