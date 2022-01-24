// import 'dart:convert';
// import 'dart:core';
//
// import 'package:drip/datasource/spreadclassmodels/modelsnew.dart';
// import 'package:http/http.dart' as http;
//
// class SearchService {
//   static const String serverAddress = 'http://127.0.0.1:5000/';
//
//   Future<List<Searchresults>> getSearchResults(String searchquery) async {
//     try {
//       final response = await http
//           .get(Uri.parse(serverAddress + 'search?query=' + searchquery));
//
//       if (response.statusCode == 200) {
//         var jsondec = jsonDecode(response.body) as Map;
//         var morefilter = jsondec['output'];
//         var filtered = jsonEncode(morefilter);
//
//         //var filtered = result[]
//
//         print(filtered.toString());
//         // print(result.toString());
//
//         final List<Searchresults> searchresults =
//             searchresultsFromJson(filtered);
//         return searchresults;
//         //print(Searchresults.from)
//       } else {
//         return <Searchresults>[];
//       }
//     } catch (e) {
//       return <Searchresults>[];
//     }
//   }
//
//   // Future<List<Searchresults>> getSearchResults(String searchquery) async {
//   //   try {
//   //     final response = await http
//   //         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));
//
//   //     if (response.statusCode == 200) {
//   //       var result = response.body;
//   //       var jsondec = jsonDecode(response.body) as Map;
//   //       var morefilter = jsondec['output'] as Map;
//   //       var filtered = jsonEncode(morefilter);
//
//   //       //var filtered = result[]
//
//   //       print(filtered.toString());
//   //       print(result.toString());
//   //       print('lol');
//
//   //       final List<Searchresults> searchresults =
//   //           searchresultsFromJson(filtered);
//   //       // print(searchresults.toString());
//   //       return searchresults;
//   //       //print(Searchresults.from)
//   //     } else {
//   //       return <Searchresults>[];
//   //     }
//   //   } catch (e) {
//   //     return <Searchresults>[];
//   //   }
//   // }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // // class SearchApi {
// // //   //SearchApi._instantiate();
//
// // //   // static final SearchApi instance = SearchApi._instantiate();
//
// // //   final serverAddress = 'http://127.0.0.1:5000/';
// // //   //String _nextPageToken;
//
// // //   Future fetchSearch({required String searchquery}) async {
// // //     http.Response response = await http
// // //         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));
//
// // //     if (response.statusCode != 200) {
// // //       print(response.statusCode);
//
// // //       //Map<String, dynamic> data = json.decode(response.body)
// // //     } else {
// // //       String data = response.body;
// // //       List<Map<String, dynamic>> mappeddata = jsonDecode(response.body);
//
// // //       //var TopResultFilter = List();
//
// // //       mappeddata.removeWhere((element) =>
// // //           element['output']['category'].toString() != 'Top result');
//
// // //       print(mappeddata.toString());
//
// // //       // var item;
// // //       // for (item in data) {
// // //       //   if (item['output']['category'] != 'Top result') {
// // //       //     TopResultFilter.add(item);
// // //       //   }
// // //       // }
//
// // //       //  setState(() {
//
// // //       //  })
//
// // //       // String forprint = filteredMap.toString();
// // //       // print(forprint);
//
// // //       // String letsprint = mappeddata.toString();
// // //       // print(letsprint);
// // //     }
// // //   }
// // // }
