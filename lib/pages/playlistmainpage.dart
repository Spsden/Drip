import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/pages/common/listoftracks.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../datasources/searchresults/watchplaylistdataclass.dart';
import '../theme.dart';

class PlaylistMain extends StatefulWidget {
  final String playlistId;
  const PlaylistMain({Key? key, required this.playlistId}) : super(key: key);

  @override
  _PlaylistMainState createState() => _PlaylistMainState();
}

class _PlaylistMainState extends State<PlaylistMain> {


  late List<Track> playlistTracks = [];
  late WatchPlaylists watchPlaylists;
   bool status = false;
   bool fetched = false;

  @override
  void initState() {
    // TODO: implement initState

    //fetchPlaylist(widget.playlistId);
    super.initState();
  }


  Future <void> fetchPlaylist(String playlistId) async{

    await SearchMusic.getWatchPlaylist(playlistId, 30).then((value) => {


        playlistTracks = value.tracks

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    if (!status)  {
      status = true;
      SearchMusic.getWatchPlaylist('RDAMVMs-bZD3O3P80',30)
          .then((value) {
        if (mounted) {
          setState(() {
            watchPlaylists = value;
            print(value.toString());

            playlistTracks = watchPlaylists.tracks!;

            // _topresults = listOfSearchResults['topresults'];
            fetched = true;
          });
        }
      });
    }

    return Column(
      children: [
        FloatingActionButton.large(
            child: Icon(FluentIcons.back),

            onPressed: (){
              Navigator.of(context).pop();
            }),

        Expanded(child:
        (!fetched) ?
    Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
    color: context.watch<AppTheme>().color, size: 300),
    ):

        CommonPlaylist(currentTracks: playlistTracks, trck: 0)



        )],
    );



      //CommonPlaylist(currentTracks: currentTracks, trck: trck);
  }
}
