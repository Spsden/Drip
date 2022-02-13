import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:provider/provider.dart';
import 'package:drip/datasources/searchresults/playlistdataclass.dart' as explay;

import '../../datasources/audiofiles/audiocontrolcentre.dart';
import '../../datasources/audiofiles/audiodata.dart';
import '../../datasources/searchresults/watchplaylistdataclass.dart';
import '../../theme.dart';

class CommonPlaylist extends StatefulWidget {
  final List<Track> currentTracks;
  final int trck;


  const CommonPlaylist({Key? key, required this.currentTracks, required this.trck,   }) : super(key: key);

  @override
  _CommonPlaylistState createState() => _CommonPlaylistState();
}

class _CommonPlaylistState extends State<CommonPlaylist> {

  List thisPage = [];
  bool loaded = false;

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
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;


    if(widget.currentTracks.isEmpty ){
      return Text('Oops no playlist loaded');
    }
 else if(MediaQuery.of(context).size.width > 700) {
   return Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         AlbumArtCard(trck: widget.trck,tracks: widget.currentTracks),
         Container(
             alignment: Alignment.centerLeft,
             height: size.height - 200,
             width: size.width / 2.5,
             margin: const EdgeInsets.only(right: 20),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8)),

             child :Container(
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
               itemCount: widget.currentTracks.length,
               shrinkWrap: true,
               //controller: _sc,
               itemBuilder: (context, index) {
                 return HoverButton(
                   cursor: SystemMouseCursors.copy,
                   // splashColor: Colors.grey[130],
                   // customBorder: mat.ShapeBorder(),
                   //hoverColor: Colors.grey[130],
                   onPressed: () async {
                     var audioUrl =
                         await AudioControlClass.getAudioUri(
                             widget.currentTracks[index]
                                 .videoId
                                 .toString());
                     print(audioUrl.toString());

                     playerAlerts.buffering = true;

                     await context
                         .read<ActiveAudioData>()
                         .songDetails(
                         audioUrl,
                         widget.currentTracks[index].videoId ?? '',
                       widget.currentTracks[index].artists![0].name ?? '',
                       widget.currentTracks[index].title ?? '',
                       widget.currentTracks[index].thumbnail![0].url ?? ''
                     );
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

                     await AudioControlClass.play(
                         audioUrl: audioUrl,
                         videoId:
                             widget.currentTracks[index].videoId.toString(),
                         context: context);
                   },
                   builder: (BuildContext, states) {

                     return AnimatedContainer(
                       margin: const EdgeInsets.only(
                           left: 10, right: 10, bottom: 15),
                       padding: const EdgeInsets.only(
                           top: 5, bottom: 5),
                       decoration: BoxDecoration(
                           borderRadius:
                               BorderRadius.circular(8),
                           color: Colors.grey[30].withOpacity(0.2)
                           // color:
                           // index == widget.trck ? context.watch<AppTheme>().color :
                           //     context.watch<AppTheme>().mode ==
                           //                 ThemeMode.dark ||
                           //             context
                           //                     .watch<AppTheme>()
                           //                     .mode ==
                           //                 ThemeMode.system
                           //         ? Colors.grey[150]
                           //         : Colors.grey[30]


                       ),
                       duration: FluentTheme.of(context)
                           .fastAnimationDuration,
                       child: ClipRRect(
                           borderRadius:
                               BorderRadius.circular(10),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment:
                                 MainAxisAlignment.spaceAround,
                             children: [
                               SizedBox(width: 5,),
                               CachedNetworkImage(
                                 width: 40,
                                 height: 40,
                                 imageBuilder:
                                     (context, imageProvider) =>
                                         CircleAvatar(
                                   backgroundColor:
                                       Colors.transparent,
                                   foregroundColor:
                                       Colors.transparent,
                                   radius: 100,
                                   backgroundImage:
                                       imageProvider,
                                 ),
                                 fit: BoxFit.cover,
                                 errorWidget: (context, _, __) =>
                                     const Image(
                                   fit: BoxFit.cover,
                                   image: AssetImage(
                                       'assets/cover.jpg'),
                                 ),
                                 imageUrl:

                           widget.currentTracks[index].thumbnail![0].url.toString(),

                                // someList[index].thumbnail![0].url.toString(),

                                 // widget.currentTracks[index]
                                 //     .thumbnail![0]
                                 //     .url
                                 //     .toString()
                                 //     ,


                                 placeholder: (context, url) =>
                                     const Image(
                                         fit: BoxFit.cover,
                                         image: AssetImage(
                                             'assets/cover.jpg')),
                               ),
                               spacer,

                               SizedBox(
                                 width: MediaQuery.of(context)
                                         .size
                                         .width *
                                     1 /
                                     8,
                                 child: Text(
                           widget.currentTracks[index].title.toString(),

                                   // someList[index].title.toString(),
                                   // widget.currentTracks[index]
                                   //     .title
                                   //     .toString(),

                                   overflow:
                                       TextOverflow.ellipsis,
                                 ),
                               ),
                               spacer,
                               SizedBox(
                                 width: MediaQuery.of(context)
                                         .size
                                         .width *
                                     1 /
                                     15,
                                 child: Text(

          widget.currentTracks[index].artists![0].name.toString(),
                                   //someList[index].artists![0].name.toString(),


                                   // widget.currentTracks[index]
                                   //     .artists![0]
                                   //     .name
                                   //     .toString(),


                                   overflow:
                                       TextOverflow.ellipsis,
                                 ),
                               ),
                               //spacer,
                               if (MediaQuery.of(context)
                                       .size
                                       .width > 1000)
                                 SizedBox(
                                   width: MediaQuery.of(context)
                                           .size
                                           .width *
                                       1 /
                                       15,
                                   child: Text(

                                     //someList[index].album!.name.toString(),


                                     widget.currentTracks[index]
                                         .album!
                                         .name
                                         .toString(),

                                     overflow:
                                         TextOverflow.ellipsis,
                                   ),
                                 ),
                               SizedBox(
                                 width: MediaQuery.of(context)
                                         .size
                                         .width *
                                     1 /
                                     25,
                                 child: Text(


                                   widget.currentTracks[index]
                                       .length
                                       .toString(),

                                   overflow:
                                       TextOverflow.ellipsis,
                                 ),
                               ),
                             ],
                           )),
                     );
                   },
                 );
               }),
         )
         )]
    );
 } else {
   return  CustomScrollView(
     shrinkWrap: true,
     slivers: [
       mat.SliverAppBar(

         // title:
         // RichText(
         //   //textAlign: TextAlign.justify,
         //   text: TextSpan(
         //     text: " ${context.watch<ActiveAudioData>().title}  \n",
         //     style: typography.title,
         //
         //     children:  <TextSpan>[
         //       TextSpan(text:  " ${context.watch<ActiveAudioData>().artists}  ", style:typography.subtitle),
         //       //TextSpan(text:"${context.watch<ActiveAudioData>().}"),
         //     ],
         //   ),
         // ) ,
         expandedHeight: size.height *0.4,
         //pinned: true,
         stretch: true,
         snap:  true,
         elevation: 0,
         //pinned: true,

         floating: true,
         stretchTriggerOffset: size.height/6,

         flexibleSpace: mat.FlexibleSpaceBar(
           title: Text(
             '${context.watch<ActiveAudioData>().title}  \n"',
             textAlign: TextAlign.center,
             overflow: TextOverflow.ellipsis,
           ),
           centerTitle: true,
           titlePadding: const EdgeInsetsDirectional.only(
             start: 72,
             bottom: 16,
             end: 120,
           ),
           background: Stack(
             children: [
               SizedBox.expand(
                 child: ShaderMask(
                   shaderCallback: (rect) {
                     return const LinearGradient(
                       begin: Alignment.center,
                       end: Alignment.bottomCenter,
                       colors: [
                         Colors.black,
                         Colors.transparent,
                       ],
                     ).createShader(
                       Rect.fromLTRB(
                         0,
                         0,
                         rect.width,
                         rect.height,
                       ),
                     );
                   },
                   blendMode: BlendMode.dstIn,
                   child: CachedNetworkImage(
                     width: size.width,
                     height: size.width,


                     fit: BoxFit.cover,
                     errorWidget: (context, _, __) => const Image(
                       fit: BoxFit.cover,
                       image: AssetImage('assets/cover.jpg'),
                     ),
                     imageUrl:
                     widget.currentTracks[widget.trck].thumbnail!.last.url.toString() ?? 'https://rukminim1.flixcart.com/image/416/416/poster/3/r/d/cute-cats-hd-poster-art-bshi4736-bshil4736-large-original-imaehwdptnnqz2sp.jpeg?q=70',
                     placeholder: (context, url) =>  const Image(

                         fit: BoxFit.cover,
                         image: AssetImage('assets/cover.jpg')),
                   ),
                 ),
               ),

             ],
           ),
         ),

         ),


       SliverToBoxAdapter(
         child: SizedBox(height: 20,),
       ),
       SliverFillRemaining(
           child: Container(
             alignment: Alignment.centerLeft,
             //height: size.height - 200,
             //width: size.width / 2.5,
             margin: const EdgeInsets.only(right: 20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               // border: Border.all(
               //     width: 2,
               //     color: context.watch<AppTheme>().color)
             ),
             child: ListView.builder(
                 itemCount: widget.currentTracks.length,
                 shrinkWrap: true,
                 //controller: _sc,
                 itemBuilder: (context, index) {
                   return HoverButton(
                     cursor: SystemMouseCursors.copy,
                     // splashColor: Colors.grey[130],
                     // customBorder: mat.ShapeBorder(),
                     //hoverColor: Colors.grey[130],
                     onPressed: () async {
                       var audioUrl =
                       await AudioControlClass.getAudioUri(
                           widget.currentTracks[index]
                               .videoId
                               .toString());
                       print(audioUrl.toString());

                       playerAlerts.buffering = true;
                       await context
                           .read<ActiveAudioData>()
                           .songDetails(
                           audioUrl,
                           widget.currentTracks[index].videoId ?? '',
                           widget.currentTracks[index].artists![0].name ?? '',
                           widget.currentTracks[index].title ?? '',
                           widget.currentTracks[index].thumbnail![0].url ?? ''
                       );
                       currentTrackIndex.value = 0;

                       // currentMediaIndex = 0;

                       await AudioControlClass.play(
                           audioUrl: audioUrl,
                           videoId:
                           widget.currentTracks[index].videoId.toString(),
                           context: context);
                     },
                     builder: (BuildContext, states) {
                       return AnimatedContainer(
                         margin: const EdgeInsets.only(
                             left: 10, right: 10, bottom: 15),
                         padding: const EdgeInsets.only(
                             top: 5, bottom: 5),
                         decoration: BoxDecoration(
                             borderRadius:
                             BorderRadius.circular(8),
                             color: index == widget.trck ? context.watch<AppTheme>().color :
                             context.watch<AppTheme>().mode ==
                                 ThemeMode.dark ||
                                 context
                                     .watch<AppTheme>()
                                     .mode ==
                                     ThemeMode.system
                                 ? Colors.grey[150]
                                 : Colors.grey[30]),
                         duration: FluentTheme.of(context)
                             .fastAnimationDuration,
                         child: ClipRRect(
                             borderRadius:
                             BorderRadius.circular(10),
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment:
                               MainAxisAlignment.spaceAround,
                               children: [

                                 CachedNetworkImage(
                                   width: 40,
                                   height: 40,
                                   imageBuilder:
                                       (context, imageProvider) =>
                                       CircleAvatar(
                                         backgroundColor:
                                         Colors.transparent,
                                         foregroundColor:
                                         Colors.transparent,
                                         radius: 100,
                                         backgroundImage:
                                         imageProvider,
                                       ),
                                   fit: BoxFit.cover,
                                   errorWidget: (context, _, __) =>
                                   const Image(
                                     fit: BoxFit.cover,
                                     image: AssetImage(
                                         'assets/cover.jpg'),
                                   ),
                                   imageUrl: widget.currentTracks[index]
                                       .thumbnail![0]
                                       .url
                                       .toString()
                                       .toString(),

                                   // widget.isFromPrimarySearchPage ? _songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
                                   placeholder: (context, url) =>
                                   const Image(
                                       fit: BoxFit.cover,
                                       image: AssetImage(
                                           'assets/cover.jpg')),
                                 ),
                                 spacer,

                                 SizedBox(
                                   width: MediaQuery.of(context)
                                       .size
                                       .width *
                                       1 /
                                       3,
                                   child: Text(
                                     widget.currentTracks[index]
                                         .title
                                         .toString(),
                                     // widget.isFromPrimarySearchPage ? _songs[index].title.toString() : 'Kuch is tarah',
                                     overflow:
                                     TextOverflow.ellipsis,
                                   ),
                                 ),
                                 spacer,
                                 SizedBox(
                                   width: MediaQuery.of(context)
                                       .size
                                       .width *
                                       1 /
                                       15,
                                   child: Text(
                                     widget.currentTracks[index]
                                         .artists![0]
                                         .name
                                         .toString(),
                                     // widget.isFromPrimarySearchPage ? _songs[index].artists![0].name.toString() : 'Atif',
                                     overflow:
                                     TextOverflow.ellipsis,
                                   ),
                                 ),
                                 //spacer,
                                 if (MediaQuery.of(context)
                                     .size
                                     .width >
                                     800)
                                   SizedBox(
                                     width: MediaQuery.of(context)
                                         .size
                                         .width *
                                         1 /
                                         15,
                                     child: Text(
                                       widget.currentTracks[index]
                                           .album!
                                           .name
                                           .toString(),
                                       //  widget.isFromPrimarySearchPage ? _songs[index].album!.name.toString() : 'The jal band',
                                       overflow:
                                       TextOverflow.ellipsis,
                                     ),
                                   ),
                                 SizedBox(
                                   width: MediaQuery.of(context)
                                       .size
                                       .width *
                                       1 /
                                       25,
                                   child: Text(
                                     // 'lol',
                                     widget.currentTracks[index]
                                         .length
                                         .toString(),
                                     //widget.isFromPrimarySearchPage ? _songs[index].duration.toString() : '5:25',
                                     overflow:
                                     TextOverflow.ellipsis,
                                   ),
                                 ),
                               ],
                             )),
                       );
                     },
                   );
                 }),
           )

       )
     ],

   );
 }
  }
}










