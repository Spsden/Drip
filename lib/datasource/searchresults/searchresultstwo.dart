import 'dart:convert';
import 'dart:core';

import 'package:drip/datasource/searchresults/albumsdataclass.dart';
import 'package:drip/datasource/searchresults/artistsdataclass.dart';
import 'package:drip/datasource/searchresults/communityplaylistdataclass.dart';
import 'package:drip/datasource/searchresults/songsdataclass.dart';
import 'package:drip/datasource/searchresults/topresultsdataclass.dart';
import 'package:drip/datasource/spreadclassmodels/modelsnew.dart';
import 'package:http/http.dart' as http;

class SearchMusic {
  static const String serverAddress = 'http://127.0.0.1:5000/';

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
          // topresult = listMap;
        }

        if ((listMap['category']).toString() == 'Community playlists') {
          communityplaylistlist.add(listMap);
        }
      }

      var artistFiltered = jsonEncode(artistslist);
      var albumFiltered = jsonEncode(albumlist);
      var songsFiltered = jsonEncode(songslist);
      //var topresultFiltered = jsonEncode(topresult);
      var communityplaylistFiltered = jsonEncode(communityplaylistlist);

      // for (var i = 0; i < morefilter.length; i++) {
      //   var listMap = morefilter[i];
      //   if ((listMap['category']).toString() == 'Albums') {
      //     albumlist.add(listMap);
      //   }
      // }

      // for (var i = 0; i < morefilter.length; i++) {
      //   var listMap = morefilter[i];
      //   if ((listMap['category']).toString() == 'Songs') {
      //     songslist.add(listMap);
      //   }
      // }

      // for (var i = 0; i < morefilter.length; i++) {
      //   var listMap = morefilter[i];
      //   if ((listMap['category']).toString() == 'Top result') {
      //     topresult.add(listMap);
      //   }
      // }

      // for (var i = 0; i < morefilter.length; i++) {
      //   var listMap = morefilter[i];
      //   if ((listMap['category']).toString() == 'Community playlists') {
      //     communityplaylistlist.add(listMap);
      //   }
      // }

      //print(communityplaylistlist.toString());

      //var excludeoutput = servres['output'] as List;

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
        //'topresults': toppresult
      };

      // var forsake = artistsearch[0];
      // print(forsake.browseId.toString() + 'HEREEEEEEE');

      // var listofsearchresults = [
      //   artistsearch,
      //   songsearch,
      //   communityplaylistsearch,
      //   albumsearch,
      //   toppresult
      // ];

      return mapofsearchresults;
    } else {
      print(response.statusCode.toString());
      return <Artists>[];
    }
  }
}
