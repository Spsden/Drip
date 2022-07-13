//
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:dart_vlc/dart_vlc.dart';
// import 'package:drip/datasources/audiofiles/activeaudiodata.dart';
// import 'package:drip/datasources/searchresults/searchresultsservice.dart';
// import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
//
// ////in works////
//
// // int currentIndex2 = context.read<AudioControls>().currentIndex;
//
// final ValueNotifier<List<Map<String,dynamic>>> listOfUpNextNotifier = ValueNotifier<List<Map<String,dynamic>>>(AudioControls().listOfUpNext);
//
// class AudioControls extends ChangeNotifier {
//   static late AudioControls instance = AudioControls();
//
//    //bool vlcTrue = false;
//
//   final Player audioPlayer =
//       Player(id: 25, commandlineArguments: [' --no-video']);
//
//    //final AudioPlayer audioPlayer = AudioPlayer();
//
//   List<Media> playerMedias = <Media>[];
//
//   List<CurrentMusicInstance> currentMusic = [];
//
//   List<Map<String, dynamic>> listOfUpNext = [];
//
//
//
//   final yt.YoutubeExplode _youtubeExplode = yt.YoutubeExplode();
//
//   //Playlist newPlaylist = new Playlist(medias:medias);
//   bool mute = false;
//   bool playing = false;
//   //bool get playing => _playing;
//   bool completed = false;
//   bool buffering = false;
//   Duration position = Duration.zero;
//   Duration total = Duration.zero;
//   int currentIndex = 0;
//   double vol = 50.0;
//
//   double _volume = 50.0;
//
//   AudioControls() {
//     //
//     // audioPlayer.playbackStream.listen((playbackState) {
//     //   _playing = playbackState.isPlaying;
//     //
//     //   notifyListeners();
//     // });
//     // audioPlayer.playbackStream.listen((event) {
//     //  // playing = event.isPlaying;
//     //   completed = event.isCompleted;
//     //   buffering = event.isSeekable;
//     //   notifyListeners();
//     // });
//     //
//     // audioPlayer.positionStream.listen((event) {
//     //   position = event.position!;
//     //   total = event.duration!;
//     //   notifyListeners();
//     // });
//     //
//     audioPlayer.currentStream.listen((event) {
//       currentIndex = event.index!  ;
//       notifyListeners();
//     });
//
//     // audioPlayer.onPlayerStateChanged.listen((PlaybackState playbackState) {
//     //   playing = playbackState.isPlaying
//     //
//     // })
//
//
//
//
//
//     void dispose() {
//       _youtubeExplode.close();
//       audioPlayer.dispose();
//     }
//   }
//
//
//
//   Future<void> play() async {
//     audioPlayer.play();
//
//     //for audioPlayers
//     //await audioPlayer.resume();
//   }
//
//   void pause() {
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
//   // Future<void> playFromAudioPlayers(String urlOfMusic)async {
//   //  await audioPlayer.setSource(UrlSource(urlOfMusic));
//   //  play();
//   //
//   // }
//
//   Future<void> next(BuildContext context) async {
//
//     audioPlayer.next();
//     // audioPlayer.stop();
//    // currentIndex++;
//
//
//       int currentIndex2 = context.read<AudioControls>().currentIndex;
//     // print(currentIndex2.toString()+"lol");
//
//    // await playFromAudioPlayers(listOfUpNextNotifier.value[currentIndex]["streamUrl"].toString());
//
//     await context.read<ActiveAudioData>().songDetails(
//         listOfUpNextNotifier.value[currentIndex2]["videoId"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["videoId"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["author"][0].name.toString(),
//         listOfUpNextNotifier.value[currentIndex2]["title"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["thumbs"][0].url.toString(),
//
//         listOfUpNextNotifier.value[currentIndex2]["thumbs"].last.url.toString());
//
//
//   }
//
//   Future<void> prev(BuildContext context) async {
//     audioPlayer.previous();
//
//     int currentIndex2 = context.read<AudioControls>().currentIndex;
//
//     await context.read<ActiveAudioData>().songDetails(
//         listOfUpNextNotifier.value[currentIndex2]["videoId"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["videoId"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["author"][0].name.toString(),
//         listOfUpNextNotifier.value[currentIndex2]["title"].toString(),
//         listOfUpNextNotifier.value[currentIndex2]["thumbs"][0].url.toString(),
//
//         listOfUpNextNotifier.value[currentIndex2]["thumbs"].last.url.toString());
//   }
//
//   void jump(int value) {
//     //audioPlayer.jumpToIndex(value);
//   }
//
//   void volume(double value) {
//     audioPlayer.setVolume(value);
//
//     vol = value;
//     notifyListeners();
//   }
//
//   void muteIt() {
//     if (mute) {
//       volume(_volume);
//     } else {
//       _volume = vol;
//       volume(0.0);
//     }
//     mute = !mute;
//     notifyListeners();
//   }
//
//   void seek(Duration position) {
//     audioPlayer.seek(position);
//   }
//
//   void addTracks() {}
//
//   Future<void> startPlaying(
//       {required CurrentMusicInstance currentMusicInstance,
//       required BuildContext context}) async {
//
//
//
//     audioPlayer.current.medias.clear();
//     audioPlayer.stop();
//     //playerMedias.clear();
//     listOfUpNextNotifier.value.clear();
//
//     Map<String, dynamic> extrasMap = {
//       "title": currentMusicInstance.title,
//       "author": currentMusicInstance.author,
//       "thumbs": currentMusicInstance.thumbs,
//       "videoId": currentMusicInstance.videoId
//     };
//
//    // playFromAudioPlayers(currentMusicInstance.urlOfVideo.toString());
//     play();
//
//     // playerMedias.add(
//     //   Media.network(currentMusicInstance.urlOfVideo, extras: extrasMap),
//     // );
//
//     //audioPlayer.open(Playlist(medias: playerMedias), autoStart: true);
//     audioPlayer.open(Media.network(currentMusicInstance.urlOfVideo, extras: extrasMap),);
//
//     //audioPlayer.play();
//
//     print("played from new logic");
//
//
//
//     await addMusic(currentMusicInstance.videoId);
//
//
//     //  medias.forEach((element) {print(element.metas.length);});
//   }
//
//   Future<void> addMusic(String playlistVideoId) async {
//     late WatchPlaylists watchPlaylists;
//     await SearchMusic.getWatchPlaylist(playlistVideoId, 10).then((value) async {
//       watchPlaylists = value;
//
//       // watchPlaylists.tracks.forEach((element) {
//       //
//       // })
//
//       for (int i = 1; i < watchPlaylists.tracks!.length; i++) {
//         String videoIdOf = watchPlaylists.tracks![i].videoId.toString();
//
//         var audioUri = await getAudioUri(videoIdOf);
//
//         if (audioUri == 'Shit_Happens') {
//           i++;
//           // Map<String,dynamic> extrasMap = {
//           //   "title" : watchPlaylists.tracks![i].title,
//           //   "author" : watchPlaylists.tracks![i].artists,
//           //   "thumbs" : watchPlaylists.tracks![i].thumbnail,
//           //   "videoId" : watchPlaylists.tracks![i].videoId
//           // };
//
//         } else {
//           Map<String, dynamic> extrasMap = {
//             "title": watchPlaylists.tracks![i].title,
//             "author": watchPlaylists.tracks![i].artists,
//             "thumbs": watchPlaylists.tracks![i].thumbnail,
//             "videoId": watchPlaylists.tracks![i].videoId,
//             "duration" : watchPlaylists.tracks![i].length,
//             "streamUrl" : audioUri
//           };
//            audioPlayer.add(Media.network(audioUri, extras: extrasMap));
//
//           listOfUpNextNotifier.value.add(extrasMap);
//
//
//         }
//       }
//
//       notifyListeners();
//     });
//   }
//
//   Future<String> getAudioUri(String videoId) async {
//     String audioUrl = '';
//
//     try {
//       final yt.StreamManifest manifest =
//           await _youtubeExplode.videos.streamsClient.getManifest(videoId);
//
//       audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();
//
//       // print(audioUrl);
//       return audioUrl;
//     } catch (e) {
//       if (kDebugMode) {
//         print('explode error$e');
//         return 'Shit_Happens';
//       }
//     }
//
//     return audioUrl;
//   }
// }
