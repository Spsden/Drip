import 'dart:async';

import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/pages/common/globals.dart';
import 'package:drip/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ActiveAudioData extends ChangeNotifier {
  String _videoId = '';
  String _audioUrl = '';
  String _artists = '';
  String _title =  '';
  String _thumbnail = '';
  String _thumbnailLarge = '';
  Color _albumExtracted = Colors.transparent;
  final List<ThumbnailLocal> _activeThumbnails = [];

  String get videoId => _videoId;

  String get audioUrl => _audioUrl;

  String get artists => _artists;

  String get title => _title;

  String get thumbnail => _thumbnail;

  Color get albumExtracted => _albumExtracted;

  String get thumbnailLarge => _thumbnailLarge;

  //List<ThumbnailLocal>? get activeThumbnail => _activeThumbnails;





  Future songDetails(String audioUrl, String videoId, String artist,
      String title, String thumbnail, String thumbnailLarge) async {
    _videoId = videoId;
    _artists = artist;
    _title = title;
    _thumbnail = thumbnail;
    _audioUrl = audioUrl;
    //  _activeThumbnails = activeThumbnail;
    _thumbnailLarge = thumbnailLarge;

    await Globals.colorGenerator(thumbnailLarge).then((value) {
      _albumExtracted = value;

      AppTheme().albumArtColor = value;

    });


    notifyListeners();
  }
}

final activeAudioDataNotifier = ChangeNotifierProvider((ref) => ActiveAudioData(),);

class CurrentMusicInstance {

  final String title;
  final List<String> author;
  final List<String?> thumbs;
  final String? urlOfVideo;
  final String videoId;

  CurrentMusicInstance(
      {required this.title,
      required this.author,
      required this.thumbs,
      required this.urlOfVideo,
      required this.videoId});

  factory CurrentMusicInstance.setter(String title,List<String> author, List<String> thumbs,String audioUrl,String videoId){
    return CurrentMusicInstance(title: title, author: author, thumbs: thumbs, urlOfVideo: audioUrl, videoId: videoId);
  }




}
