import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart'
    as watch;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:dart_vlc/dart_vlc.dart' as mediaplayer;
import 'package:flutter/foundation.dart';
import 'package:provider/src/provider.dart';
import 'package:drip/datasources/searchresults/playlistdataclass.dart'
    as playData;

import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'activeaudiodata.dart';

enum ButtonState { paused, playing, loading }

final progressNotifier = ValueNotifier<ProgressBarState>(
  ProgressBarState(
    current: Duration.zero,
    //buffered: Duration.zero,
    total: Duration.zero,
  ),
);

final ValueNotifier<List<watch.Track>> tracklist =
    ValueNotifier<List<watch.Track>>(tracks);

final ValueNotifier<double> bufferProgress = ValueNotifier<double>(11.0);
final ValueNotifier<int> currentTrackValueNotifier =
    ValueNotifier<int>(currentMediaIndex = 0);

final YoutubeExplode _youtubeExplode = YoutubeExplode();

final mediaplayer.Player player = mediaplayer.Player(id: 12)
  ..positionStream.listen((mediaplayer.PositionState state) {
    progressNotifier.value =
        ProgressBarState(current: state.position!, total: state.duration!);
  })
  ..playbackStream.listen((mediaplayer.PlaybackState state) {
    // final isPlaying = state.isPlaying;
    // final processing = state.isSeekable;
    // final isCompleted = state.isCompleted;

    //playerAlerts.playbackComplete = state.isCompleted;
  })
  ..bufferingProgressStream.listen((bufferingProgress) {
    bufferProgress.value = bufferingProgress;
  })
  ..currentStream.listen((CurrentState state) {
    currentTrackValueNotifier.value = state.index!;
  });

List<mediaplayer.Media> medias = <mediaplayer.Media>[];
int currentMediaIndex = 0;

List<watch.Track> tracks = [];

abstract class AudioControlClass with ChangeNotifier {
  static Future<void> shuffle(List<playData.Track> tracks) async {
    player.stop();

    tracklist.value.clear();
    currentTrackValueNotifier.value = 0;

    //player.open(Media.network(audioUrl,extras: extrasMap), autoStart: true);
    player.open(Media.network(await getAudioUri(tracks[0].videoId.toString())),
        autoStart: true);

    for (int i = 0; i < tracks.length; i++) {
      watch.Album album =
          watch.Album(id: tracks[i].album?.id, name: tracks[i].album?.name);

      List<watch.Album> artist = tracks[i]
          .artists
          .map((e) => watch.Album(id: e.id, name: e.name))
          .toList();

      List<watch.Thumbnail> thumbs = tracks[i]
          .thumbnails
          .map((e) => watch.Thumbnail(
              height: e.height, url: e.url.toString(), width: e.width))
          .toList();

      watch.Track track = watch.Track(
          album: album,
          artists: artist,
          feedbackTokens: tracks[i].isExplicit,
          length: tracks[i].duration,
          likeStatus: "Lol",
          thumbnail: thumbs,
          title: tracks[i].title,
          videoId: tracks[i].videoId,
          year: tracks[i].title,
          views: "not available");

      tracklist.value.add(track);
      player.add(Media.network(
          await getAudioUri(tracklist.value[i].videoId.toString())));
    }
  }

  static Future<String> getAudioUri(String videoId) async {
    String audioUrl = '';

    try {
      final StreamManifest manifest =
          await _youtubeExplode.videos.streamsClient.getManifest(videoId);

      audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

      // if (kDebugMode) {
      //   print(audioUrl);
      // }
      return audioUrl;
    } catch (e) {
      print('explode error$e');

      return "Shit_Happens";
    }
  }

