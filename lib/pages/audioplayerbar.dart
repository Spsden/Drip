import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/audiofiles/activeaudiodata.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentrejustaudio.dart';
import 'package:drip/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart' as mat;


import 'package:provider/provider.dart';



class AudioPlayerBar extends StatefulWidget {
  const AudioPlayerBar({
    Key? key,
  }) : super(key: key);

  @override
  AudioPlayerBarState createState() => AudioPlayerBarState();
}

class AudioPlayerBarState extends State<AudioPlayerBar>
    with AutomaticKeepAliveClientMixin<AudioPlayerBar>  {


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
    var size = MediaQuery.of(context).size;
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
            children: [
               const TrackInfo(),
               MediaQuery.of(context).size.width > 500 ?
              const Spacer() : const SizedBox(width: 5,),
             const PlayBackControls(),
              const Spacer(),
             //if (MediaQuery.of(context).size.width > 800)
              if(constraints.maxWidth >800)

               const MoreControls(),

            ],
          ),
        ),
      ),
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TrackInfo extends StatelessWidget {
  const TrackInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Row(
      children: [

        ExtendedImage.network(
          context.watch<ActiveAudioData>().thumbnail,
    //listOfUpNextNotifier.value[context.read<AudioControls>().currentIndex]["thumbs"][1].url.toString(),
          width: MediaQuery.of(context).size.width > 500 ? 70 : 0 ,
          height: MediaQuery.of(context).size.height > 500 ? 70 : 0 ,
          fit: BoxFit.cover,
          cache: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading :
                return const Image(
                          fit: BoxFit.cover, image: AssetImage('assets/cover.jpg'));
                break;

              case LoadState.completed:
               // _controller.forward();
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: MediaQuery.of(context).size.width > 500 ? 70 : 0 ,
                  height: MediaQuery.of(context).size.height > 500 ? 70 : 0 ,
                  fit: BoxFit.cover,
                  // cache: false,
                  // shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(8),
                );
                break;

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
                break;
            }
          },

        ),

        // CachedNetworkImage(
        //   width: MediaQuery.of(context).size.width > 500 ? 70 : 0 ,
        //   height: MediaQuery.of(context).size.height > 500 ? 70 : 0 ,
        //   fit: BoxFit.cover,
        //   errorWidget: (context, _, __) => const Image(
        //     fit: BoxFit.cover,
        //     image: AssetImage('assets/cover.jpg'),
        //   ),
        //   imageUrl:  context.watch<ActiveAudioData>().thumbnail,
        //   placeholder: (context, url) => const Image(
        //       fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
        // ),
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
               // tracklist.value[currentTrackValueNotifier.value+1].title.toString() ?? 'Play a song'
                context.watch<ActiveAudioData>().title.toString()

                ,style: mat.Theme.of(context).textTheme.bodyText1,
                  maxLines: 1
              ),
              const SizedBox(height: 4.0),
              Text(
                Provider.of<ActiveAudioData>(context,listen: false).artists.toString() ==
                    ""
                    ? 'Click on a song'
                    : Provider.of<ActiveAudioData>(context,listen: false).artists,
                maxLines: 1,
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


class PlayBackControls extends StatefulWidget {
  const PlayBackControls({Key? key}) : super(key: key);

  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls> with TickerProviderStateMixin {
  late AnimationController iconController;
  bool isPlaying = false;

  // void autoPress(BuildContext context) async {
  //   if (playerAlerts.playbackComplete) {
  //     Timer.run(() {
  //       AudioControlClass.nextMusic(context, 1, true);
  //       //print('next play');
  //1
  //     });
  //   }
  // }

  //}
  @override
  void initState() {
    iconController = AnimationController(duration: const Duration(microseconds: 1),vsync: this);

    super.initState();


  }

  @override
  void dispose() {

    iconController.dispose();
    super.dispose();
  }



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
              icon: const Icon(mat.Icons.shuffle_rounded),
              iconSize: smallIcons,
              onPressed: () async{
                //tracklist.value.shuffle();
                //SearchMusic.getWatchPlaylist(videoId, limit)



              },
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_previous),
              iconSize: smallIcons,
              onPressed: () {
                // print(Music().filePath.toString());
                AudioControlClass.previousMusic(context);

              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.watch<AppTheme>().color.toAccentColor(),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(largeIcons),
              ),
              child:


              Stack(
                children: [

                  // GestureDetector(
                  //   onTap: () {
                  //    // AudioControls.instance.playOrPause();
                  //    // print("toapped");
                  //     //print(context.read<AudioControls>().playing.toString());
                  //
                  //     bool x = false;
                  //
                  //
                  //
                  //
                  //     print(x);
                  //
                  //
                  //     if(!context.read<AudioControls>().playing){
                  //       iconController.forward();
                  //       AudioControls.instance.play();
                  //       isPlaying = true;
                  //
                  //     } else {
                  //       iconController.reverse();
                  //       AudioControls.instance.pause();
                  //       isPlaying = false;
                  //     }
                  //
                  //   },
                  //   child: AnimatedIcon(
                  //     icon: AnimatedIcons.play_pause,
                  //     progress: iconController,
                  //     size:50,
                  //     //color: Colors.black,
                  //   ),
                  // ),


                  //
                  StreamBuilder<PlaybackState>(
                    stream: player.playbackStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final isCompleted = playerState?.isCompleted;
                      final playing = playerState?.isPlaying;







                      if (playing != true) {
                        return mat.IconButton(
                          splashRadius:30 ,
                          hoverColor: context.watch<AppTheme>().color,
                          icon: const Icon(mat.Icons.play_arrow),
                          iconSize: largeIcons,
                          onPressed: player.play,
                        );
                      }
                      else if(playerState!.isCompleted)  {
                        // AudioControlClass.nextMusic(context,1);
                        // print('complll');
                       //autoPress(context);
                         context.read<ActiveAudioData>().songDetails(
                            tracklist.value[currentTrackValueNotifier.value].videoId.toString(),
                            tracklist.value[currentTrackValueNotifier.value].videoId.toString(),
                            tracklist.value[currentTrackValueNotifier.value].artists![0].name
                                .toString(),
                            tracklist.value[currentTrackValueNotifier.value].title.toString(),
                            tracklist.value[currentTrackValueNotifier.value].thumbnail![0].url
                                .toString(),
                            tracklist.value[currentTrackValueNotifier.value].thumbnail!.last.url
                                .toString());



                        // return mat.IconButton(
                        //   hoverColor: context.watch<AppTheme>().color,
                        //     splashRadius:30,
                        //   icon: const Icon(mat.Icons.play_arrow),
                        //   iconSize: largeIcons,
                        //   onPressed: (){},
                        // );
                      }


                       {
                        return mat.IconButton(
                            splashRadius:30,
                          hoverColor: context.watch<AppTheme>().color,
                          icon: const Icon(mat.Icons.pause),
                          iconSize: largeIcons,
                          onPressed: player.pause,
                        );
                      }



                      // else  {
                      //   return mat.IconButton(
                      //     icon: const Icon(mat.Icons.album),
                      //     iconSize: largeIcons,
                      //     onPressed: () =>
                      //         AudioControlClass.seek(Duration.zero),
                      //   );
                      // }
                    },),


                  ValueListenableBuilder<double>(
                      valueListenable: bufferProgress,
                      builder: (_,value,__){
                        return value < 10 ?
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          width: largeIcons,
                          height: largeIcons,
                          child: const mat.CircularProgressIndicator(),
                        ) : const SizedBox();
                      })



                ],


              ),
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.skip_next),
              iconSize: smallIcons,
              onPressed: () {
                AudioControlClass.nextMusic(context,2,false);
                //AudioControls.instance.next(context);



                //print(context.read()<AudioControls>().listOfUpNext.first["title"].toString());



                //medias.forEach((element) {print(element.toString());});
              },
            ),
            mat.IconButton(
              icon: const Icon(mat.Icons.repeat),
              iconSize: smallIcons,
              onPressed: () {

                // tracklist.value.forEach((element) {
                //   print(element.title);
                // });
                //
                print("tapped");

               print(player.current.index.toString());
               print(currentTrackValueNotifier.value.toString());






              },

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






