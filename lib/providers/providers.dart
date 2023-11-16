
import 'package:drip/datasources/searchresults/models/songsdataclass.dart';
import 'package:drip/datasources/searchresults/requests/youtubehomedata.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/searchresults/models/artistsdataclass.dart';
import '../datasources/searchresults/requests/searchresultsservice.dart';

final searchQueryProvider = StateProvider((ref) => '');

final artistsListResultsProvider =
    FutureProvider.family((ref, int pageNum) async {
  final List<Artists> newItems =
      await SearchMusic.getOnlyArtists(ref.watch(searchQueryProvider), pageNum);
  return newItems;
});

final songsListResultsProvider =
    FutureProvider.family((ref, int pageNum) async {
  final List<Songs> newItems =
      await SearchMusic.getOnlySongs(ref.watch(searchQueryProvider), pageNum);
  return newItems;
});

final searchResultsProvider = FutureProvider.autoDispose<Map>((ref) async {
  final result =
      await SearchMusic.getAllSearchResults(ref.watch(searchQueryProvider));
  //print(result['songSearch']);
  if (kDebugMode) {
    print('fetched');
    //print(jsonEncode(res
  }
  return result;
});

final searchSuggestionsProvider = FutureProvider.autoDispose((ref) async {
  final List suggestions = await ApiYouTube()
      .searchSuggestions(searchQuery: ref.watch(searchQueryProvider));
  return suggestions;
});

final currentPageIndexProvider = StateProvider((ref) => 0);

// class NowPlayingPalette extends StateNotifier<Color> {
//   NowPlayingPalette(this.ref) : super(Colors.transparent);
//
//   final Ref ref;
//
//   // ref.watch(audioPlayerProvider).
//
//   Future<void> updatePalette(String imgUrl) async {
//     PaletteGenerator paletteGenerator;
//     paletteGenerator = await PaletteGenerator.fromImageProvider(
//         ExtendedNetworkImageProvider(imgUrl));
//     Color dominantColor =
//         paletteGenerator.dominantColor?.color ?? Colors.transparent;
//
//     if (dominantColor.computeLuminance() > 0.6) {
//       Color contrastColor =
//           paletteGenerator.darkMutedColor?.color ?? Colors.black;
//       if (dominantColor == contrastColor) {
//         contrastColor = paletteGenerator.lightMutedColor?.color ?? Colors.white;
//       }
//       if (contrastColor.computeLuminance() < 0.6) {
//         dominantColor = contrastColor;
//       }
//     }
//
//     state = dominantColor;
//     //return dominantColor;
//   }
// }
//
// final nowPlayingPaletteProvider =
//     StateNotifierProvider.autoDispose<NowPlayingPalette, Color>((ref) {
//   return NowPlayingPalette(ref);
// });
