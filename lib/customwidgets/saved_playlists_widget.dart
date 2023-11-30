import 'package:drip/datasources/searchresults/local_models/saved_playlist.dart';
import 'package:drip/datasources/searchresults/models/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/local_models/tracks_local.dart'
    as localtracks;
import 'package:expandable_text/expandable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import "package:flutter/material.dart";

// class PlayContainer extends ConsumerWidget {
//   final String imageUrl, songName, singerName, year;
//
//   const PlayContainer(
//       {Key? key,
//         required this.imageUrl,
//         required this.songName,
//         required this.singerName,
//         required this.year})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return InkWell(
//       onTap: () {
//         print("Hell");
//       },
//       child: fluent.Acrylic(
//         tint: ref.watch(nowPlayingPaletteProvider),
//         child: Container(
//
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           width: MediaQuery.of(context).size.width / 1.28,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Image.network(
//                     imageUrl,
//                     width: 70,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           songName,
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 6),
//                         Row(
//                           children: [Text("$singerName - "), Text(year)],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const Icon(Icons.more_vert)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../pages/playlistmainpage.dart';

// class FeelGoodPlaylist extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           child: Row(
//             children: [
//               Image.network('https://m.media-amazon.com/images/I/61448uTtdLS.jpg',fit: BoxFit.cover),
//               Column(
//                 children: [
//                   Text(
//                     'Feelin\' Good: Bollywood',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//
//                 ],
//               )
//
//             ],
//           ),
//         )
//
//         Text(
//           'Feelin\' Good: Bollywood',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Text('42 songs'),
//         Text('These Bollywood songs never fail to bring smile to our faces and joy to our spirit. Enjoy this selection.'),
//         Expanded(
//           child: ListView(
//             children: <Widget>[
//               ListTile(
//                 leading: Image.network('https://m.media-amazon.com/images/I/61448uTtdLS.jpg',fit: BoxFit.cover),
//                 title: Text('Matarghashti'),
//                 subtitle: Text('Mohit Chauhan • 2015'),
//               ),
//               ListTile(
//                 leading: Image.network('https://m.media-amazon.com/images/I/61448uTtdLS.jpg',fit: BoxFit.cover),
//                 title: Text('Sooraj Ki Baahon Mein'),
//                 subtitle: Text('Loy Mendonsa, Dominique Cerejo...'),
//               ),
//               ListTile(
//                 leading: Image.network('https://m.media-amazon.com/images/I/61448uTtdLS.jpg',fit: BoxFit.cover),
//                 title: Text('Buddhu Sa Mann'),
//                 subtitle: Text('Amaal Mallik • 2016'),
//               ),
//               // Add more ListTiles here
//             ],
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.play_arrow),
//               onPressed: () {
//                 // Play action
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 // Add action
//               },
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }


class PlaylistContainer extends StatelessWidget {
  final SavedPlayList data;

  const PlaylistContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<localtracks.Track> tracks = data.tracks.sublist(0, 3);
    debugPrint(tracks.length.toString());
    Size size = MediaQuery.of(context).size;

    tracks.forEach((element) {print(element.artists.first);});

    //Typography typography = FluentTheme.of(context).typography;

    // String image_url =
    //     "https://i0.wp.com/99lyricstore.com/wp-content/uploads/2022/11/Apna-Bana-Le-Lyrics-Arijit-Singh.jpg";

    return Material(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistMain(
                playlistId: data.id,
              ),
            ),
          );


        },
        child: Card(
          color: Colors.transparent,
          elevation: 10,
          // height: 500,
          // width: 400,
          //margin: const EdgeInsets.all(10),
          // padding: const EdgeInsets.all(8),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //   color: fluent.FluentTheme.of(context)
          //       .resources
          //       .cardBackgroundFillColorDefault,
          // ),
          child: Column(
            children: [
              // ListTile(
              //   title: Text(data.playListTitle),
              //
              //   leading: Image.network(
              //     data.thumbnail,
              //     fit: BoxFit.cover,
              //     //height: 90,
              //   ),
              // ),
              fluent.Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ExtendedImage.network(
                      data.thumbnail,
                      width: 70,
                      height: 90,
                      fit: BoxFit.fill,
                      cache: true,
                     // border: Border.all(color: Colors.red, width: 1.0),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      //cancelToken: cancellationToken,
                    ),
                    // Image.network(
                    //   data.thumbnail,
                    //   fit: BoxFit.cover,
                    //
                    //   height:90,
                    // ),
                    // Center(
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            data.playListTitle,
                            style:
                                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data.description,
                            style:  TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color:Colors.white.withOpacity(0.7)),
                            maxLines: 2,
                            softWrap: true,



                          ),
                        ],
                      ),
                    ),
                    // )
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Relive some of the biggest pop song of the 2010s",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w200,color: Colors.white.withOpacity(0.7)),
                ),
              ),

              Column(
                  children: tracks
                      .map(
                        (e) => ListTile(
                          leading: Image.network(
                            e.thumbnails.first,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text(e.title ?? 'na',maxLines: 2,overflow: TextOverflow.ellipsis,),
                          subtitle: Text(
                            e.artists.join(" "),maxLines: 1,overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.more_vert),
                          //tileColor: Colors.green,
                          onTap: () {},
                        ),
                      )
                      .toList()

                  // [
                  //   ListTile(
                  //     leading: Image.network(
                  //       image_url,
                  //       width: 70,
                  //     ),
                  //     title: Text("Apna Bana Le"),
                  //     subtitle: Text("Arijit Singh"),
                  //     trailing: const Icon(Icons.more_vert),
                  //     tileColor: Colors.green,
                  //     onTap: () {},
                  //   ),
                  //   ListTile(
                  //     leading: Image.network(
                  //       image_url,
                  //       width: 70,
                  //     ),
                  //     title: Text("Apna Bana Le"),
                  //     subtitle: Text("Arijit Singh"),
                  //     trailing: const Icon(Icons.more_vert),
                  //     onTap: () {},
                  //   ),
                  //   ListTile(
                  //     leading: Image.network(
                  //       image_url,
                  //       width: 70,
                  //     ),
                  //     title: Text("Apna Bana Le"),
                  //     subtitle: Text("Arijit Singh"),
                  //     trailing: const Icon(Icons.more_vert),
                  //     onTap: () {},
                  //   ),
                  //   Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         ElevatedButton(
                  //           onPressed: () {},
                  //           style: ElevatedButton.styleFrom(
                  //               shape: const CircleBorder(),
                  //               minimumSize: const Size(50, 50)),
                  //           child: const Icon(Icons.play_arrow_rounded),
                  //         ),
                  //         const SizedBox(
                  //           width: 20,
                  //         ),
                  //         ElevatedButton(
                  //           onPressed: () {},
                  //           style: ElevatedButton.styleFrom(
                  //               shape: const CircleBorder(),
                  //               minimumSize: const Size(50, 50)),
                  //           child: const Icon(Icons.delete),
                  //         )
                  //       ],
                  //     ),
                  //   )
                  // ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
