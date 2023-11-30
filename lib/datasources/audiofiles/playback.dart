import 'dart:async';

import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/models/watchplaylistdataclass.dart'
    as watchplaylist;
import 'package:drip/datasources/searchresults/local_models/recently_played.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:media_kit/media_kit.dart' as mediakit;
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:drip/datasources/searchresults/models/playlistdataclass.dart'
    as pd;

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
  Color? color;

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
    color = await updatePalette(tracks[index].thumbnail?.first.url.toString() ??
        'https://i.imgur.com/L3Ip1wh.png');

    // ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
    //     tracks[index].thumbnail?.first.url ??
    //         'https://i.imgur.com/L3Ip1wh.png');
  }

  Future<void> prev() async {
    player?.previous();
    color = await updatePalette(tracks[index].thumbnail?.first.url.toString() ??
        'https://i.imgur.com/L3Ip1wh.png');

    // ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
    //     tracks[index].thumbnail?.first.url ??
    //         'https://i.imgur.com/L3Ip1wh.png');
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

  Future<Color> updatePalette(String imgUrl) async {
    PaletteGenerator paletteGenerator;
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        ExtendedNetworkImageProvider(imgUrl));
    Color dominantColor =
        paletteGenerator.dominantColor?.color ?? Colors.transparent;

    if (dominantColor.computeLuminance() > 0.6) {
      Color contrastColor =
          paletteGenerator.darkMutedColor?.color ?? Colors.black;
      if (dominantColor == contrastColor) {
        contrastColor = paletteGenerator.lightMutedColor?.color ?? Colors.white;
      }
      if (contrastColor.computeLuminance() < 0.6) {
        dominantColor = contrastColor;
      }
    }

    return dominantColor;
    //return dominantColor;
  }

  Future<void> openAPlaylist(List<pd.Track> playlistItems) async {
    /// @TODO optimize playlist loading.
    String streamLink =
        await getAudioUri(playlistItems[0].videoId ?? "dQw4w9WgXcQ");

    //List<mediakit.Media> listOfMedia = [];
    List<String?>? listOfThumbs =
        playlistItems[0].thumbnails.map((e) => e.url.toString()).toList();
    List<String?>? listOfArtists =
        playlistItems[0].artists.map((e) => e.name.toString()).toList();

    Map<String, dynamic> currentPlaying = {
      "title": playlistItems[0].title,
      "author": listOfArtists ?? [],
      "thumbs": listOfThumbs ?? [],
      "urlOfVideo": 'NA',
      "videoId": playlistItems[0].videoId
    };
    player?.stop();
    await player?.open(
      mediakit.Playlist([mediakit.Media(streamLink, extras: currentPlaying)],
          index: index),
    );
    tracks.clear();

    for (int i = 1; i < playlistItems.length; i++) {
      pd.Track element = playlistItems[i];

      if (element.videoId != null) {
        List<String?> listOfThumbs =
            element.thumbnails.map((e) => e.url.toString()).toList();
        List<String?>? listOfArtists =
            element.artists.map((e) => e.name.toString()).toList();

        //  print(listOfThumbs.map((e) => e.toString()).toString());
        Map<String, dynamic> currentPlaying = {
          "title": element.title,
          "author": listOfArtists ?? [],
          "thumbs": listOfThumbs,
          "urlOfVideo": 'NA',
          "videoId": element.videoId
        };
        watchplaylist.Track track = watchplaylist.Track(
            album: watchplaylist.Album(
                name: element.album?.name, id: element.album?.id),
            artists: element.artists
                .map((e) => watchplaylist.Album(id: e.id, name: e.name))
                .toList(),
            feedbackTokens: "na",
            length: element.duration,
            likeStatus: "NA",
            thumbnail: element.thumbnails
                .map((e) => watchplaylist.Thumbnail(
                    height: e.height,
                    url: e.url ?? 'https://i.imgur.com/L3Ip1wh.png',
                    width: e.width))
                .toList(),
            title: element.title,
            videoId: element.videoId,
            year: "NA",
            views: "NA");
        final String streamLink =
            await getAudioUri(element.videoId ?? "dQw4w9WgXcQ");
        player?.add(mediakit.Media(streamLink, extras: currentPlaying));

        tracks.add(track);
      }
    }
  }

  Future<void> open(CurrentMusicInstance track, {int index = 0}) async {
    String streamLink = await getAudioUri(track.videoId);

    Map<String, dynamic> currentPlaying = {
      "title": track.title,
      "author": track.author ?? [],
      "thumbs": track.thumbs ?? [],
      "urlOfVideo": 'NA',
      "videoId": streamLink
    };
    player?.stop();
    await player?.open(
      mediakit.Playlist([mediakit.Media(streamLink, extras: currentPlaying)],
          index: index),
    );

    // await player?.open(
    //   mediakit.Media(
    //     "https://rr2---sn-g5pauxapo-o5be.googlevideo.com/videoplayback?expire=1699835294&ei=PhlRZYa1J73z4-EPr6-e-AE&ip=202.43.120.196&id=o-AGeAGrcdft1J-dG-kUTmSRzuQg--rDP9KN7Q5cv9dgi_&itag=251&source=youtube&requiressl=yes&mh=F_&mm=31%2C29&mn=sn-g5pauxapo-o5be%2Csn-cvh7knle&ms=au%2Crdu&mv=m&mvi=2&pl=24&initcwndbps=1132500&vprv=1&mime=audio%2Fwebm&gir=yes&clen=3440118&dur=183.021&lmt=1686835151168081&mt=1699813265&fvip=1&keepalive=yes&fexp=24007246&beids=24350018&c=ANDROID_TESTSUITE&txp=4532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=ANLwegAwRAIgKCtvV_rY5J8fyzvUhsEvjBTBhNrvmGJKNzLddzJaKskCIDw774go9zDzkLSsmOOkR9fO_0EdQSI_VQX6R6g4yP9K&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AM8Gb2swRgIhAPzEvDfnntN0Lsg1zIFM0Y5GKw5iMb6Do4X8stPm5Y3HAiEA__McmhbHeBCGhyzqnmaWnADuDcbUc37w4B5md1i-WVw%3D",
    //       extras: currentPlaying),
    // );
    color = await updatePalette(track.thumbs.first.toString());

    // color   = await compute<String,Color>((message) => updatePalette , "test");

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

    for (int i = 0; i < watchPlaylists.tracks!.length - 1; i++) {
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
            ready: () => {debugPrint("player initialized")}));
    audioControlCentreInstance.player?.stream.playlist.listen((event) async {
      if (event.index < 0 || event.index > event.medias.length - 1) {
        return;
      }

      audioControlCentreInstance.index = event.index;

      audioControlCentreInstance.notifyListeners();
    });
    audioControlCentreInstance.player?.stream.playing.listen((event) {
      audioControlCentreInstance.isPlaying = event;

      audioControlCentreInstance.notifyListeners();
    });
    audioControlCentreInstance.player?.stream.buffering.listen((event) {
      audioControlCentreInstance.isBuffering = event;
      audioControlCentreInstance.notifyListeners();
    });
    audioControlCentreInstance.player?.stream.completed.listen((event) async {
      if (audioControlCentreInstance.isCompleted != event) {
        // ref.read(nowPlayingPaletteProvider.notifier).updatePalette(
        //     tracks[index].thumbnail?.first.url ??
        //         'https://i.imgur.com/L3Ip1wh.png');

        audioControlCentreInstance.color = await audioControlCentreInstance
            .updatePalette(audioControlCentreInstance
                    .tracks[audioControlCentreInstance.index]
                    .thumbnail
                    ?.first
                    .url ??
                'https://i.imgur.com/L3Ip1wh.png');
      }

      audioControlCentreInstance.isCompleted = event;
      if (audioControlCentreInstance.repeat == true) {
        audioControlCentreInstance.prev();
      }

      audioControlCentreInstance.notifyListeners();
    });

    audioControlCentreInstance.player?.stream.position.listen((event) {
      // print(event.toString());
      audioControlCentreInstance.position = event;
      // print(event.toString() +"          " +position.toString());
      audioControlCentreInstance.notifyListeners();
    });
    audioControlCentreInstance.player?.stream.duration.listen((event) {
      audioControlCentreInstance.duration = event;
      audioControlCentreInstance.notifyListeners();
    });
    audioControlCentreInstance.player?.stream.volume.listen((event) {
      if (event == 0.0) {
        audioControlCentreInstance.isMuted = true;
      } else {
        audioControlCentreInstance.isMuted = false;
      }

      audioControlCentreInstance.volume = event;
      audioControlCentreInstance.notifyListeners();
    });
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

    bool existsInList = recentlyPlayedBox.values
        .any((element) => element.title == recentlyPlayed.title);
    if (!existsInList) {
      if (recentlyPlayedBox.length > 15) {
        recentlyPlayedBox.deleteAt(14);
        recentlyPlayedBox.add(recentlyPlayed);
      } else {
        recentlyPlayedBox.add(recentlyPlayed);
      }
    }
    // print(recentlyPlayedBox.values.first.title);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await player?.dispose();
  }
}

// final audioControlCentreProvider =
//     ChangeNotifierProvider<AudioControlCentre>((ref) {
//   final player = ref.watch(audioPlayerProvider);
//   return AudioControlCentre(player: player, ref: ref);
// });
