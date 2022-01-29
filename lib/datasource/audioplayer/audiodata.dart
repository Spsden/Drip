import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';



class AudioData extends ChangeNotifier {

//   AudioData({
//     required String videoidsetter ;
//     String artistsetter ;
//     String titlesetter;
//     String thumbnailsetter ;
//
// });

  var videoidsetter = '';
  var artistsetter = '';
  var titlesetter = '';
  var thumbnailsetter = '';


  void songDetails(String videoId, String artist, String title, String thumbnail){
     videoidsetter =videoId;
     artistsetter = artist;
     titlesetter = title;
     thumbnailsetter = thumbnail;

    notifyListeners();



  }















  }








