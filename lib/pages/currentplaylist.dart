import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/common/listoftracks.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../datasources/audiofiles/audiodata.dart';
import '../datasources/searchresults/watchplaylistdataclass.dart';

class CurrentPlaylist extends StatefulWidget {
  const CurrentPlaylist({Key? key}) : super(key: key);

  @override
  _CurrentPlaylistState createState() => _CurrentPlaylistState();
}

class _CurrentPlaylistState extends State<CurrentPlaylist> {
  List<Songs> _songs = [];

  //late List<Track> currentTracks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


      return ValueListenableBuilder<int>(
          valueListenable: currentTrackIndex,
          builder: (_, trck, __) {
            return ValueListenableBuilder<List<Track>>(
                valueListenable: tracklist,
                builder: (_, currentTracks, __) {
                  return CommonPlaylist(currentTracks: currentTracks, trck: trck,);
                });
          });




  }
}
