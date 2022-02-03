// import 'dart:ffi';
//
//
//
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:libwinmedia/libwinmedia.dart' as mediaplayer;
// import 'package:provider/provider.dart';
//
//
// import 'audiodartclass.dart';
// import 'audiodata.dart';
//
// //final vlclib.Player playerVlc = vlclib.Player(id: 0);
// late final  mediaplayer.Player player = mediaplayer.Player(id: 0)..
// streams.isPlaying.listen((playStatus) {
//   playerAlerts.playStatus = playStatus;
//
// })
// // ..streams.medias.listen((medias) {
// //   playerAlerts.music = medias.map((media) => Music.)
// // })
// ..streams.isBuffering.listen((buffering) {
//   playerAlerts.buffering = buffering;
// })
// ..streams.isCompleted.listen((completed) {
//   playerAlerts.playbackComplete = completed;
// })
// ..streams.position.listen((position) {
//   playerAlerts.position = position;
// })
// ..streams.duration.listen((duration) {
//   playerAlerts.total = duration;
// })
//
// ;
//
// //List<Media> medias = <Media>[];
//
// abstract class AudioControlClass {
// // mediaplayer.Player player = mediaplayer.Player(id: 0);
//
//   static Future<void> addMusic(List<Music> music) async {
//
//     music.forEach((song) {
//       player.add(
//         mediaplayer.Media(
//           uri: song.filePath!,
//           extras: song.toMap(),
//         ),
//       );
//
//     });
//
//
//   }
//
//
//
//   static Future<void> setVolume(double volume) async {
//
//       player.volume = volume;
//
//
//   }
//
//   static Future<void> seek(Duration position) async {
//
//       player.seek(position);
//
//   }
//
//   static Future <void> play({
//   required int index,
//     required String audioUrl,
//
// required List<Music> music,
// }) async {
//
//    List<Music> _music = music;
//    index = _music.indexOf(music[index]);
//
//     player.open(
//       _music.map((song) => mediaplayer.Media(
//         uri: song.filePath!,
//         extras: song.toMap()
//       ),).toList()
//     );
//
//   // player.open([mediaplayer.Media(uri: audioUrl)]);
//
//
//
//
//    await Future.delayed(const Duration(milliseconds: 100));
//    player.jump(index);
//
//
//     await Future.delayed(const Duration(milliseconds: 100));
//     player.play();
//
//
//
//
//   }
//
//   static Future<void> playOrPause() async {
//
//       if (player.state.isPlaying) {
//         player.pause();
//       } else {
//         player.play();
//       }
//
//
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// //
//   // static Future<void> play({
//   //   // required List<AudioData> auddiodata,
//   //   required String audioUrl,
//   // }) async {
//   //   medias.clear();
//   //   //List<AudioData> _audioData = auddiodata;
//   //   medias.add(Media.network(audioUrl));
//   //
//   //   playerVlc.open(
//   //       Playlist(
//   //         medias: medias,
//   //         playlistMode: PlaylistMode.repeat,
//   //       ),
//   //       autoStart: true);
//   //
//   //   await Future.delayed(const Duration(milliseconds: 250));
//   //   playOrPause();
//   //
//   //   //playerVlc.play();
//   //   AudioPlayerBarState().init();
//   // }
//   //
//   // static Future<void> playOrPause() async {
//   //   //print('tapped here too');
//   //   if (playerVlc.playback.isPlaying == true) {
//   //    // print('tapped here too playing');
//   //     playerVlc.playOrPause();
//   //   } else {
//   //     //print('tapped here too paused');
//   //     playerVlc.playOrPause();
//   //   }
//   // }
//
//
// }
//
//
//
// var playerAlerts = PlayerNotifiers();
// class PlayerNotifiers extends ChangeNotifier {
//   bool _playStatus = false;
//   bool _playbackComplete = false;
//   Duration _position = Duration.zero;
//   Duration _total = Duration.zero;
//   bool _buffering = false;
//   List<Music> _music = <Music> [];
//
//   bool get playStatus => _playStatus;
//   bool get playbackComplete => _playbackComplete;
//   Duration get position => _position;
//   Duration get total => _total;
//   bool get buffering => _buffering;
//   List<Music> get music => _music;
//
//
//   set music(List<Music> songs) {
//     _music = songs;
//     notifyListeners();
//   }
//   set playStatus(bool playStatus) {
//     _playStatus = playStatus;
//     notifyListeners();
//   }
//   set playbackComplete(bool playbackComplete) {
//     _playbackComplete = playbackComplete;
//     notifyListeners();
//   }
//   set buffering(bool buffering) {
//     _buffering = buffering;
//     notifyListeners();
//   }
//   set position(Duration position) {
//     _position = position;
//     notifyListeners();
//   }
//   set total(Duration total) {
//     _total = total;
//     notifyListeners();
//   }
//
//   @override
//   // ignore: must_call_super
//   void dispose() {}
//
//
// }
//
//
//
//
//
//
//
