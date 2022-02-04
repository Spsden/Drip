import 'dart:convert';
import 'dart:core';


import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:http/http.dart' as http;

import 'albumsdataclass.dart';
import 'artistsdataclass.dart';
import 'communityplaylistdataclass.dart';

class SearchMusic {
 // static const String serverAddress = 'http://127.0.0.1:5000/';
  //static const String serverAddress = 'http://192.168.0.106:5000/';
  static const String serverAddress = 'http://spden.pythonanywhere.com/';

  // Future<List<Artists>> getArtists(String searchquery) async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

  //     if (response.statusCode == 200) {
  //       var servres = response.body;
  //       var result = jsonDecode(response.body) as Map;

  //       var morefilter = Map.from(result)
  //         ..removeWhere((key, value) =>
  //             key['output']['category'].toString() != 'Artists');

  //       var filtered = jsonEncode(morefilter);

  //       // var jsondec = jsonDecode(response.body) as Map;
  //       // var morefilter = jsondec['output'] as Map;
  //       // var filtered = jsonEncode(morefilter);

  //       print(filtered.toString());
  //       print('just called');

  //       final List<Artists> artistsearch = ArtistsFromJson(filtered);
  //       return artistsearch;

  //       //var finalfiltered = jsonEncode(outputremove);

  //     } else {
  //       print(response.statusCode.toString());
  //       return <Artists>[];
  //     }
  //   } catch (e) {
  //     print('catchblock');
  //     return <Artists>[];
  //   }
  // }

  static Future getArtists(String searchquery) async {
    final response = await http
        .get(Uri.parse(serverAddress + 'search?query=' + searchquery));

    if (response.statusCode == 200) {
      String responsestring = response.body.toString();
      var servres = json.decode(responsestring) as Map;
      var filtered = jsonEncode(servres['output']);

      var morefilter = jsonDecode(filtered) as List;
      var artistslist = [];
      var albumlist = [];
      var songslist = [];
      //var topresult;
      var communityplaylistlist = [];

      for (var i = 0; i < morefilter.length; i++) {
        var listMap = morefilter[i];
        if ((listMap['category']).toString() == 'Artists') {
          artistslist.add(listMap);
        }
        if ((listMap['category']).toString() == 'Albums') {
          albumlist.add(listMap);
        }
        if ((listMap['category']).toString() == 'Songs') {
          songslist.add(listMap);
        }

        if ((listMap['category']).toString() == 'Top result') {
          // topresult.add(listMap);
          //  topresult = listMap;
        }

        if ((listMap['category']).toString() == 'Community playlists') {
          communityplaylistlist.add(listMap);
        }
      }

      var artistFiltered = jsonEncode(artistslist);
      var albumFiltered = jsonEncode(albumlist);
      var songsFiltered = jsonEncode(songslist);
      // var topresultFiltered = jsonEncode(topresult);
      var communityplaylistFiltered = jsonEncode(communityplaylistlist);



      final List<Artists>? artistsearch = ArtistsFromJson(artistFiltered);
      final List<Songs>? songsearch = songsFromJson(songsFiltered);
      final List<CommunityPlaylist>? communityplaylistsearch =
          communityPlaylistFromJson(communityplaylistFiltered);
      final List<Albums> albumsearch = albumsFromJson(albumFiltered);
      // final Topresults toppresult = topresultsFromJson(topresultFiltered);

      var mapofsearchresults = {
        'artistsearch': artistsearch,
        'songsearch': songsearch,
        'albumsearch': albumsearch,
        'communityplaylistsearch': communityplaylistsearch,
        // 'topresults': toppresult
      };

      // var forsake = artistsearch[0];
      // print(forsake.browseId.toString() + 'HEREEEEEEE');

      // var listofsearchresults = [
      //   artistsearch,
      //   songsearch,
      //   communityplaylistsearch,
      //   albumsearch,
      //   //toppresult
      // ];

      return mapofsearchresults;
      // return listofsearchresults;
    } else {
      // print(response.statusCode.toString());
      return <Artists>[];
    }
  }

  static Future getOnlySongs(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(serverAddress +
        'searchwithfilter?query=' +
        searchquery +
        '&filter=songs&limit=' +
        limit.toString()));

    if (response.statusCode == 200){

      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<Songs> songOnlyResults = songsFromJson(filtered);
     // print(responselist.toString());
     // return Songs.fromJson(jsonDecode(response.body));
     // print(songOnlyResults.toString());
      return songOnlyResults;





    } else {
      return <Songs> [];
    }




  }
}
