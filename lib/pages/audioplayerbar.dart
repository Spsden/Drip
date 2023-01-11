import 'package:drip/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/audiofiles/playback.dart';

class AudioPlayerBar extends StatefulWidget {
  const AudioPlayerBar({
    Key? key,
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
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;
    return mat.LayoutBuilder(
      builder: (context, constraints) =>
          SizedBox(
            height: 84.0,
            width: double.infinity,
            //color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(12.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TrackInfo(),

                  Align(
                    alignment: Alignment.center,
                    child: PlayBackControls()
                  ),

                  MoreControls()


                ],
              ),
            ),
          ),
    );
  }

  @override

  bool get wantKeepAlive => true;
}

class TrackInfo extends ConsumerWidget {
  const TrackInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //super.build(context);
    final prov = ref.watch(audioControlCentreProvider);

    return Row(
      children: [
        ExtendedImage.network(
          // ref.watch(activeAudioDataNotifier).thumbnail,
          prov.player.state.playlist.medias.isNotEmpty
              ? prov
              .player.state.playlist.medias[prov.index].extras.thumbs.first
              : 'https://i.imgur.com/L3Ip1wh.png',

          width: MediaQuery
              .of(context)
              .size
              .width > 500 ? 70 : 0,
          height: MediaQuery
              .of(context)
              .size
              .height > 500 ? 70 : 0,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width > 500 ? 70 : 0,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height > 500 ? 70 : 0,
                  fit: BoxFit.cover,
                  // cache: false,
                  // shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(8),
                );

              case LoadState.failed:
              //_controller.reset();
                return GestureDetector(
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
          width: MediaQuery
              .of(context)
              .size
              .width * 1 / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  prov.player.state.playlist.medias.isNotEmpty
                      ? prov
                      .player.state.playlist.medias[prov.index].extras.title
                      : 'Click to Play',
                  style: mat.Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  maxLines: 1),
              const SizedBox(height: 4.0),
              Text(
                  prov.player.state.playlist.medias.isNotEmpty
                      ? prov.player.state.playlist.medias[prov.index].extras
                      .author.join(" ")
                      : 'NA',
                  maxLines: 1,
                  style:  TextStyle(
                      fontSize: 15, overflow: TextOverflow.ellipsis,color: mat.Theme.of(context)
                      .textTheme
                      .caption!
                      .color,),)
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
    double smallIcons = MediaQuery
        .of(context)
        .size
        .width > 550 ? 30 : 25;
    double largeIcons = MediaQuery
        .of(context)
        .size
        .width > 550 ? 40 : 30;
    // isPlaying = ref.watch(audioControlCentreProvider).isPlaying;
    ref
        .watch(audioControlCentreProvider)
        .isPlaying
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
              ref.read(audioControlCentreProvider).prev();
            },
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: ref
                      .watch(themeProvider)
                      .color
                      .toAccentColor(),
                  width: 3.0,
                ),
                //  borderRadius: BorderRadius.circular(largeIcons),
                shape: BoxShape.circle),
            child: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(audioControlCentreProvider).playOrPause();
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _iconController,
                      size: largeIcons,
                    ),
                  ),
                ),
                ref
                    .watch(audioControlCentreProvider)
                    .isBuffering
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
              ref.read(audioControlCentreProvider).next();
              //AudioControlCentre.audioControlCentre.next();
            },
          ),
          mat.IconButton(
            icon: const Icon(mat.Icons.repeat),
            iconSize: smallIcons,
            onPressed: () {
              print("tapped");
            },
          ),
        ],
      ),
    );
  }
}

class MoreControls extends ConsumerWidget {
  const MoreControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        mat.IconButton(
          icon: ref
              .watch(audioControlCentreProvider)
              .volume
              .isZero
              ? const Icon(mat.Icons.volume_up)
              : const Icon(mat.Icons.volume_mute),
          iconSize: 25,
          onPressed: () {
            if (ref
                .watch(audioControlCentreProvider)
                .volume
                .isZero) {
              ref.read(audioControlCentreProvider).setVolume(25.0);
            } else {
              ref.read(audioControlCentreProvider).setVolume(0.0);
            }
          },
        ),
        mat.SliderTheme(
          data: mat.SliderThemeData(
              activeTrackColor: ref
                  .watch(themeProvider)
                  .color,
              thumbColor: ref
                  .watch(themeProvider)
                  .color),
          child: Slider(
              value: ref
                  .watch(audioControlCentreProvider)
                  .volume,
              min: 0.0,
              max: 100,
              //divisions: 30,
              onChanged: (volume) {
                ref.read(audioControlCentreProvider).setVolume(volume);
              }),
        ),
      ],
    )
    ;
  }
}


