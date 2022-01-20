// import 'dart:convert';

// import 'package:drip/datasource/searchresults/artistsdataclass.dart';
// import 'package:drip/datasource/searchresults/communityplaylistdataclass.dart';
// import 'package:drip/datasource/searchresults/songsdataclass.dart';
// import 'package:drip/datasource/searchresults/topresultsdataclass.dart';
// import 'package:http/http.dart' as http;

// class SearchMusic {
//   static const String serverAddress = 'http://127.0.0.1:5000/';

//   // Future<List<Artists>> getArtists(String searchquery) async {
//   //   try {
//   //     final response = await http
//   //         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//   //     if (response.statusCode == 200) {
//   //       var servres = response.body;
//   //       var result = jsonDecode(response.body) as Map;

//   //       var morefilter = Map.from(result)
//   //         ..removeWhere((key, value) =>
//   //             key['output']['category'].toString() != 'Artists');

//   //       var filtered = jsonEncode(morefilter);

//   //       // var jsondec = jsonDecode(response.body) as Map;
//   //       // var morefilter = jsondec['output'] as Map;
//   //       // var filtered = jsonEncode(morefilter);

//   //       print(filtered.toString());
//   //       print('just called');

//   //       final List<Artists> artistsearch = ArtistsFromJson(filtered);
//   //       return artistsearch;

//   //       //var finalfiltered = jsonEncode(outputremove);

//   //     } else {
//   //       print(response.statusCode.toString());
//   //       return <Artists>[];
//   //     }
//   //   } catch (e) {
//   //     print('catchblock');
//   //     return <Artists>[];
//   //   }
//   // }

//   Future<List<Artists>> getArtists(String searchquery) async {
//     final response = await http
//         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//     if (response.statusCode == 200) {
//       String responsestring = response.body.toString();
//       var servres = json.decode(responsestring) as Map;
//       var filtered = jsonEncode(servres['output']);

//       var morefilter = jsonDecode(filtered) as List;
//       var artistslist = [];
//       var artistFiltered = jsonEncode(artistslist);

//       for (var i = 0; i < morefilter.length; i++) {
//         var listMap = morefilter[i];
//         if ((listMap['category']).toString() == 'Artists') {
//           artistslist.add(listMap);
//         }
//       }

//       print(artistslist.toString());

//       var excludeoutput = servres['output'] as List;

//       final List<Artists> artistsearch = ArtistsFromJson(artistFiltered);
//       return artistsearch;
//     } else {
//       print(response.statusCode.toString());
//       return <Artists>[];
//     }
//   }

//   Future getTopresults(String searchquery) async {
//     final response = await http
//         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//     if (response.statusCode == 200) {
//       String responsestring = response.body.toString();
//       var servres = json.decode(responsestring) as Map;
//       var filtered = jsonEncode(servres['output']);

//       var morefilter = jsonDecode(filtered) as List;
//       var artistslist = [];
//       var artistFiltered = jsonEncode(artistslist);

//       for (var i = 0; i < morefilter.length; i++) {
//         var listMap = morefilter[i];
//         if ((listMap['category']).toString() == 'Top result') {
//           artistslist.add(listMap);
//         }
//       }

//       print(artistslist.toString());

//       var excludeoutput = servres['output'] as List;

//       final Topresults artistsearch = topresultsFromJson(artistFiltered);
//       return artistsearch;
//     } else {
//       print(response.statusCode.toString());
//       return null;
//     }
//   }

//   Future<List<Songs>> getSongs(String searchquery) async {
//     final response = await http
//         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//     if (response.statusCode == 200) {
//       String responsestring = response.body.toString();
//       var servres = json.decode(responsestring) as Map;
//       var filtered = jsonEncode(servres['output']);

//       var morefilter = jsonDecode(filtered) as List;
//       var artistslist = [];
//       var artistFiltered = jsonEncode(artistslist);

//       for (var i = 0; i < morefilter.length; i++) {
//         var listMap = morefilter[i];
//         if ((listMap['category']).toString() == 'Songs') {
//           artistslist.add(listMap);
//         }
//       }

//       print(artistslist.toString());

//       var excludeoutput = servres['output'] as List;

//       final List<Songs> artistsearch = songsFromJson(artistFiltered);
//       return artistsearch;
//     } else {
//       print(response.statusCode.toString());
//       return <Songs>[];
//     }
//   }

//   Future<List<CommunityPlaylist>> getCommunityPlaylists(
//       String searchquery) async {
//     final response = await http
//         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//     if (response.statusCode == 200) {
//       String responsestring = response.body.toString();
//       var servres = json.decode(responsestring) as Map;
//       var filtered = jsonEncode(servres['output']);

//       var morefilter = jsonDecode(filtered) as List;
//       var artistslist = [];
//       var artistFiltered = jsonEncode(artistslist);

//       for (var i = 0; i < morefilter.length; i++) {
//         var listMap = morefilter[i];
//         if ((listMap['category']).toString() == 'Songs') {
//           artistslist.add(listMap);
//         }
//       }

//       print(artistslist.toString());

//       var excludeoutput = servres['output'] as List;

//       final List<CommunityPlaylist> artistsearch =
//           communityPlaylistFromJson(artistFiltered);
//       return artistsearch;
//     } else {
//       print(response.statusCode.toString());
//       return <CommunityPlaylist>[];
//     }
//   }

//   // Future<List<CommunityPlaylist>> getCommunityPlaylists(
//   //     String searchquery) async {
//   //   final response = await http
//   //       .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

//   //   if (response.statusCode == 200) {
//   //     String responsestring = response.body.toString();
//   //     var servres = json.decode(responsestring) as Map;
//   //     var filtered = jsonEncode(servres['output']);

//   //     var morefilter = jsonDecode(filtered) as List;
//   //     var artistslist = [];
//   //     var artistFiltered = jsonEncode(artistslist);

//   //     for (var i = 0; i < morefilter.length; i++) {
//   //       var listMap = morefilter[i];
//   //       if ((listMap['category']).toString() == 'Songs') {
//   //         artistslist.add(listMap);
//   //       }
//   //     }

//   //     print(artistslist.toString());

//   //     var excludeoutput = servres['output'] as List;

//   //     final List<CommunityPlaylist> artistsearch =
//   //         communityPlaylistFromJson(artistFiltered);
//   //     return artistsearch;
//   //   } else {
//   //     print(response.statusCode.toString());
//   //     return <CommunityPlaylist>[];
//   //   }
//   // }
// }
