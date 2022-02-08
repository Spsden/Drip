import 'dart:ffi';


import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:dart_vlc/dart_vlc.dart' as mediaplayer;
import 'package:flutter/foundation.dart';
import 'package:provider/src/provider.dart';

//import 'package:libwinmedia/libwinmedia.dart' as mediaplayer;
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


import 'audiodartclass.dart';
import 'audiodata.dart';


enum ButtonState { paused, playing, loading }


final progressNotifier = ValueNotifier<ProgressBarState>(
  ProgressBarState(
    current: Duration.zero,
    //buffered: Duration.zero,
    total: Duration.zero,
  ),
);


final ValueNotifier<double> bufferProgress = ValueNotifier<double>(0.0);


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


late final mediaplayer.Player player = mediaplayer.Player(id: 12)
  ..
  positionStream.listen((mediaplayer.PositionState state) {
    final oldState = progressNotifier.value;
    progressNotifier.value =
        ProgressBarState(current: state.position!, total: state.duration!);
    playerAlerts.position = state.position!;
    playerAlerts.total = state.duration!;
  })
  ..playbackStream.listen((mediaplayer.PlaybackState state) {
    final isPlaying = state.isPlaying;
    final processing = state.isSeekable;
    final isCompleted = state.isCompleted;





    playerAlerts.playStatus = state.isPlaying;
    playerAlerts.playbackComplete = state.isCompleted;
  })
  ..bufferingProgressStream.listen((bufferingProgress) {
    bufferProgress.value = bufferingProgress;
  });

final YoutubeExplode _youtubeExplode = YoutubeExplode();

List<mediaplayer.Media> medias = <mediaplayer.Media>[];
int currentMediaIndex = 0;
List<Track> tracks = [];

abstract class AudioControlClass {


  static Future<String> getAudioUri(String videoId) async {
    final StreamManifest manifest =
    await _youtubeExplode.videos.streamsClient.getManifest(videoId);

    var audioUrl = manifest.audioOnly
        .withHighestBitrate()
        .url
        .toString();

    return audioUrl;
  }

  static Future<void> addMusic(String playlistVideoId) async {
    late WatchPlaylists watchPlaylists;
    await SearchMusic.getWatchPlaylist(playlistVideoId, 10).then((value) {
      watchPlaylists = value;
      tracks = watchPlaylists.tracks!;
    });
    // watchPlaylists.tracks![0].title.toString();
    //watchPlaylists.tracks?.forEach((element) {print(element.title);});

    for (int i = 0; i < watchPlaylists.tracks!.length; i++) {
      String videoIdOf = watchPlaylists.tracks![i].videoId.toString();
      var audioUri = await getAudioUri(videoIdOf);
      print(watchPlaylists.tracks![i].title);
      medias.add(mediaplayer.Media.network(audioUri));
    }
  }

  // static Future<void> nextMusic() async {
  // player.next();
  // }


  static Future<void> setVolume(double volume) async {
    player.setVolume(volume);
  }

  static Future<void> seek(Duration position) async {
    player.seek(position);
  }

  static Future <void> play({
    //required int index,
    required String audioUrl,
    required String videoId,
    required BuildContext context,

    // required List<Music> music,
  }) async {
    medias.clear();
    medias.add(Media.network(audioUrl));
    currentMediaIndex = 0;
    mediaplayer.Playlist playlist = mediaplayer.Playlist(
        medias: medias, playlistMode: mediaplayer.PlaylistMode.single);


    // medias.add(Media.network(audioUrl));


    // player.open(
    //   mediaplayer.Media.network(audioUrl),
    //   autoStart: true


    // player.open(mediaplayer.Playlist(medias: medias,playlistMode: PlaylistMode.single));
    player.open(playlist, autoStart: true);


    await Future.delayed(const Duration(milliseconds: 100));
    player.jump(0);


    await Future.delayed(const Duration(milliseconds: 100));
    player.play();

    await addMusic(videoId);

   // Future.delayed(player.position.duration! - player.position.position!);

  }

  static Future<void> playOrPause() async {
    if (player.playback.isPlaying) {
      player.pause();
    } else {
      player.play();
    }
  }

  void dispose() {
    _youtubeExplode.close();
  }



  static Future<void> nextMusic(BuildContext context,int nIndex) async {
    // player.next();
    // player.jump(3);
    if(currentMediaIndex == 0)
      {
        currentMediaIndex +=2;
      }else {
      currentMediaIndex++;
    }
    // currentMediaIndex +=nIndex;
    print(currentMediaIndex);
   await  context.read<ActiveAudioData>().songDetails(tracks[currentMediaIndex-1].videoId.toString(),
        tracks[currentMediaIndex-1].videoId.toString(),
        tracks[currentMediaIndex-1].artists![0].name.toString(),
    tracks[currentMediaIndex-1].title.toString(),
    tracks[currentMediaIndex-1].thumbnail![0].url.toString());

    player.open(medias[currentMediaIndex], autoStart: true);
  }

  static Future<void> previousMusic(BuildContext context) async {
    // player.next();
    // player.jump(3);
    currentMediaIndex -=2;
    print(currentMediaIndex);
    await  context.read<ActiveAudioData>().songDetails(tracks[currentMediaIndex-1].videoId.toString(),
        tracks[currentMediaIndex-1].videoId.toString(),
        tracks[currentMediaIndex-1].artists![0].name.toString(),
        tracks[currentMediaIndex-1].title.toString(),
        tracks[currentMediaIndex-1].thumbnail![0].url.toString());

    player.open(medias[currentMediaIndex], autoStart: true);
  }


}



var playerAlerts = PlayerNotifiers();

class PlayerNotifiers extends ChangeNotifier {
  bool _playStatus = false;
  bool _playbackComplete = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;
  bool _buffering = false;
  List<Music> _music = <Music>[];

  bool get playStatus => _playStatus;

  bool get playbackComplete => _playbackComplete;

  Duration get position => _position;

  Duration get total => _total;

  bool get buffering => _buffering;

  List<Music> get music => _music;


  set music(List<Music> songs) {
    _music = songs;
    notifyListeners();
  }

  set playStatus(bool playStatus) {
    _playStatus = playStatus;
    notifyListeners();
  }

  set playbackComplete(bool playbackComplete) {
    _playbackComplete = playbackComplete;
    notifyListeners();
  }

  set buffering(bool buffering) {
    _buffering = buffering;
    notifyListeners();
  }

  set position(Duration position) {
    _position = position;
    notifyListeners();
  }

  set total(Duration total) {
    _total = total;
    notifyListeners();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _youtubeExplode.close();
  }


}







