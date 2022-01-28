// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerControls {
//   // static const url =
//   //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
//
//   var url =
//       "https://rr3---sn-g5pauxapo-jj0e.googlevideo.com/videoplayback?expire=1643314567&ei=J6nyYemDGY_MvwSK05TgDw&ip=202.168.85.193&id=o-AP5d4QclmBG9_M2KJc6cVFKw8JE0LAWMhBGItba5epAV&itag=139&source=youtube&requiressl=yes&mh=vT&mm=31%2C29&mn=sn-g5pauxapo-jj0e%2Csn-gwpa-h55e7&ms=au%2Crdu&mv=m&mvi=3&pl=24&gcr=in&initcwndbps=710000&vprv=1&mime=audio%2Fmp4&gir=yes&clen=1580572&dur=258.817&lmt=1614620515153040&mt=1643292592&fvip=3&keepalive=yes&fexp=24001373%2C24007246&c=ANDROID_EMBEDDED_PLAYER&txp=5531432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cgcr%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAJ5r-T2GxEjWUqIyXJEAa4R8oAfol026uS2ydBWNEWjgAiEA3dOIuhH_kvGMaMYdUrtZzvLJeNbbbsLMaNn7NYdVy9o%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAKi1HcX8ww4NTDMCVexqEpvmVfnl1CfjkgyeyehXuTR8AiEAlE6Mb2EBZNvdjQutknNC3LD-CC3Y2xP8y5OYFJmE0Jo%3D";
//
//   late AudioPlayer _audioPlayer;
//
//   AudioPlayerControls() {
//     _init();
//   }
//
//   void _init() async {
//     _audioPlayer = AudioPlayer();
//
//     _audioPlayer
//         .setAudioSource(ConcatenatingAudioSource(children: [
//       //AudioSource.uri(Uri.parse(
//        //   "https://rr2---sn-g5pauxapo-jj0e.googlevideo.com/videoplayback?expire=1643322487&ei=F8jyYfOhH7SC9fwPwMO-4A8&ip=202.168.85.193&id=o-AJU-xnCDRTUTJM49chVzkKE0zNuqNExrW4HC4-zw3ltI&itag=18&source=youtube&requiressl=yes&mh=m4&mm=31%2C29&mn=sn-g5pauxapo-jj0e%2Csn-gwpa-h556&ms=au%2Crdu&mv=m&mvi=2&pl=24&initcwndbps=706250&vprv=1&mime=video%2Fmp4&gir=yes&clen=8106688&ratebypass=yes&dur=261.061&lmt=1584110167516471&mt=1643300495&fvip=4&fexp=24001373%2C24007246&c=ANDROID_EMBEDDED_PLAYER&txp=5531432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAL5o6xWdM7191zcsMENOV55q875KPw1OWKW5uq3RBbZGAiEA0z58W7qtb2eZGrDNKM67veaNDQDxj-rwj0xVtRfU8ao%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhAO0vFWDK3pmfzarqjxs3JAS51CgwwwjSlHGq9HrBX0RcAiAwy7eSl77OU2zsbHDBbjhdeu4SdskhRVTJyDL10JfiXA%3D%3D")),
//       // AudioSource.uri(Uri.parse(
//       // "https://rr1---sn-g5pauxapo-jj0e.googlevideo.com/videoplayback?expire=1643322077&ei=fcbyYYv4KaCRg8UP3ayQ2AU&ip=202.168.85.193&id=o-AGf5iRAPMmw02awNXhV6tMVfyZcM6HFlzKhI9mLepBaS&itag=140&source=youtube&requiressl=yes&mh=Jv&mm=31%2C29&mn=sn-g5pauxapo-jj0e%2Csn-gwpa-h55z&ms=au%2Crdu&mv=m&mvi=1&pl=24&initcwndbps=733750&vprv=1&mime=audio%2Fmp4&ns=cAdqgt5lVrBjmzGOyiv91ewG&gir=yes&clen=3880424&dur=239.722&lmt=1634487764562716&mt=1643300017&fvip=1&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5531432&n=VPMa88AsOMuXkx&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAO5TJ8d6k532xjmssxW5xfyz01nP7Uin6P3hgL_Fl-O6AiEAirKZf17MGFfXq3oxyQaufKniXB9sB0DF_addc2y_1wk%3D&sig=AOq0QJ8wRQIgJieTqBghfkwigcpSmnmFbP0sOWzZ3AMufusQkcKKMowCIQCvh_i1lE6YB_GpBqZmkqN93AjhUGh6Csu2XwMerS8DtA%3D%3D")),
//       AudioSource.uri(Uri.parse(
//            "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
//     ]))
//         .catchError((error) {
//       // catch load errors: 404, invalid url ...
//       print("An error occured $error");
//     });
//
//     _audioPlayer.playerStateStream.listen((playerState) {
//       final isPlaying = playerState.playing;
//       final processingState = playerState.processingState;
//       if (processingState == ProcessingState.loading ||
//           processingState == ProcessingState.buffering) {
//         buttonNotifier.value = ButtonState.loading;
//       } else if (!isPlaying) {
//         buttonNotifier.value = ButtonState.paused;
//       } else if (processingState != ProcessingState.completed) {
//         buttonNotifier.value = ButtonState.playing;
//       } else {
//         _audioPlayer.seek(Duration.zero);
//         _audioPlayer.pause();
//       }
//     });
//
//     _audioPlayer.positionStream.listen((position) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: position,
//         buffered: oldState.buffered,
//         total: oldState.total,
//       );
//     });
//
//     _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: bufferedPosition,
//         total: oldState.total,
//       );
//     });
//
//     _audioPlayer.durationStream.listen((totalDuration) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: oldState.buffered,
//         total: totalDuration ?? Duration.zero,
//       );
//     });
//
//
//
//   }
//
//   void play() {
//     _audioPlayer.play();
//   }
//
//   void pause() {
//     _audioPlayer.pause();
//   }
//
//   void dispose() {
//     _audioPlayer.dispose();
//   }
//
//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }
//
//   final progressNotifier = ValueNotifier<ProgressBarState>(
//     ProgressBarState(
//       current: Duration.zero,
//       buffered: Duration.zero,
//       total: Duration.zero,
//     ),
//   );
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
// }
//
// class ProgressBarState {
//   ProgressBarState({
//     required this.current,
//     required this.buffered,
//     required this.total,
//   });
//
//   final Duration current;
//   final Duration buffered;
//   final Duration total;
// }
//
// enum ButtonState { paused, playing, loading }