class AlbumArtCard extends StatelessWidget {
  final int trck;
  final List<Track> tracks;
  const AlbumArtCard({Key? key, required this.trck, required this.tracks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
          maxHeight: size.width / 2.5, maxWidth: size.width / 2.5),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8)
      // ),

      child: mat.Card(
        clipBehavior: Clip.antiAlias,
        shape: mat.RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                Stack(
                  children: [

                                 CachedNetworkImage(
                                  height: min(constraints.maxHeight,
                                      constraints.maxWidth),
                                  width: min(constraints.maxHeight,
                                      constraints.maxWidth),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, _, __) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/cover.jpg'),
                                  ),
                                  imageUrl:
                                  tracks[trck].thumbnail!.last.url.toString() ,
                                  placeholder: (context, url) => const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/cover.jpg')),
                                ),

                    // Image.network(
                    //
                    //   "https://wallpaperaccess.com/full/2817687.jpg",
                    //   fit: BoxFit.cover,
                    //   height: min(constraints.maxHeight,
                    //       constraints.maxWidth),
                    //   width: min(constraints.maxHeight,
                    //       constraints.maxWidth),
                    // ),
                    Container(
                      height: min(constraints.maxHeight, constraints.maxWidth),
                      width: min(constraints.maxHeight, constraints.maxWidth),
                      margin: const mat.EdgeInsets.only(bottom: 10),
                      child: mat.Align(
                          alignment: Alignment.bottomLeft,
                          child: RichText(
                            text: TextSpan(
                              text: " ${context.watch<ActiveAudioData>().title}  \n",
                              style: typography.title,

                              children:  <TextSpan>[
                                TextSpan(text:  " ${context.watch<ActiveAudioData>().artists}  ", style:typography.subtitle),
                                //TextSpan(text:"${context.watch<ActiveAudioData>().}"),
                              ],
                            ),
                          )
                      ),
                      decoration: const BoxDecoration(
                          gradient: mat.LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // const Color(0xCC000000),
                                Color(0x00000000),
                                Color(0x00000000),
                                // context.watch<AppTheme>().color.withOpacity(0.5),
                                Color(0xCC000000),
                              ])),
                    )
                  ],
                )),
      ),
    );
  }
}





