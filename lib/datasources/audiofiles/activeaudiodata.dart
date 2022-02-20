import 'dart:async';




import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:flutter/material.dart';

class ActiveAudioData extends ChangeNotifier {




  String _videoId = '';
  String _audioUrl = '';
  String _artists = '';
  String _title = '';
  String _thumbnail = '';
  String _thumbnailLarge = '';
   List<ThumbnailLocal>? _activeThumbnails = [];

  String get videoId => _videoId;
  String get audioUrl => _audioUrl;
  String get artists => _artists;
  String get title => _title;
  String get thumbnail => _thumbnail;
  String get thumbnailLarge => _thumbnailLarge;
  List<ThumbnailLocal>? get activeThumbnail => _activeThumbnails;






   Future songDetails(String audioUrl,String videoId, String artist, String title, String thumbnail, List<ThumbnailLocal> activeThumbnail,String thumbnailLarge) async{
     _videoId =videoId;
     _artists = artist;
     _title = title;
     _thumbnail = thumbnail;
     _audioUrl = audioUrl;
     _activeThumbnails = activeThumbnail;
     _thumbnailLarge = thumbnailLarge;

    notifyListeners();



  }

  Map<String, dynamic> toJson() => {
    //"album": album?.toJson(),
    "artists": _artists,

   // "category": category,
   // "duration": duration,
    //"duration_seconds": durationSeconds,
   // "feedbackTokens": feedbackTokens.toJson(),
   // "isExplicit": isExplicit,
   // "resultType": resultType,
    "thumbnails": _thumbnail,
    "title": _title,
    "videoId": _videoId,
   // "year": year,
  };






}










