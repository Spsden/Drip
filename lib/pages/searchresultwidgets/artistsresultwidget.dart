import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:cached_network_image/cached_network_image.dart';

class ArtistsSearch extends StatelessWidget {
  late List<Artists> artists = [];

  ArtistsSearch({
    Key? key,
    required this.artists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 250,
          // width: 800,
          child: ListView.builder(
            itemCount: artists.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            itemBuilder: (context, index) {
              return mat.InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('artistsPage',
                      arguments: artists[index].browseId.toString());
                },
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  width: 220,
                  height: 250,
                  child: mat.Card(
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundColor: mat.Colors.transparent,
                            foregroundColor: Colors.transparent,
                            radius: 100,
                            backgroundImage: imageProvider,
                          ),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/artist.jpg'),
                          ),
                          imageUrl: artists[index].thumbnails?.last.url.toString() ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOAQ7BhOGwDxmTw_6aRu2zlOiQ-WdTdF2XUxKBEAz_Q1MrOReLWZ-W4FaCUBkt5xod2cA&usqp=CAU',
                          placeholder: (context, url) => const Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/artist.jpg')),
                        ),
                        //const SizedBox(height: 20,),
                        Text(
                          artists[index].artist.toString(),
                          style:
                          typography.body?.apply(fontSizeFactor: 1.2),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// class ArtistCard extends StatelessWidget {
//   const ArtistCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return mat.InkWell(
//       onTap: () {
//         Navigator.of(context).pushNamed('artistsPage',
//             arguments: artists[index].browseId.toString());
//       },
//       child: Container(
//         color: Colors.transparent,
//         margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
//         width: 220,
//         height: 250,
//         child: mat.Card(
//           shadowColor: Colors.transparent,
//           color: Colors.transparent,
//           child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             alignment: WrapAlignment.center,
//             children: [
//               CachedNetworkImage(
//                 imageBuilder: (context, imageProvider) => CircleAvatar(
//                   backgroundColor: mat.Colors.transparent,
//                   foregroundColor: Colors.transparent,
//                   radius: 100,
//                   backgroundImage: imageProvider,
//                 ),
//                 fit: BoxFit.cover,
//                 errorWidget: (context, url, error) => const Image(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/artist.jpg'),
//                 ),
//                 imageUrl: artists[index].thumbnails?.last.url.toString() ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOAQ7BhOGwDxmTw_6aRu2zlOiQ-WdTdF2XUxKBEAz_Q1MrOReLWZ-W4FaCUBkt5xod2cA&usqp=CAU',
//                 placeholder: (context, url) => const Image(
//                     fit: BoxFit.fill,
//                     image: AssetImage('assets/artist.jpg')),
//               ),
//               //const SizedBox(height: 20,),
//               Text(
//                 artists[index].artist.toString(),
//                 style:
//                 typography.body?.apply(fontSizeFactor: 1.2),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );;
//   }
// }

