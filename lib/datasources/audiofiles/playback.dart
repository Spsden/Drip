import 'dart:async';

import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart'
    as watchplaylist;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart' as mediakit;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../providers/audio_player_provider.dart';
import 'activeaudiodata.dart';

//Current Playlist
// List<watchplaylist.Track> tracks = [];
// final ValueNotifier<List<watchplaylist.Track>> tracks =
// ValueNotifier<List<watchplaylist.Track>>(tracks);

class AudioControlCentre extends ChangeNotifier {
  //static AudioControlCentre audioControlCentre = AudioControlCentre();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  late mediakit.Player player;
  late Ref ref;

  int index = 0;
  List<watchplaylist.Track> tracks = [];
  Map currentTrack = {'title': 'NA', 'artist': 'NA', 'thumb': 'NA'};

  double volume = 25.0;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = false;
  bool isBuffering = false;
  bool isCompleted = false;
  bool isMuted = false;

  //List<StreamSubscription> playBackStreams;

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }

  void playOrPause() {
    player.playOrPause();
  }

  void next() {
    player.next();
  }

  void prev() {
    player.previous();
  }

  void setVolume(double value) {
    player.volume = value;

    notifyListeners();
  }



  void seek(Duration position) async {
    player.seek(position);
  }

  Future<void> open(CurrentMusicInstance track, {int index = 0}) async {
    String streamLink = await getAudioUri(track.videoId);

    await player.open(
      mediakit.Playlist([mediakit.Media(streamLink, extras: track)],
          index: index),
    );
    tracks.clear();

    addWatchPlaylist(track.videoId);
  }

  Future<void> addWatchPlaylist(String videoId) async {
    late watchplaylist.WatchPlaylists watchPlaylists;
    await SearchMusic.getWatchPlaylist(videoId, 10).then((value) {
      watchPlaylists = value;
      tracks = watchPlaylists.tracks!;
      tracks.removeAt(0);
    });

    for (int i = 0; i < watchPlaylists.tracks!.length; i++) {
      String streamLink = await getAudioUri(tracks[i].videoId.toString());
      if (streamLink.isEmpty) {
        tracks.removeAt(i);
      }
      if (streamLink.isNotEmpty) {
        CurrentMusicInstance currentMusicInstance = CurrentMusicInstance(
            title: tracks[i].title.toString(),
            author:
                tracks[i].artists?.map((e) => e.name.toString()).toList() ?? [],
            thumbs:
                tracks[i].thumbnail?.map((e) => e.url.toString()).toList() ??
                    [],
            urlOfVideo: 'NA',
            videoId: streamLink);
        player.add(mediakit.Media(streamLink, extras: currentMusicInstance));
      }
    }
  }

  Future<String> getAudioUri(String videoId) async {
    String audioUrl = '';

    try {
      final StreamManifest manifest =
          await _youtubeExplode.videos.streamsClient.getManifest(videoId);

      audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

      return audioUrl;
    } catch (e) {
      print('explode error$e');

      return "Shit_Happens";
    }
  }

  AudioControlCentre({required this.player, required this.ref}) : super() {
    player.streams.playlist.listen((event) async {
      if (event.index < 0 || event.index > event.medias.length - 1) {
        return;
      }
      index = event.index;

      notifyListeners();
    });

    player.streams.isPlaying.listen((event) {
      isPlaying = event;

      notifyListeners();
    });

    player.streams.isPlaying.listen((event) {
      isPlaying = event;

      notifyListeners();
    });
    player.streams.isBuffering.listen((event) {
      isBuffering = event;
      notifyListeners();
    });
    player.streams.isCompleted.listen((event) {
      isCompleted = event;

      notifyListeners();
    });
    player.streams.position.listen((event) {
      // print(event.toString());
      position = event;
      // print(event.toString() +"          " +position.toString());
      notifyListeners();
    });
    player.streams.duration.listen((event) {
      duration = event;
      notifyListeners();
    });
    player.streams.volume.listen((event) {
      if(event == 0.0){
        isMuted = true;
      } else {
        isMuted = false;
      }

      volume = event;
      notifyListeners();
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    player.dispose();
  }
}

final audioControlCentreProvider =
    ChangeNotifierProvider<AudioControlCentre>((ref) {
  final player = ref.watch(audioPlayerProvider);
  return AudioControlCentre(player: player, ref: ref);
});
