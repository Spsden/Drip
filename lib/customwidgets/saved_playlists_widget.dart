import 'package:drip/providers/providers.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image_url =
        "https://i0.wp.com/99lyricstore.com/wp-content/uploads/2022/11/Apna-Bana-Le-Lyrics-Arijit-Singh.jpg";

    return Container(
      height: 500,
      width: 400,
      //margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: fluent.FluentTheme.of(context)
            .resources
            .cardBackgroundFillColorDefault,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Center(
                // height: 200,
                child: Image.network(
                  image_url,
                  height: 50,
                ),
              ),
              // Center(
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "10 Pops Music",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "YouTube Music 92 songs ",
                      style: TextStyle(fontSize: 15),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              // )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Relive some of the biggest pop song of the 2010s",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Image.network(
                  image_url,
                  width: 70,
                ),
                title: Text("Apna Bana Le"),
                subtitle: Text("Arijit Singh"),
                trailing: const Icon(Icons.more_vert),
                tileColor: Colors.green,
                onTap: () {},
              ),
              ListTile(
                leading: Image.network(
                  image_url,
                  width: 70,
                ),
                title: Text("Apna Bana Le"),
                subtitle: Text("Arijit Singh"),
                trailing: const Icon(Icons.more_vert),
                onTap: () {},
              ),
              ListTile(
                leading: Image.network(
                  image_url,
                  width: 70,
                ),
                title: Text("Apna Bana Le"),
                subtitle: Text("Arijit Singh"),
                trailing: const Icon(Icons.more_vert),
                onTap: () {},
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          minimumSize: const Size(50, 50)),
                      child: const Icon(Icons.play_arrow_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          minimumSize: const Size(50, 50)),
                      child: const Icon(Icons.delete),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
