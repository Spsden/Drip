import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasource/audioplayer/audiodartclass.dart';


import 'package:drip/datasource/audioplayer/audioplayer2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'audiodata.dart';

class AudioPlayerBar extends StatefulWidget {
  const AudioPlayerBar({
    Key? key,
  }) : super(key: key);

  @override
  AudioPlayerBarState createState() => AudioPlayerBarState();
}

class AudioPlayerBarState extends State<AudioPlayerBar>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  bool buffering = false;



  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    var playPauseStatus = Provider.of<PlayerNotifiers>(context, listen: false);
    playPauseStatus.addListener(() {
      if (playPauseStatus.playStatus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    super.initState();
    //init();
  }

  @override
  void dispose() {
    _controller.dispose();
    //_yt.close();
    // _audioPlayerControls.dispose();
    super.dispose();
  }

  double _sliderval = 20;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: Row(
              children: [
                // playerNotifier.music.first.networkAlbumArt != null
                //     ? Image.network(
                //         playerNotifier.music.first.networkAlbumArt!,
                //         height: 50,
                //         width: 50,
                //         fit: BoxFit.cover,
                //       )
                //     : Image.asset(
                //         'assets/cover.jpg',
                //         height: 50,
                //         width: 50,
                //         fit: BoxFit.cover,
                //       ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  errorWidget: (context, _, __) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/cover.jpg'),
                  ),
                  imageUrl: Provider.of<AudioData>(context).thumbnailsetter,
                  placeholder: (context, url) => const Image(
                      fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // widget.title == '' ? 'No song Loaded' : widget.title
                        Provider.of<AudioData>(context)
                                    .titlesetter
                                    .toString() ==
                                ""
                            ? 'Click on a song'
                            : Provider.of<AudioData>(context).titlesetter,

                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        //widget.artist == ''? 'Please click on a song' : widget.artist
                        Provider.of<AudioData>(context)
                                    .artistsetter
                                    .toString() ==
                                ""
                            ? 'Click on a song'
                            : Provider.of<AudioData>(context).artistsetter,
                        style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // const VerticalDivider(
          //   color: Colors.black,
          //   thickness: 2,
          // ),
          Center(
            child: SizedBox(
                //width: 600,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shuffle),
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 30,
                      onPressed: () {
                        print(Music().filePath.toString());
                        // print(Provider.of<AudioData>(context, listen: false)
                        //     .audioUrlSetter
                        //     .toString());
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: StreamBuilder<PlaybackState>(
                        stream: player.playbackStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                         // final processingState = playerState?.processingState;
                          final playing = playerState?.isPlaying;
                          // if (processingState == ProcessingState.loading ||
                          //     processingState == ProcessingState.buffering) {
                          //   return Container(
                          //     margin: EdgeInsets.all(8.0),
                          //     width: 64.0,
                          //     height: 64.0,
                          //     child: CircularProgressIndicator(),
                          //   );
                           if (playing != true) {
                            return IconButton(
                              hoverColor: Colors.red,
                              icon: Icon(Icons.play_arrow),
                              iconSize: 40.0,
                              onPressed: player.play,
                            );
                          } else if (playing == true) {
                            return IconButton(
                              hoverColor: Colors.red,
                              icon: Icon(Icons.pause),
                              iconSize: 40.0,
                              onPressed: player.pause,
                            );
                          } else {
                            return IconButton(
                              icon: Icon(Icons.replay),
                              iconSize: 40.0,
                              onPressed: () => AudioControlClass.seek(Duration.zero),
                            );
                          }
                        },
                      ),
                    ),


                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat),
                      iconSize: 30,
                      onPressed: () {},
                    ),
                  ],
                ),


              ],
            )),
          ),
          // VerticalDivider(
          //   color: Colors.black,
          //   width: 2,
          // ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.volume_up),
                iconSize: 25,
                onPressed: () {},
              ),
              SliderTheme(
                data: const SliderThemeData(
                    activeTrackColor: Colors.red,
                    trackHeight: 3,
                    thumbColor: Colors.red),
                child: Container(
                  width: width / 7,
                  child: Slider(
                      value: _sliderval,
                      max: 100,
                      divisions: 30,
                      onChanged: (volume) {
                        setState(() {
                          _sliderval = volume;
                        });
                        //AudioPlayerControlsModel.volume(volume);
                      }),
                ),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ],
      );

  }
}

enum ButtonState { paused, playing, loading }

extension on Duration {
  String get label {
    int minutes = inSeconds ~/ 60;
    String seconds = inSeconds - (minutes * 60) > 9
        ? '${inSeconds - (minutes * 60)}'
        : '0${inSeconds - (minutes * 60)}';
    return '$minutes:$seconds';
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
