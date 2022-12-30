// import 'package:drip/datasources/searchresults/search_results_model.dart';
// import 'package:fluent_ui/fluent_ui.dart';
//
// import 'package:provider/provider.dart';
//
// import '../../datasources/audiofiles/activeaudiodata.dart';
// import '../../datasources/audiofiles/audiocontrolcentre.dart';
// import '../../datasources/searchresults/artistsdataclass.dart' as artdataclass;
// import '../../theme.dart';
// import '../common/track_cards.dart';
// import 'artistsresultwidget.dart';
//
// class TopResultsWidget extends StatelessWidget {
//   const TopResultsWidget({Key? key, required this.topResult}) : super(key: key);
//   final TopResult? topResult;
//
//   @override
//   Widget build(BuildContext context) {
//     Typography typography = FluentTheme.of(context).typography;
//     const spacer = SizedBox(height: 10.0);
//     const biggerSpacer = SizedBox(height: 40.0);
//     final Widget topResultWidget;
//
//
//
//     switch (topResult?.type) {
//       case 'video':
//         // topResultWidget = Container(
//         //   margin: const EdgeInsets.only(left: 20, right: 20),
//         //   child: TrackCardLarge(
//         //       data: TrackCardData(
//         //           duration: topResult.duration,
//         //           album: '',
//         //           title: topResult.title,
//         //           artist: '${topResult.artists.first.name}',
//         //           thumbnail: topResult.thumbnails.first.url.toString()),
//         //       songIndex: 0,
//         //       onTrackTap: () async {
//         //         var audioUrl = await AudioControlClass.getAudioUri(
//         //             topResult.videoId.toString());
//         //         // print(audioUrl.toString());
//         //
//         //         //playerAlerts.buffering = true;
//         //         await context.read<ActiveAudioData>().songDetails(
//         //             audioUrl,
//         //             topResult.videoId.toString(),
//         //             topResult.artists[0].name,
//         //             topResult.title.toString(),
//         //             topResult.thumbnails[0].url.toString(),
//         //             //  topResult.thumbnails.map((e) => ThumbnailLocal(height: e.height, url: e.url.toString(), width: e.width)).toList(),
//         //             topResult.thumbnails.last.url.toString());
//         //         currentMediaIndex = 0;
//         //
//         //         // await AudioControlClass.play(
//         //         //     audioUrl: audioUrl,
//         //         //     videoId:
//         //         //     topResult.videoId.toString(),
//         //         //     context: context);
//         //       },
//         //       color: context.watch<AppTheme>().mode == ThemeMode.dark ||
//         //               context.watch<AppTheme>().mode == ThemeMode.system
//         //           ? Colors.grey[150]
//         //           : Colors.grey[30],
//         //       SuperSize: MediaQuery.of(context).size,
//         //       fromQueue: false),
//         // );
//         break;
//
//       case 'Artist':
//         return ArtistCard(
//             artists: artdataclass.Artists(
//                 artist: topResult?.content.first.title,
//                 browseId: topResult?.content.first.browseId,
//                 radioId: "Null",
//                 category: "Artists",
//                 resultType: "artist",
//                 shuffleId: "null",
//                 subscribers: topResult?.content.first.subscribers,
//                 thumbnails: List<artdataclass.Thumbnail>.from( topResult!.content.first.thumbnails
//                     .map((thumb) => artdataclass.Thumbnail(
//                     height: thumb.height,
//
//                     width: thumb.width,
//                     url: thumb.url)).toList())
//
//
//
//
//                ));
//         break;
//
//       default:
//         return const Text('lol');
//         break;
//     }
//
//     return SizedBox(
//
//         //  height: 260,
//         //color: Colors.green,
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Top Results",
//             style: typography.subtitle?.apply(fontSizeFactor: 1.0),
//           ),
//         ],
//       ),
//       spacer,
//      // topResultWidget
//     ]));
//   }
// }
