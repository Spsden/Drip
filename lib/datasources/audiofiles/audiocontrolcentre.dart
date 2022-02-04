import 'dart:ffi';



import 'package:fluent_ui/fluent_ui.dart';
import 'package:dart_vlc/dart_vlc.dart' as mediaplayer;
import 'package:flutter/foundation.dart';
//import 'package:libwinmedia/libwinmedia.dart' as mediaplayer;
import 'package:provider/provider.dart';



import 'audiodartclass.dart';
import 'audiodata.dart';

// class ControlButtons{
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
//
//
// }
enum ButtonState { paused, playing, loading }



final progressNotifier = ValueNotifier<ProgressBarState>(
  ProgressBarState(
    current: Duration.zero,
    //buffered: Duration.zero,
    total: Duration.zero,
  ),
);

//final ValueNotifier<ButtonState> buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

final ValueNotifier<double> bufferProgress = ValueNotifier<double>(0.0);






class ProgressBarState {
  ProgressBarState({
    required this.current,
    //required this.buffered,
    required this.total,
  });
  final Duration current;
 // final Duration buffered;
  final Duration total;
}


late final  mediaplayer.Player player = mediaplayer.Player(id: 12)..
positionStream.listen((mediaplayer.PositionState state) {

  final oldState = progressNotifier.value;
  progressNotifier.value = ProgressBarState(current: state.position!, total: state.duration!);
  playerAlerts.position = state.position!;
  playerAlerts.total = state.duration!;

  
})
..playbackStream.listen((mediaplayer.PlaybackState state) {

  final isPlaying = state.isPlaying;
  final processing = state.isSeekable;

  // if(!isPlaying){
  //   buttonNotifier.value = ButtonState.paused;
  //
  // }
  // if(isPlaying){
  //   buttonNotifier.value = ButtonState.playing;
  // }



  playerAlerts.playStatus = state.isPlaying;
  playerAlerts.playbackComplete = state.isCompleted;
})
..bufferingProgressStream.listen((bufferingProgress) {
  bufferProgress.value = bufferingProgress;

});


//List<Media> medias = <Media>[];

abstract class AudioControlClass {
// mediaplayer.Player player = mediaplayer.Player(id: 0);

  static Future<void> addMusic(List<Music> music) async {

    // music.forEach((song) {
    //   player.add(
    //     mediaplayer.Media(
    //       uri: song.filePath!,
    //       extras: song.toMap(),
    //     ),
    //   );
    //
    // });
    //

  }



  static Future<void> setVolume(double volume) async {

    player.setVolume(volume);


  }

  static Future<void> seek(Duration position) async {

    player.seek(position);

  }

  static Future <void> play({
    //required int index,
    required String audioUrl,

   // required List<Music> music,
  }) async {

    //List<Music> _music = music;
    //index = _music.indexOf(music[index]);
    
    player.open(
      mediaplayer.Media.network(audioUrl),
      autoStart: true
    );

    // player.open([mediaplayer.Media(uri: audioUrl)]);




    await Future.delayed(const Duration(milliseconds: 100));
    player.jump(0);


    await Future.delayed(const Duration(milliseconds: 100));
    player.play();




  }

  static Future<void> playOrPause() async {

    if (player.playback.isPlaying) {
      player.pause();
    } else {
      player.play();
    }


  }




}



var playerAlerts = PlayerNotifiers();
class PlayerNotifiers extends ChangeNotifier {
  bool _playStatus = false;
  bool _playbackComplete = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;
  bool _buffering = false;
  List<Music> _music = <Music> [];

  bool get playStatus => _playStatus;
  bool get playbackComplete => _playbackComplete;
  Duration get position => _position;
  Duration get total => _total;
  bool get buffering => _buffering;
  List<Music> get music => _music;


  set music(List<Music> songs) {
    _music = songs;
    notifyListeners();
  }
  set playStatus(bool playStatus) {
    _playStatus = playStatus;
    notifyListeners();
  }
  set playbackComplete(bool playbackComplete) {
    _playbackComplete = playbackComplete;
    notifyListeners();
  }
  set buffering(bool buffering) {
    _buffering = buffering;
    notifyListeners();
  }
  set position(Duration position) {
    _position = position;
    notifyListeners();
  }
  set total(Duration total) {
    _total = total;
    notifyListeners();
  }

  @override
  // ignore: must_call_super
  void dispose() {}


}







