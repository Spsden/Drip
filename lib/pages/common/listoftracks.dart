import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:provider/provider.dart';

import '../../datasources/audiofiles/audiocontrolcentre.dart';
import '../../datasources/audiofiles/audiodata.dart';
import '../../datasources/searchresults/watchplaylistdataclass.dart';
import '../../theme.dart';

class CommonTrackList extends StatefulWidget {
  final List<Track> tracklist;
  final int currentTrackIndex;
  final bool isFromPrimarySearchPage;
  final List<Songs> songs;
  final VoidCallback? onScroll;
  final bool? isLoading;

  const CommonTrackList(
      {Key? key,
      required this.tracklist,
      required this.currentTrackIndex,
      required this.isFromPrimarySearchPage,
      required this.songs,
      this.onScroll,
      this.isLoading})
      : super(key: key);

  @override
  _CommonTrackListState createState() => _CommonTrackListState();
}

class _CommonTrackListState extends State<CommonTrackList> {
  
  
 // var localList ;
      
      
      @override
      void initState() {
    // TODO: implement initState
    super.initState();
    
  //  localList = widget.tracklist.isEmpty ? widget.songs : widget.tracklist;
  }
  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text('lol'),
        Container(
          alignment: Alignment.centerLeft,
          height: size.height - 200,
          width: size.width / 2.5,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(
            //     width: 2,
            //     color: context.watch<AppTheme>().color)
          ),
          child: ListView.builder(
              itemCount:
                  widget.tracklist.isEmpty ? widget.songs.length : widget.tracklist.length,


            //  localList.length,
              shrinkWrap: true,
              //controller: _sc,
              itemBuilder: (context, index) {
                return HoverButton(
                  cursor: SystemMouseCursors.copy,
                  // splashColor: Colors.grey[130],
                  // customBorder: mat.ShapeBorder(),
                  //hoverColor: Colors.grey[130],
                  onPressed: () async {

                    if(widget.tracklist.isEmpty){

                      var audioUrl = await AudioControlClass.getAudioUri(
                          widget.songs[index].videoId.toString());
                      print(audioUrl.toString());

                      await context.read<ActiveAudioData>().songDetails(
                          audioUrl,
                          widget.songs[index].videoId ?? '',
                          widget.songs[index].artists![0].name ?? '',
                          widget.songs[index].title ?? '',
                          widget.songs[index].thumbnails![0].url ?? '');

                      await AudioControlClass.play(
                          audioUrl: audioUrl,
                          videoId: widget.songs[index].videoId.toString(),
                          context: context);



                    } else {
                      var audioUrl = await AudioControlClass.getAudioUri(
                          widget.tracklist[index].videoId.toString());
                      print(audioUrl.toString());

                      await context.read<ActiveAudioData>().songDetails(
                          audioUrl,
                          widget.tracklist[index].videoId ?? '',
                          widget.tracklist[index].artists![0].name ?? '',
                          widget.tracklist[index].title ?? '',
                          widget.tracklist[index].thumbnail![0].url ?? '');

                      await AudioControlClass.play(
                          audioUrl: audioUrl,
                          videoId: widget.tracklist[index].videoId.toString(),
                          context: context);

                    }
                    // var audioUrl = await AudioControlClass.getAudioUri(
                    //     localList[index].videoId.toString());
                    // print(audioUrl.toString());

                    playerAlerts.buffering = true;

                    // await context.read<ActiveAudioData>().songDetails(
                    //     audioUrl,
                    //     localList[index].videoId ?? '',
                    //     localList[index].artists![0].name ?? '',
                    //     localList[index].title ?? '',
                    //     localList[index].thumbnail![0].url ?? '');
                    // await context
                    //     .read<ActiveAudioData>()
                    //     .songDetails(
                    //         audioUrl,
                    //         _songs[index].videoId,
                    //         _songs[index].artists![0].name,
                    //         _songs[index].title,
                    //         _songs[index].thumbnails[0].url);

                    // currentMediaIndex = 0;
                    currentTrackIndex.value = 0;
                    //
                    // await AudioControlClass.play(
                    //     audioUrl: audioUrl,
                    //     videoId: localList[index].videoId.toString(),
                    //     context: context);
                  },
                  builder: (BuildContext, states) {
                    return AnimatedContainer(
                      margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index == widget.currentTrackIndex
                              ? context.watch<AppTheme>().color
                              : context.watch<AppTheme>().mode == ThemeMode.dark ||
                              context.watch<AppTheme>().mode ==
                                  ThemeMode.system
                              ? Colors.grey[150]
                              : Colors.grey[30]),
                      duration: FluentTheme.of(context).fastAnimationDuration,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              CachedNetworkImage(
                                width: 40,
                                height: 40,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                      radius: 100,
                                      backgroundImage: imageProvider,
                                    ),
                                fit: BoxFit.cover,
                                errorWidget: (context, _, __) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                                imageUrl:
        widget.tracklist.isEmpty ? widget.songs[index].thumbnails![0].url.toString() :
    widget.tracklist[index].thumbnail![0].url.toString() ,


    // localList[index]
    //                                 .thumbnail![0]
    //                                 .url
    //                                 .toString()
    //                                 .toString(),

                                // widget.isFromPrimarySearchPage ? _songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
                                placeholder: (context, url) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/cover.jpg')),
                              ),
                              spacer,

                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1 / 8,
                                child: Text(

    widget.tracklist.isEmpty ? widget.songs[index].title.toString() :
    widget.tracklist[index].title.toString() ,

    //localList[index].title.toString(),

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              spacer,
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1 / 15,
                                child: Text(

    widget.tracklist.isEmpty ? widget.songs[index].artists![0].toString() :
    widget.tracklist[index].artists![0].toString() ,
                                //  localList[index].artists![0].name.toString(),

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              //spacer,
                              if (MediaQuery.of(context).size.width > 800)
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1 / 15,
                                  child: Text(

    widget.tracklist.isEmpty ? widget.songs[index].album.toString() :
    widget.tracklist[index].album.toString() ,
                                   // localList[index].album!.name.toString(),

                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1 / 25,
                                child: Text(
                                  // 'lol',
    widget.tracklist.isEmpty ? widget.songs[index].duration.toString() :
    widget.tracklist[index].length.toString() ,
                                 // localList[index].length.toString(),

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                );
              }),
        ),

      ],

    );
  }
}


