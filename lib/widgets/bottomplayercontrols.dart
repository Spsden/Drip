import 'package:drip/datasource/audioplayer/audiodata.dart';
import 'package:drip/datasource/audioplayer/audioplayer.dart';
import 'package:drip/datasource/audioplayer/audioplayer2.dart';
import 'package:drip/main.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PlayerControls extends StatefulWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls>  {
   String statevalue = "Playing";

   bool slidstate = true;



  @override
  void initState() {
    super.initState();




  }

   @override
   void dispose() {
    // _audioPlayerControls.dispose();
     super.dispose();
   }




  double _sliderval = 20;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Consumer<AudioPlayerControls>(
      builder: (_,AudioPlayerControlsModel,child)=>
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           SizedBox(
            // height: 350,
               //width: 300,
               child: Row(
             children: [
               //Image(image: AssetImage('assets/cover.jpg')),
                 CachedNetworkImage(
                 fit: BoxFit.cover,
                 errorWidget: (context, _, __) =>
                 const Image(
                   fit: BoxFit.cover,
                   image:
                   AssetImage('assets/cover.jpg'),
                 ),
                 imageUrl:   Provider.of<AudioData>(context).thumbnailsetter ,
                 placeholder: (context, url) =>
                 const Image(
                     fit: BoxFit.cover,
                     image: AssetImage(
                         'assets/cover.jpg')),
               ),
               SizedBox(
                 width: 10,
               ),
               SizedBox(
                 width: 150,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children:  [
                     Text(
                       Provider.of<AudioData>(context).titlesetter.toString() == "" ? 'No music loaded' : Provider.of<AudioData>(context).titlesetter,
                       style: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.normal,
                           overflow: TextOverflow.ellipsis),
                     ),
                     Text(
                       Provider.of<AudioData>(context).artistsetter.toString() == "" ? 'Click on a song' : Provider.of<AudioData>(context).artistsetter,
                       style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.bold,
                       ),
                     )
                   ],
                 ),
               )
             ],
           )),
           fluent.Center(
             child: Container(
               alignment: Alignment.bottomCenter,
               width: 250,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   IconButton(
                     icon: Icon(Icons.shuffle),
                     iconSize: 20,
                     onPressed: () {},
                   ),
                   IconButton(
                     icon: Icon(fluent.FluentIcons.previous),
                     iconSize: 25,
                     onPressed: () {
                       // AudioPlayerControlsModel.shuffle(context);

                     },
                   ),

                   ValueListenableBuilder<ButtonState>(
                     valueListenable: AudioPlayerControlsModel.buttonNotifier,
                     builder: (_, value, __) {
                       switch (value) {      case ButtonState.loading:
                         return Container(
                           margin: const EdgeInsets.all(8.0),
                           width: 32.0,
                           height: 32.0,
                           child: const CircularProgressIndicator(),
                         );      case ButtonState.paused:
                         return IconButton(
                           icon: const Icon(Icons.play_arrow),
                           iconSize: 32.0,
                           onPressed: () {AudioPlayerControlsModel.play();},
                         );      case ButtonState.playing:
                         return IconButton(
                           icon: const Icon(Icons.pause),
                           iconSize: 32.0,
                           onPressed: () {AudioPlayerControlsModel.pause();},
                         );
                       }
                     },
                   ),



                   IconButton(
                     icon: Icon(fluent.FluentIcons.next),
                     iconSize: 25,
                     onPressed: () {
                      // AudioPlayerControlsModel.playnext();
                     },
                   ),
                   IconButton(
                     icon: Icon(Icons.repeat),
                     iconSize: 20,
                     onPressed: () {},
                   ),
                 ],
               ),
             ),
           ),
           Container(
            // width: 150,
             child: Row(
               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 // Text(
                 //   '1.28/3.22',
                 //   style: TextStyle(color: Colors.white60),
                 // ),
                 fluent.SizedBox(
                   width: 10,
                 ),
                 IconButton(
                   icon: Icon(fluent.FluentIcons.volume3),
                   iconSize: 25,
                   onPressed: () {},
                 ),
                 SliderTheme(
                   data: SliderThemeData(
                       activeTrackColor: Colors.red,
                       trackHeight: 3,
                       thumbColor: Colors.red),
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
                 fluent.SizedBox(
                   width: 30,
                 )

               ],
             ),
           )
         ],
       ),
    );
  }
}
//enum slideSheetState { paused, playing, loading }
