// import 'package:drip/datasource/searchresults/searchresultstwo.dart';
// import 'package:fluent_ui/fluent_ui.dart' as fluent;
// import 'package:flutter/material.dart';
//
// import 'package:drip/datasource/searchresults/songsdataclass.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class SongsSearch extends StatelessWidget {
//   late List<Songs> songs = [];
//   final String toSongsList;
//   SongsSearch({
//     Key? key,
//     required this.songs, required this.toSongsList,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: fluent.MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 30,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children:  [
//               const Text(
//                 'Songs',
//                 style: TextStyle(
//                   ///color: Theme.of(context).colorScheme.secondary,
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamed('songslistpage', arguments: toSongsList);
//
//                 },
//                 child: const Text(
//                   'Show more     ',
//                   style: TextStyle(
//                     ///color: Theme.of(context).colorScheme.secondary,
//                     color: Colors.red,
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//
//           height: 250,
//           child: ListView.builder(
//             itemCount: songs.length,
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             // padding: const EdgeInsets.only(bottom: 10),
//             itemBuilder: (context, index) {
//               return InkWell(
//                   hoverColor: Colors.red.withOpacity(0.4),
//                 onTap: () {},
//
//
//                 child: Container(
//                   margin: const EdgeInsets.fromLTRB(0,5,0,5),
//                   //margin: const EdgeInsets.only(top: 10),
//                   color: Colors.brown.withOpacity(0.4),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: fluent.MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: CachedNetworkImage(
//                               fit: BoxFit.cover,
//                               errorWidget: (context, _, __) => const Image(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage('assets/cover.jpg'),
//                               ),
//                               imageUrl: songs[index].thumbnails[0].url.toString(),
//                               placeholder: (context, url) => const Image(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/cover.jpg')),
//                             )),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         SizedBox(
//                           width: 150,
//                           child: Text(
//                             songs[index].title.toString(),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         const Icon(
//                           fluent.FluentIcons.play_solid,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         SizedBox(
//                           width: 150,
//                           child: Text(
//                             songs[index].artists![0].name.toString(),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         SizedBox(
//                             width: 200,
//                             child: Text(
//                               songs[index].album!.name.toString(),
//                               overflow: TextOverflow.ellipsis,
//                             )),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         SizedBox(
//                             width: 150,
//                             child: Text(
//                               songs[index].duration.toString(),
//                               overflow: TextOverflow.ellipsis,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }