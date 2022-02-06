import 'dart:async';




import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';






class ActiveAudioData extends ChangeNotifier {



//   AudioData({
//     required this.audioUrlSetter,
//     required this.titlesetter,
//     required this.videoidsetter,
//     required this.thumbnailsetter,
//     required this.artistsetter
//
// });

  var videoidsetter = '';
  var audioUrlSetter = '';
  var artistsetter = '';
  var titlesetter = '';
  var thumbnailsetter = '';


  Future songDetails(String audioUrl,String videoId, String artist, String title, String thumbnail) async{
     videoidsetter =videoId;
     artistsetter = artist;
     titlesetter = title;
     thumbnailsetter = thumbnail;
     audioUrlSetter = audioUrl;

    notifyListeners();



  }




}