  static Future<void> addMusic(
    String playlistVideoId,
  ) async {
    late watch.WatchPlaylists watchPlaylists;
    await SearchMusic.getWatchPlaylist(playlistVideoId, 10).then((value) {
      watchPlaylists = value;
      //tracks = watchPlaylists.tracks!;
      tracklist.value = watchPlaylists.tracks!;
      tracklist.value.removeAt(0);
    });

    for (int i = 0; i < watchPlaylists.tracks!.length; i++) {
      // Map<String, dynamic> extrasMap = {
      //   "title": watchPlaylists.tracks![i].title,
      //   "author": watchPlaylists.tracks![i].artists,
      //   "thumbs": watchPlaylists.tracks![i].thumbnail,
      //   "videoId": watchPlaylists.tracks![i].videoId,
      //   "duration" : watchPlaylists.tracks![i].length,
      //
      // };

      player.add(Media.network(
          await getAudioUri(tracklist.value[i].videoId.toString())));
    }

    // for (int i = 1; i < watchPlaylists.tracks!.length; i++) {
    //   String videoIdOf = watchPlaylists.tracks![i].videoId.toString();
    //   var audioUri = await getAudioUri(videoIdOf);
    //
    //   if(audioUri == "Shit_Happens"){
    //     i++;
    //
    //   } else {
    //               Map<String, dynamic> extrasMap = {
    //         "title": watchPlaylists.tracks![i].title,
    //         "author": watchPlaylists.tracks![i].artists,
    //         "thumbs": watchPlaylists.tracks![i].thumbnail,
    //         "videoId": watchPlaylists.tracks![i].videoId,
    //         "duration" : watchPlaylists.tracks![i].length,
    //         "streamUrl" : audioUri
    //       };
    //
    //     player.add(Media.network(audioUri,extras: extrasMap,parse: true));
    //     tracklist.value.add(watchPlaylists.tracks![i]);
    //   }
    //
    //
    // }
  }

  static Future<void> setVolume(double volume) async {
    player.setVolume(volume);
  }

  static Future<void> seek(Duration position) async {
    player.seek(position);
  }

  static Future<void> play({
    required String videoId,
    required BuildContext context,
  }) async {
    medias.clear();

    player.stop();
    tracklist.value.clear();
    currentTrackValueNotifier.value = 0;

    //player.open(Media.network(audioUrl,extras: extrasMap), autoStart: true);
    player.open(Media.network(await getAudioUri(videoId)), autoStart: true);
    print("played from old logic");

    await addMusic(videoId);
  }

  static Future<void> playOrPause() async {
    if (player.playback.isPlaying) {
      player.pause();
    } else {
      player.play();
    }
  }

  AudioControlClass() {
    @override
    void dispose() {
      _youtubeExplode.close();
      player.dispose();
    }
  }

  static Future<void> nextMusic(
      BuildContext context, int nIndex, bool gapLess) async {
    player.next();

    print("hEYYY");

    await context.read<ActiveAudioData>().songDetails(
        tracklist.value[currentTrackValueNotifier.value].videoId.toString(),
        tracklist.value[currentTrackValueNotifier.value].videoId.toString(),
        tracklist.value[currentTrackValueNotifier.value].artists![0].name
            .toString(),
        tracklist.value[currentTrackValueNotifier.value].title.toString(),
        tracklist.value[currentTrackValueNotifier.value].thumbnail![0].url
            .toString(),
        tracklist.value[currentTrackValueNotifier.value].thumbnail!.last.url
            .toString());
  }

  static Future<void> previousMusic(BuildContext context) async {
    // player.next();
    // player.jump(3);

    player.previous();

    if (currentTrackValueNotifier.value >= 2) {
      int lol = currentTrackValueNotifier.value - 2;
      print(tracklist.value[lol].title.toString());
      await context.read<ActiveAudioData>().songDetails(
          tracklist.value[lol].videoId.toString(),
          tracklist.value[lol].videoId.toString(),
          tracklist.value[lol].artists![0].name.toString(),
          tracklist.value[lol].title.toString(),
          tracklist.value[lol].thumbnail![0].url.toString(),
          tracklist.value[lol].thumbnail!.last.url.toString());
    }

    // currentTrackValueNotifier.value = currentMediaIndex;
  }
}

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
