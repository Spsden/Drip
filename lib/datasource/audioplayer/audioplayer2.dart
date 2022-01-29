
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerControls extends ChangeNotifier{
  // static const url =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  Duration totalDuration = Duration();
  Duration position = Duration();
  Duration bufferposition = Duration();
  String audioState = "";
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  //var buttonState = ButtonState.paused;

  // var url =
  //     "https://rr3---sn-g5pauxapo-jj0e.googlevideo.com/videoplayback?expire=1643314567&ei=J6nyYemDGY_MvwSK05TgDw&ip=202.168.85.193&id=o-AP5d4QclmBG9_M2KJc6cVFKw8JE0LAWMhBGItba5epAV&itag=139&source=youtube&requiressl=yes&mh=vT&mm=31%2C29&mn=sn-g5pauxapo-jj0e%2Csn-gwpa-h55e7&ms=au%2Crdu&mv=m&mvi=3&pl=24&gcr=in&initcwndbps=710000&vprv=1&mime=audio%2Fmp4&gir=yes&clen=1580572&dur=258.817&lmt=1614620515153040&mt=1643292592&fvip=3&keepalive=yes&fexp=24001373%2C24007246&c=ANDROID_EMBEDDED_PLAYER&txp=5531432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cgcr%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAJ5r-T2GxEjWUqIyXJEAa4R8oAfol026uS2ydBWNEWjgAiEA3dOIuhH_kvGMaMYdUrtZzvLJeNbbbsLMaNn7NYdVy9o%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAKi1HcX8ww4NTDMCVexqEpvmVfnl1CfjkgyeyehXuTR8AiEAlE6Mb2EBZNvdjQutknNC3LD-CC3Y2xP8y5OYFJmE0Jo%3D";

  late AudioPlayer _audioPlayer;

  AudioPlayerControls() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();

    await _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
     // AudioSource.uri(Uri.parse(
       //   "https://rr3---sn-g5pauxapo-jj0e.googlevideo.com/videoplayback?expire=1643386822&ei=ZsPzYZfwN5OevQTVx7ToAQ&ip=202.168.85.144&id=o-ANtPPpqgqX4OR3UQU3FnHTNKyFt9iZHbhT9X2rQ9hBdX&itag=140&source=youtube&requiressl=yes&mh=mG&mm=31%2C29&mn=sn-g5pauxapo-jj0e%2Csn-gwpa-h55e7&ms=au%2Crdu&mv=m&mvi=3&pl=24&initcwndbps=776250&vprv=1&mime=audio%2Fmp4&gir=yes&clen=6480498&dur=400.381&lmt=1642210753645537&mt=1643364811&fvip=4&keepalive=yes&fexp=24001373%2C24007246&c=ANDROID_EMBEDDED_PLAYER&txp=5532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAIW68nBxgr363vTBm1e9FzRvNP_Thlr-zsPq4Z1_zAAuAiEAzcA5tDo_ihkdSvwOh_mkYZ5TxxweXO2NeMthXVoyrJo%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAM0Hyt8OadRfufoVoE36kbBrFtnRILmBuv-FyjIKV-I2AiEA8dtxRkV136vRAisb8cVTjPqSXfCUlUCI9RBW9ihyGEc%3D")),
      // AudioSource.uri(Uri.parse(
      // "shorturl.at/gkoHI")),
      //AudioSource.uri(Url.)
       AudioSource.uri(Uri.parse(
           "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });

    _audioPlayer.durationStream.listen((event) {
      totalDuration = event!;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((event) {
      position = event;
      notifyListeners();
    });

    _audioPlayer.bufferedPositionStream.listen((event) {
      bufferposition = event;

    });

    _audioPlayer.playerStateStream.listen((playerState) {
      final isplaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering)
      {
        // audioState = "Lo
        //buttonState = ButtonState.loading;
        // notifyListeners();
        buttonNotifier.value = ButtonState.loading;

      }
      else if (!isplaying) {
        //audioState = "Paused";
        // buttonState = ButtonState.paused;
        // notifyListeners();
        buttonNotifier.value = ButtonState.paused;
      }

      else if (processingState != ProcessingState.completed) {
        //audioState = "Playing";
        // buttonState = ButtonState.playing;

        // notifyListeners();
        buttonNotifier.value = ButtonState.playing;
      }
      else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });










  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void volume(double volume){
    _audioPlayer.setVolume(volume);

  }




}

//
enum ButtonState { paused, playing, loading }
