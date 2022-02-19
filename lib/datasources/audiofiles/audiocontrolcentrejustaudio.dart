// import 'package:dart_vlc/dart_vlc.dart';
// import 'package:drip/datasources/audiofiles/activeaudiodata.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
//
//
//
// ////in works////
//
// class AudioControls extends ChangeNotifier{
//   static late AudioControls instance = AudioControls();
//
//
//   final Player audioPlayer = Player(id: 25,commandlineArguments: [' --no-video']);
//
//   List<Media> medias  = <Media>[];
//   List<ActiveAudioData> _list = [];
//   //Playlist newPlaylist = new Playlist(medias:medias);
// bool mute = false;
//   bool playing = false;
//   bool completed = false;
//   bool buffering = false;
//   Duration position = Duration.zero;
//   Duration total = Duration.zero;
//   int currentIndex = 0;
//   double vol = 50.0;
//
//   double _volume = 50.0;
//
//   // AudioControls() {
//   //   audioPlayer.playbackStream.
//   // }
//
//
//   void open(List<ActiveAudioData> list, {int currentIndex = 0}) {
//     audioPlayer.open(
//     Playlist(medias: list.map((e) => Media.network(
//       e.audioUrl,
//           extras: e.toJson(),
//
//     )).toList()
//     )
//
//     );
//     audioPlayer.jump(currentIndex);
//     audioPlayer.play();
//   }
//
//
//
//
//   void play(){
//     audioPlayer.play();
//   }
//
//   void pause(){
//     audioPlayer.pause();
//   }
//
//   void playOrPause() {
//     if (playing) {
//       pause();
//     } else {
//       play();
//     }
//   }
//
//   void next() {
//
//       audioPlayer.next();
//     }
//
//   void prev() {
//
//     audioPlayer.back();
//   }
//
//   void jump(int value) {
//
//     audioPlayer.jump(value);
//   }
//
//   void volume(double value){
//     audioPlayer.setVolume(value);
//
//     vol = value;
//     notifyListeners();
//   }
//
//   void muteIt(){
//     if(mute){
//       volume(_volume);
//     } else {
//       _volume = vol;
//       volume(0.0);
//
//     }
//     mute = !mute;
//     notifyListeners();
//   }
//
//   void seek(Duration position){
//     audioPlayer.seek(position);
//   }
//
//   void addTracks(){
//
//   }
//
//
//
// }