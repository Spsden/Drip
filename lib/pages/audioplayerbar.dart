import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/audiofiles/audiodartclass.dart';
import 'package:drip/datasources/audiofiles/audiodata.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mat;

import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fluent;

import 'package:cached_network_image/cached_network_image.dart';


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
  bool volIcon = true;
  double bufferValue = 0.0;

  @override
  void initState() {
    if (mounted) {
      player.bufferingProgressStream.listen(
        (bufferingProgress) {
          setState(() {
            bufferValue = bufferingProgress;
          });
        },
      );
    }


    super.initState();
    //init();
  }

  @override
  void dispose() {
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
    return Container(
      height: 84.0,
      width: double.infinity,
      //color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            TrackInfo(),
            const Spacer(),
           PlayerControls(),
            const Spacer(),
           if (MediaQuery.of(context).size.width > 700) MoreControls(),

          ],
        ),
      ),
    );

  }
}

class TrackInfo extends StatelessWidget {
  const TrackInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          errorWidget: (context, _, __) => const Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/cover.jpg'),
          ),
          imageUrl: Provider.of<ActiveAudioData>(context).thumbnailsetter,
          placeholder: (context, url) => const Image(
              fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Provider.of<ActiveAudioData>(context).titlesetter.toString() ==
                  ""
                  ? 'Click on a song'
                  : Provider.of<ActiveAudioData>(context).titlesetter,
              style: mat.Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 4.0),
            Text(
              Provider.of<ActiveAudioData>(context).artistsetter.toString() ==
                  ""
                  ? 'Click on a song'
                  : Provider.of<ActiveAudioData>(context).artistsetter,
              style: mat.Theme.of(context)
                  .textTheme
                  .subtitle1!
            )
          ],
        ),
      ],
    );
  }
}

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final selected = context.watch<CurrentTrackModel>().selected;
    return
      mat.Material(
        color: Colors.transparent,
        child: Row(
          children: [
            mat.IconButton(
              icon: Icon(mat.Icons.shuffle),
              iconSize: 30,
              onPressed: () {},
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_previous),
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
              child: Stack(
                children: [
                  StreamBuilder<PlaybackState>(
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
                        return mat.IconButton(
                          hoverColor: Colors.red,
                          icon: Icon(mat.Icons.play_arrow),
                          iconSize: 40.0,
                          onPressed: player.play,
                        );
                      } else if (playing == true) {
                        return mat.IconButton(
                          hoverColor: Colors.red,
                          icon: Icon(mat.Icons.pause),
                          iconSize: 40.0,
                          onPressed: player.pause,
                        );
                      } else {
                        return mat.IconButton(
                          icon: Icon(mat.Icons.replay),
                          iconSize: 40.0,
                          onPressed: () =>
                              AudioControlClass.seek(Duration.zero),
                        );
                      }
                    },
                  ),

                  ValueListenableBuilder<double>(
                      valueListenable: bufferProgress,
                      builder: (_,value,__){
                        return value < 10 ?
                        Container(
                          margin: EdgeInsets.all(8.0),
                          width: 40.0,
                          height: 40.0,
                          child: mat.CircularProgressIndicator(),
                        ) : SizedBox();
                      })



                ],


              ),
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_next),
              iconSize: 30,
              onPressed: () {},
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.repeat),
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      );




  }
}

class MoreControls extends StatefulWidget {
  const MoreControls({Key? key}) : super(key: key);

  @override
  _MoreControlsState createState() => _MoreControlsState();
}

class _MoreControlsState extends State<MoreControls> {

  bool volIcon = true;
  double bufferValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return mat.Material(
      color: Colors.transparent,
      child: Row(
        children: [
          mat.IconButton(
            icon: volIcon
                ? const Icon(mat.Icons.volume_up)
                : const Icon(mat.Icons.volume_mute),
            iconSize: 25,
            onPressed: () {
              if (volIcon) {
                AudioControlClass.setVolume(0.0);
                setState(() {
                  volIcon = !volIcon;
                });
              } else if (!volIcon) {
                AudioControlClass.setVolume(0.4);
                setState(() {
                  volIcon = !volIcon;
                });
              }
            },
          ),
          SizedBox(
            width: 150,
            child: StreamBuilder<GeneralState>(
                stream: player.generalStream,
                builder: (context, snapshot) {
                  final generalStream = snapshot.data;
                  return
                     SizedBox(
                      width: 100,
                      child: mat.SliderTheme(
                        data: mat.SliderThemeData(
                          activeTrackColor: context.watch<AppTheme>().color,
                            thumbColor: context.watch<AppTheme>().color
                        ),
                        child: Slider(
                            value: snapshot.data?.volume ?? 0.4,
                            min: 0.0,
                            max: 1.0,
                            //divisions: 30,
                            onChanged: (volume) {
                              AudioControlClass.setVolume(volume);

                              //AudioPlayerControlsModel.volume(volume);
                            }),
                      ),

                  );
                }),
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}






