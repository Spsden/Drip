import 'package:flutter/material.dart';

class AudioData extends ChangeNotifier {
  String videoidsetter = "";
  String artistsetter = "";
  String titlesetter = "";
  String thumbnailsetter = "";

  void songDetails(String videoId, String artist, String title, String thumbnail){
    videoidsetter =videoId;
    artistsetter = artist;
    titlesetter = title;
    thumbnailsetter = thumbnail;

    notifyListeners();


    // map1['id'] = videoId;
    // map1['artist'] = artist;
    // map1['title'] = title;
    // map1['thumb'] = thumbnail;

  }


}