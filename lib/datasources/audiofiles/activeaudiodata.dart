import 'dart:async';




import 'package:flutter/material.dart';

class ActiveAudioData extends ChangeNotifier {




  String _videoId = '';
  String _audioUrl = '';
  String _artists = '';
  String _title = '';
  String _thumbnail = '';

  String get videoId => _videoId;
  String get audioUrl => _audioUrl;
  String get artists => _artists;
  String get title => _title;
  String get thumbnail => _thumbnail;






   Future songDetails(String audioUrl,String videoId, String artist, String title, String thumbnail) async{
     _videoId =videoId;
     _artists = artist;
     _title = title;
     _thumbnail = thumbnail;
     _audioUrl = audioUrl;

    notifyListeners();



  }




}








