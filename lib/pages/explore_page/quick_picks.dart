import 'dart:convert';
import 'dart:math';

import 'package:drip/datasources/searchresults/models/youtubehome/drip_home_page/content.dart';
import 'package:drip/datasources/searchresults/models/youtubehome/drip_home_page/drip_home_page.dart';
import 'package:drip/datasources/searchresults/models/youtubehome/drip_home_page/output.dart';
import 'package:drip/pages/common/track_cards.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:known_extents_list_view_builder/sliver_known_extents_list.dart';

import '../../datasources/audiofiles/activeaudiodata.dart';
import '../../datasources/searchresults/requests/youtubehomedata.dart';
import '../../providers/audio_player_provider.dart';

// class QuickPicks extends StatefulWidget {
//   const QuickPicks({super.key});
//
//   @override
//   State<QuickPicks> createState() => _QuickPicksState();
// }
//
// class _QuickPicksState extends State<QuickPicks> {
//   late Future<List> quickPicks;
//
//   @override
//   void initState() {
//     super.initState();
//
//     quickPicks = ApiYouTube().getQuickPicks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List>(
//         future: quickPicks,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//
//
//               itemCount: snapshot.data!.length ~/ 4,
//
//               itemBuilder: ((context, index) {
//
//
//                   int sublistSize = 4;
//
//                   List<List> dividedList = [];
//                   for (int i = 0; i < snapshot.data!.length; i += sublistSize) {
//                     int end = (i + sublistSize < snapshot.data!.length) ? i + sublistSize : snapshot.data!.length;
//                     dividedList.add(snapshot.data!.sublist(i, end));
//                   }
//
//
//
//                 return Container(
//                   height: 200,
//                   width: 300,
//                   child: ListView.builder(
//                     itemCount: 4,
//                       scrollDirection: Axis.vertical,
//
//                       itemBuilder: ((context, idx) {
//
//                     return Text("hjgjh");
//                   })),
//                 );
//
//
//               }),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//
//           // By default, show a loading spinner.
//           return const CircularProgressIndicator();
//         });
//   }
// }

// class QuickPicks extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Music Tile Layout',
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Quick Picks'),
//           ),
//           body: Placeholder()
//       ),
//     );
//   }
// }

List<List<Content>> converter(List<Content> songs) {
  int sublistSize = 4;

  List<List<Content>> listOfLists = [];

  for (int i = 0; i < songs.length; i += sublistSize) {
    int endIndex = i + sublistSize;
    if (endIndex > songs.length) {
      endIndex = songs.length;
    }
    List<Content> sublist = songs.sublist(i, endIndex);
    listOfLists.add(sublist);
  }
  return listOfLists;
}

class QuickPicks extends StatelessWidget {
  const QuickPicks({super.key, required this.songs});

  final List<List<Content>> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SizedBox(
            //height: 350,
            width: MediaQuery.of(context).size.width/3.4,

            child: FourQuickPics(data: songs[index]),
          ),
        );
      },
    );
  }
}

class FourQuickPics extends ConsumerWidget {
  const FourQuickPics({super.key, required this.data});

  final List<Content> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: 4,
        physics: NeverScrollableScrollPhysics(),

        itemBuilder: ((context, index) {
          final TrackCardData trackData = TrackCardData(
              title: data[index].title,
              thumbnail: data[index].thumbnails?.first.url,
              artist: data[index].artists?.join(" "),
              album: data[index].album?.name,
              duration: "na");
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              onTap: () {},
              child: TrackCardSmall(
                data: trackData,
                color: Colors.lightBlue,
                onTrackTap: () {
                  CurrentMusicInstance currentMusicInstance =
                      CurrentMusicInstance(
                          title: trackData.title.toString(),
                          author: data[index]
                                  .artists
                                  ?.map((artist) => artist.name.toString())
                                  .toList() ??
                              [],
                          thumbs: data[index]
                                  .thumbnails
                                  ?.map((thumb) => thumb.url.toString())
                                  .toList() ??
                              [],
                          urlOfVideo: 'NA',
                          videoId: data[index].videoId.toString());

                  ref.read(audioPlayerProvider).open(currentMusicInstance);
                },
              ),
            ),
          );
        }));
  }
}

List<TrackCardData> generateRandomTrackDataList(int count) {
  final List<String> thumbnails = [
    'thumbnail1.jpg',
    'thumbnail2.jpg',
    'thumbnail3.jpg',
  ];

  final List<String> titles = [
    'Song Adsfsdjf',
    'Song Bsdjfksfdjkjksdj',
    'Song C'
  ];
  final List<String> artists = ['Artist X', 'Artist Y', 'Artist Z'];
  final List<String> albums = ['Album 1', 'Album 2', 'Album 3'];

  final Random random = Random();

  final List<TrackCardData> trackList = [];

  for (int i = 0; i < count; i++) {
    final int thumbnailIndex = random.nextInt(thumbnails.length);
    final int titleIndex = random.nextInt(titles.length);
    final int artistIndex = random.nextInt(artists.length);
    final int albumIndex = random.nextInt(albums.length);

    final String duration = '${random.nextInt(5)}:${random.nextInt(60)}';

    final trackData = TrackCardData(
      title: titles[titleIndex],
      thumbnail: thumbnails[thumbnailIndex],
      artist: artists[artistIndex],
      album: albums[albumIndex],
      duration: duration,
    );

    trackList.add(trackData);
  }

  return trackList;
}

//modifying list in a separate isolate
Future<List<List<Content>>> _getModifiedList(List<Content> content) async {
  return compute(converter, content);
}

class Test extends ConsumerWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DripHomePage> dripHome = ref.watch(getHomeProvider);

    return Center(
      child: () {
        if (dripHome is AsyncData) {
          final DripHomePage data = (dripHome as AsyncData).value;
          final List<Output>? fullList = data.output;
          // final listOfQuickPicks =

          return CustomScrollView(
            slivers: [
              SliverKnownExtentsList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: fullList!.length - 1, (context, index) {
                    final Output currentOutput = fullList[index];
                    final String? currentOutputTitle = currentOutput.title;
                    if (currentOutputTitle == "Quick picks") {
                      final List<List<Content>> quickPicks =
                          converter(currentOutput.contents ?? []);
                      return FutureBuilder(
                        future: _getModifiedList(currentOutput.contents ?? []),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return QuickPicks(
                                songs: snapshot.data as List<List<Content>>);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );

                      Text(jsonEncode(currentOutput.contents));
                    } else
                      return Stack(
                        children: [
                          Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 7, 0, 5),
                                  child: Text('${currentOutput.title}'),
                                )
                              ],
                            )
                          ])
                        ],
                      );
                  }),
                  itemExtents:
                      List.generate(fullList!.length, (index) => 344.0)

              ),
            ],
          );
          return Text(jsonEncode(fullList));
        } else if (dripHome is AsyncError) {
          return const Text('Oops, something unexpected happened');
        } else {
          return const CircularProgressIndicator();
        }
      }(),
    );
  }
}
