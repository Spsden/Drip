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
    return SizedBox(
      height: 84.0,
      width: double.infinity,
      //color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const TrackInfo(),
             MediaQuery.of(context).size.width > 500 ?
            const Spacer() : const SizedBox(width: 5,),
           PlayerControls(),
            const Spacer(),
           if (MediaQuery.of(context).size.width > 800) MoreControls(),

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
          width: MediaQuery.of(context).size.width > 500 ? 70 : 0 ,
          height: MediaQuery.of(context).size.height > 500 ? 70 : 0 ,
          fit: BoxFit.cover,
          errorWidget: (context, _, __) => const Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/cover.jpg'),
          ),
          imageUrl:  context.watch<ActiveAudioData>().thumbnail,
          placeholder: (context, url) => const Image(
              fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1/5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                 context.watch<ActiveAudioData>().title.toString()

                // Provider.of<ActiveAudioData>(context).titlesetter.toString() ==
                //     ""
                //     ? 'Click on a song'
                //     : Provider.of<ActiveAudioData>(context).titlesetter,
                ,style: mat.Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 4.0),
              Text(
                Provider.of<ActiveAudioData>(context,listen: false).artists.toString() ==
                    ""
                    ? 'Click on a song'
                    : Provider.of<ActiveAudioData>(context,listen: false).artists,
                style: const TextStyle(
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     double smallIcons = MediaQuery.of(context).size.width > 550 ? 30 : 25;
     double largeIcons = MediaQuery.of(context).size.width > 550 ? 40 : 30;
    //final selected = context.watch<CurrentTrackModel>().selected;
    return
      mat.Material(
        color: Colors.transparent,
        child: Row(
          children: [
            mat.IconButton(
              icon: const Icon(mat.Icons.shuffle),
              iconSize: smallIcons,
              onPressed: () {},
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_previous),
              iconSize: smallIcons,
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
                  color: context.watch<AppTheme>().color,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(largeIcons),
              ),
              child: Stack(
                children: [
                  StreamBuilder<PlaybackState>(
                    stream: player.playbackStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;

                      // final processingState = playerState?.processingState;
                      final playing = playerState?.isPlaying;


                      if (playing != true) {
                        return mat.IconButton(
                          hoverColor: Colors.red,
                          icon: Icon(mat.Icons.play_arrow),
                          iconSize: largeIcons,
                          onPressed: player.play,
                        );
                      } else if (playing == true) {
                        return mat.IconButton(
                          hoverColor: Colors.red,
                          icon: Icon(mat.Icons.pause),
                          iconSize: largeIcons,
                          onPressed: player.pause,
                        );
                      } else {
                        return mat.IconButton(
                          icon: Icon(mat.Icons.replay),
                          iconSize: largeIcons,
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
                          margin: const EdgeInsets.all(8.0),
                          width: largeIcons,
                          height: largeIcons,
                          child: const mat.CircularProgressIndicator(),
                        ) : SizedBox();
                      })



                ],


              ),
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_next),
              iconSize: smallIcons,
              onPressed: () {},
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.repeat),
              iconSize: smallIcons,
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






