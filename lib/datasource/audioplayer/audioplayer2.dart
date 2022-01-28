




import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:drip/datasource/audioplayer/audiodata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerControls extends ChangeNotifier{

 // final AudioData _audioData = AudioData();


  Duration totalDuration = Duration();
  Duration position = Duration();
  Duration bufferposition = Duration();
  String audioState = "";
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  StreamController<String> streamController = StreamController();





  //List<MediaItem>


  late AudioPlayer _audioPlayer;
  late AudioHandler _audioHandler;

  var yt = YoutubeExplode();


  AudioPlayerControls() {
    _init();
  }

  Future<void> _init() async {
    _audioPlayer = AudioPlayer();

        final _playlist = ConcatenatingAudioSource(children: []);

    _playlist.add( AudioSource.uri(Uri.parse(
        "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),);
   // _playlist.

    //await _audioPlayer.setAudioSource(_playlist);

    _audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      // Preloading audio is not currently supported on Linux.
      await _audioPlayer.setAudioSource(_playlist,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }



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
          notifyListeners();

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







    //print(data + 'lol');












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
