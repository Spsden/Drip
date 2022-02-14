import 'package:dart_vlc/dart_vlc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


// class Playlist extends Media{
//   Playlist.asset(String asset) : super.asset(asset);
//
// }

class AudioControls extends ChangeNotifier{
  static late AudioControls instance = AudioControls();


  final Player audioPlayer = Player(id: 25,commandlineArguments: [' --no-video']);

  List<Media> medias  = <Media>[];
  //Playlist newPlaylist = new Playlist(medias:medias);
bool mute = false;
  bool playing = false;
  bool completed = false;
  bool buffering = false;
  Duration position = Duration.zero;
  Duration total = Duration.zero;
  int currentIndex = 0;
  double vol = 50.0;
  double _volume = 50.0;




  void play(){
    audioPlayer.play();
  }

  void pause(){
    audioPlayer.pause();
  }

  void playOrPause() {
    if (playing) {
      pause();
    } else {
      play();
    }
  }

  void next() {

      audioPlayer.next();
    }

  void prev() {

    audioPlayer.back();
  }

  void jump(int value) {

    audioPlayer.jump(value);
  }

  void volume(double value){
    audioPlayer.setVolume(value);

    vol = value;
    notifyListeners();
  }

  void muteIt(){
    if(mute){
      volume(_volume);
    } else {
      _volume = vol;
      volume(0.0);

    }
    mute = !mute;
    notifyListeners();
  }

  void seek(Duration position){
    audioPlayer.seek(position);
  }
}