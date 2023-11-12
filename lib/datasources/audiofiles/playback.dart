import 'dart:async';

import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/models/watchplaylistdataclass.dart'
    as watchplaylist;
import 'package:drip/datasources/searchresults/local_models/recently_played.dart';
import 'package:drip/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:media_kit/media_kit.dart' as mediakit;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../providers/audio_player_provider.dart';
import 'activeaudiodata.dart';

//Current Playlist
// List<watchplaylist.Track> tracks = [];
// final ValueNotifier<List<watchplaylist.Track>> tracks =
// ValueNotifier<List<watchplaylist.Track>>(tracks);

class AudioControlCentre extends ChangeNotifier {
  static final AudioControlCentre audioControlCentreInstance =
      AudioControlCentre();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  mediakit.Player? player;
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
  bool repeat = false;

  //List<StreamSubscription> playBackStreams;

  Future<void> play() async {
    player?.play();
  }

  Future<void> pause() async {
    player?.pause();
  }

  Future<void> playOrPause() async {
    player?.playOrPause();
  }

  Future<void> next() async {
    player?.next();
    ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
        tracks[index].thumbnail?.first.url ??
            'https://i.imgur.com/L3Ip1wh.png');
  }

  Future<void> prev() async {
    player?.previous();
    ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
        tracks[index].thumbnail?.first.url ??
            'https://i.imgur.com/L3Ip1wh.png');
  }

  Future<void> setVolume(double value) async {
    player?.setVolume(value);

    notifyListeners();
  }

  void setRepeat() {
    repeat = !repeat;
    //print(repeat);
    notifyListeners();
  }

  void seek(Duration position) async {
    player?.seek(position);
  }

  Future<void> open(CurrentMusicInstance track, {int index = 0}) async {
    String streamLink = await getAudioUri(track.videoId);
    print(streamLink);

    Map<String, dynamic> currentPlaying = {
      "title": track.title,
      "author": track.author ?? [],
      "thumbs": track.thumbs ?? [],
      "urlOfVideo": 'NA',
      "videoId": streamLink
    };

    await player?.open(
      mediakit.Media(
          "https://rr2---sn-g5pauxapo-o5be.googlevideo.com/videoplayback?expire=1699802413&ei=zZhQZYDmHOmi9fwPoq21gAI&ip=202.43.120.196&id=o-AL1lv18eZfYt8Kv1J7xlH2ajueyxUdvDSIGBRWmADxfK&itag=251&source=youtube&requiressl=yes&mh=F_&mm=31%2C29&mn=sn-g5pauxapo-o5be%2Csn-cvh7knle&ms=au%2Crdu&mv=m&mvi=2&pl=24&initcwndbps=993750&vprv=1&mime=audio%2Fwebm&gir=yes&clen=3440118&dur=183.021&lmt=1686835151168081&mt=1699780381&fvip=1&keepalive=yes&fexp=24007246&beids=24350018&c=ANDROID_TESTSUITE&txp=4532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=ANLwegAwRAIgc027qW-RMvhbVzkAL_zQ1tsKl3mFhFHgKxG9U1iX56ACIF8_D08jBAVzjJlcdjuszeD7KJFXwteeD8KuE895_BSi&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AM8Gb2swRgIhANdxNNOSzwq5CNqrg5hxbCt0JXF2zpbrDhI8L1VvtmZ5AiEAkD_jL9oIUTEAMAENH51FC1ghywpIT2Bo_t-sEZnpWhI%3D",
          extras: currentPlaying),
    );

    // ref
    //     .read(nowPlayingPaletteProvider.notifier)
    //     .updatePalette(track.thumbs.first.toString());

    tracks.clear();

    addWatchPlaylist(track.videoId);
    saveRecentlyPlayed(track);
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
      } else {
        Map<String, dynamic> currentPlaying = {
          "title": tracks[i].title.toString(),
          "author":
              tracks[i].artists?.map((e) => e.name.toString()).toList() ?? [],
          "thumbs":
              tracks[i].thumbnail?.map((e) => e.url.toString()).toList() ?? [],
          "urlOfVideo": 'NA',
          "videoId": streamLink
        };
        // CurrentMusicInstance currentMusicInstance = CurrentMusicInstance(
        //     title: tracks[i].title.toString(),
        //     author:
        //     tracks[i].artists?.map((e) => e.name.toString()).toList() ?? [],
        //     thumbs:
        //     tracks[i].thumbnail?.map((e) => e.url.toString()).toList() ??
        //         [],
        //     urlOfVideo: 'NA',
        //     videoId: streamLink
        // );

        player?.add(mediakit.Media(streamLink, extras: currentPlaying));
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
      if (kDebugMode) {
        print('explode error$e');
      }

      return "";
    }
  }

  static Future<void> initialize() async {
    audioControlCentreInstance.player = mediakit.Player(
        configuration: mediakit.PlayerConfiguration(
            logLevel: mediakit.MPVLogLevel.error,
            vo: null,

            title: "Drip",
            ready: () => {print("deciduous")}));
    // audioControlCentreInstance.player?.stream.playlist.listen((event) async {
    //   if (event.index < 0 || event.index > event.medias.length - 1) {
    //     return;
    //   }
    //
    //   audioControlCentreInstance.index = event.index;
    //
    //   audioControlCentreInstance.notifyListeners();
    // });
    // audioControlCentreInstance.player?.stream.playing.listen((event) {
    //   audioControlCentreInstance.isPlaying = event;
    //
    //   audioControlCentreInstance.notifyListeners();
    // });
    // audioControlCentreInstance.player?.stream.buffering.listen((event) {
    //   audioControlCentreInstance.isBuffering = event;
    //   audioControlCentreInstance.notifyListeners();
    // });
    // audioControlCentreInstance.player?.stream.completed.listen((event) {
    //   if (audioControlCentreInstance.isCompleted != event) {
    //     // ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
    //     //     tracks[index].thumbnail?.first.url ??
    //     //         'https://i.imgur.com/L3Ip1wh.png');
    //   }
    //
    //   audioControlCentreInstance.isCompleted = event;
    //   if (audioControlCentreInstance.repeat == true) {
    //     audioControlCentreInstance.prev();
    //   }
    //
    //   audioControlCentreInstance.notifyListeners();
    // });
    //
    // audioControlCentreInstance.player?.stream.position.listen((event) {
    //   // print(event.toString());
    //   audioControlCentreInstance.position = event;
    //   // print(event.toString() +"          " +position.toString());
    //   audioControlCentreInstance.notifyListeners();
    // });
    // audioControlCentreInstance.player?.stream.duration.listen((event) {
    //   audioControlCentreInstance.duration = event;
    //   audioControlCentreInstance.notifyListeners();
    // });
    // audioControlCentreInstance.player?.stream.volume.listen((event) {
    //   if (event == 0.0) {
    //     audioControlCentreInstance.isMuted = true;
    //   } else {
    //     audioControlCentreInstance.isMuted = false;
    //   }
    //
    //   audioControlCentreInstance.volume = event;
    //   audioControlCentreInstance.notifyListeners();
    // });
  }

  // AudioControlCentre({required this.player, required this.ref}) : super() {
  //   player.stream.playlist.listen((event) async {
  //     if (event.index < 0 || event.index > event.medias.length - 1) {
  //       return;
  //     }
  //
  //     index = event.index;
  //
  //     notifyListeners();
  //   });
  //
  //   player.stream.playing.listen((event) {
  //     isPlaying = event;
  //
  //     notifyListeners();
  //   });
  //   player.stream.buffering.listen((event) {
  //     isBuffering = event;
  //     notifyListeners();
  //   });
  //   player.stream.completed.listen((event) {
  //     if (isCompleted != event) {
  //       ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
  //           tracks[index].thumbnail?.first.url ??
  //               'https://i.imgur.com/L3Ip1wh.png');
  //     }
  //
  //     isCompleted = event;
  //     if (repeat == true) {
  //       prev();
  //     }
  //
  //     notifyListeners();
  //   });
  //   player.stream.position.listen((event) {
  //     // print(event.toString());
  //     position = event;
  //     // print(event.toString() +"          " +position.toString());
  //     notifyListeners();
  //   });
  //   player.stream.duration.listen((event) {
  //     duration = event;
  //     notifyListeners();
  //   });
  //   player.stream.volume.listen((event) {
  //     if (event == 0.0) {
  //       isMuted = true;
  //     } else {
  //       isMuted = false;
  //     }
  //
  //     volume = event;
  //     notifyListeners();
  //   });
  // }

  void saveRecentlyPlayed(CurrentMusicInstance currentMusicInstance) async {
    RecentlyPlayed recentlyPlayed = RecentlyPlayed(
        title: currentMusicInstance.title,
        author: currentMusicInstance.author,
        thumbs: currentMusicInstance.thumbs,
        urlOfVideo: currentMusicInstance.urlOfVideo,
        videoId: currentMusicInstance.videoId);
    final recentlyPlayedBox = Hive.box('recentlyPlayed');
    // print(recentlyPlayedBox.length.toString() + "iudfsghfduihg");

    if (recentlyPlayedBox.length > 15) {
      recentlyPlayedBox.deleteAt(14);
    }
    recentlyPlayedBox.add(recentlyPlayed);
  }

  @override
  Future<void> dispose() async {
    await player?.dispose();
  }
}

// final audioControlCentreProvider =
//     ChangeNotifierProvider<AudioControlCentre>((ref) {
//   final player = ref.watch(audioPlayerProvider);
//   return AudioControlCentre(player: player, ref: ref);
// });
