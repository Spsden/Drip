// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:drip/datasource/searchresults/topresultsdataclass.dart';

// class TopResultWidget extends StatelessWidget {
//   final Topresults toppresult;
//   const TopResultWidget({
//     Key? key,
//     required this.toppresult,
//   }) : super(key: key);

//   String? resultype() {
//     if (toppresult.resultType.toString() == 'artist') {
//       return toppresult.resultType.toString();
//     }
//     if (toppresult.resultType.toString() == 'video' ||
//         toppresult.resultType.toString() == 'song') {
//       return '${toppresult.artists.toString()}\n${toppresult.duration.toString()}';
//     }

//     if (toppresult.resultType.toString() == 'album') {
//       return '${toppresult.resultType.toString()}\n${toppresult.artists[]}';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.brown.withOpacity(0.4)),
//         child: Row(
//           children: [
//             CachedNetworkImage(
//               imageBuilder: (context, imageProvider) => CircleAvatar(
//                 radius: 80,
//                 backgroundImage: imageProvider,
//               ),
//               fit: BoxFit.cover,
//               errorWidget: (context, _, __) => const Image(
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/artist.jpg'),
//               ),
//               imageUrl: toppresult.thumbnails[1].url.toString(),
//               placeholder: (context, url) => const Image(
//                   fit: BoxFit.fill, image: AssetImage('assets/artist.jpg')),
//             ),
//             Column(
//               children: [
//                 Text(
//                   toppresult.title.toString(),
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 )
//               ],
//             )
//           ],
//         ));
//   }
// }
