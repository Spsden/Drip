import 'package:drip/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/audio_player_provider.dart';

class AudioPlayerBar extends StatefulWidget {
  final GlobalKey<mat.ScaffoldState> scaffoldKey;

  const AudioPlayerBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  AudioPlayerBarState createState() => AudioPlayerBarState();
}

class AudioPlayerBarState extends State<AudioPlayerBar>
    with AutomaticKeepAliveClientMixin<AudioPlayerBar> {
  bool isPlaying = false;
  bool buffering = false;
  bool volIcon = true;
  double bufferValue = 0.0;
  bool isCompleted = false;

  @override
  void initState() {
    // getColor();

    super.initState();
  }

  @override
  void dispose() {
    //_yt.close();
    // _audioPlayerControls.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      height: 84.0,
      width: double.infinity,
      //color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: (size.width * 3) / 10, child: const TrackInfo()),
            const Align(alignment: Alignment.center, child: PlayBackControls()),
            SizedBox(

                // alignment: Alignment.centerRight,
                width: (size.width * 3) / 10,
                child: MoreControls(widget.scaffoldKey))
          ],
        ),
      ),
    );

    //   mat.LayoutBuilder(
    //   builder: (context, constraints) =>
    //
    //       SizedBox(
    //     height: 84.0,
    //     width: double.infinity,
    //     //color: Colors.black87,
    //     child:
    //
    //     Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children:  [
    //           const TrackInfo(),
    //           const Align(alignment: Alignment.center, child: PlayBackControls()),
    //           MoreControls(widget.scaffoldKey)
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  bool get wantKeepAlive => true;
}

class TrackInfo extends ConsumerWidget {
  const TrackInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //super.build(context);
    final prov = ref.watch(audioPlayerProvider);

    return Row(
      children: [
        ExtendedImage.network(
          // ref.watch(activeAudioDataNotifier).thumbnail,
          prov.player!.state.playlist.medias.isNotEmpty
              ? prov.player!.state.playlist.medias[prov.index].extras!['thumbs']
                      .isNotEmpty
                  ? prov.player!.state.playlist.medias[prov.index]
                      .extras!['thumbs'].isNotEmpty
                  : 'https://i.imgur.com/L3Ip1wh.png'
              : 'https://i.imgur.com/L3Ip1wh.png',

          // width: MediaQuery.of(context).size.width > 500 ? 70 : 0,
          // height: MediaQuery.of(context).size.height > 500 ? 70 : 0,
          fit: BoxFit.cover,
          cache: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Image(
                    fit: BoxFit.cover, image: AssetImage('assets/cover.jpg'));

              case LoadState.completed:
                // _controller.forward();
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  // cache: false,
                  // shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(8),
                );

              case LoadState.failed:
                //_controller.reset();
                return Image.asset(
                  "assets/driprec.png",
                  fit: BoxFit.fill,
                );

                GestureDetector(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        "assets/driprec.png",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  onTap: () {
                    state.reLoadImage();
                  },
                );
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  prov.player!.state.playlist.medias.isNotEmpty
                      ? prov.player!.state.playlist.medias[prov.index]
                          .extras!['title']
                      : 'Click to Play',
                  style: mat.Theme.of(context).textTheme.bodyText1,
                  maxLines: 1),
              const SizedBox(height: 4.0),
              Text(
                prov.player!.state.playlist.medias.isNotEmpty
                    ? prov.player!.state.playlist.medias[prov.index]
                        .extras!["author"].first
                    : 'NA',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  color: mat.Theme.of(context).textTheme.caption!.color,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PlayBackControls extends ConsumerStatefulWidget {
  const PlayBackControls({Key? key}) : super(key: key);

  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends ConsumerState<PlayBackControls>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late bool isPlaying;

  @override
  void initState() {
    _iconController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double smallIcons = MediaQuery.of(context).size.width > 550 ? 30 : 25;
    double largeIcons = MediaQuery.of(context).size.width > 550 ? 40 : 30;
    // isPlaying = ref.watch(audioPlayerProvider).isPlaying;
    ref.watch(audioPlayerProvider).isPlaying
        ? _iconController.forward()
        : _iconController.reverse();

    //final selected = context.watch<CurrentTrackModel>().selected;
    return mat.Material(
      color: Colors.transparent,
      child: Row(
        children: [
          mat.IconButton(
            icon: const Icon(mat.Icons.shuffle_rounded),
            iconSize: smallIcons,
            onPressed: () async {
              //tracklist.value.shuffle();
              //SearchMusic.getWatchPlaylist(videoId, limit)
            },
          ),
          mat.IconButton(
            icon: const Icon(mat.Icons.skip_previous),
            iconSize: smallIcons,
            onPressed: () {
              ref.read(audioPlayerProvider).prev();
            },
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: ref.watch(themeProvider).color.toAccentColor(),
                border: Border.all(
                  color: ref.watch(themeProvider).color.toAccentColor(),
                  width: 3.0,
                ),
                //  borderRadius: BorderRadius.circular(largeIcons),
                shape: BoxShape.circle),
            child: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(audioPlayerProvider).playOrPause();
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _iconController,
                      size: largeIcons,
                    ),
                  ),
                ),
                ref.watch(audioPlayerProvider).isBuffering
                    ? Container(
                        margin: const EdgeInsets.all(8.0),
                        width: largeIcons,
                        height: largeIcons,
                        child: const mat.CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          mat.IconButton(
            icon: const Icon(mat.Icons.skip_next),
            iconSize: smallIcons,
            onPressed: () {
              ref.read(audioPlayerProvider).next();
              //AudioControlCentre.audioControlCentre.next();
            },
          ),
          mat.IconButton(
            icon: ref.read(audioPlayerProvider).repeat == true
                ? const Icon(
                    mat.Icons.repeat,
                    color: Colors.white,
                  )
                : Icon(mat.Icons.repeat, color: Colors.white.withOpacity(0.5)),
            iconSize: smallIcons,
            onPressed: () {
              ref.read(audioPlayerProvider).setRepeat();
            },
          ),
        ],
      ),
    );
  }
}

class MoreControls extends ConsumerWidget {
  final GlobalKey<mat.ScaffoldState> scaffoldKey;

  const MoreControls(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioControlCentre = ref.watch(audioPlayerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        mat.IconButton(
          icon: audioControlCentre.volume.isZero
              ? const Icon(mat.Icons.volume_off_rounded)
              : const Icon(mat.Icons.volume_up),
          iconSize: 25,
          onPressed: () {
            if (audioControlCentre.volume.isZero) {
              audioControlCentre.setVolume(25.0);
            } else {
              audioControlCentre.setVolume(0.0);
            }
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 8,
          child: mat.SliderTheme(
            data: mat.SliderThemeData(
                activeTrackColor: ref.watch(themeProvider).color,
                thumbColor: ref.watch(themeProvider).color),
            child: Slider(
                value: audioControlCentre.volume,
                min: 0.0,
                max: 100,
                //divisions: 30,
                onChanged: (volume) {
                  audioControlCentre.setVolume(volume);
                }),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        mat.IconButton(
          icon: const Icon(mat.Icons.queue_music_rounded),
          iconSize: 25,
          onPressed: () {
            scaffoldKey.currentState?.openEndDrawer();
          },
        )
      ],
    );
  }
}
