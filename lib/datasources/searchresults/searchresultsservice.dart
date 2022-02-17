import 'dart:convert';
import 'dart:core';


import 'package:drip/datasources/searchresults/artistpagedataclass.dart' as artistPage;
import 'package:drip/datasources/searchresults/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart' as songs;
import 'package:drip/datasources/searchresults/videodataclass.dart' as videos;
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
import 'package:http/http.dart' as http;

import 'albumsdataclass.dart';
import 'artistsdataclass.dart' as artists;
import 'communityplaylistdataclass.dart';

class SearchMusic {
 // static const String serverAddress = 'http://127.0.0.1:5000/';
  //static const String serverAddress = 'http://192.168.0.106:5000/';
  static const String serverAddress = 'http://spden.pythonanywhere.com/';


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

     // List topResult = [];
      var topResult;



      // var topResultVideo = [];
      // var topResultArtist = [];
      // var topResultAlbum = [];
      // var topResultSong= [];
      // var topResultPlaylist = [];

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

          switch (listMap['resultType'] as String) {
            case 'artist' :




          topResult = artists.Artists(artist: listMap['artist'] ,
              browseId: listMap['browseId'],
              category: listMap['category'],
              radioId: listMap['radioId'],
              resultType: listMap['resultType'],
              shuffleId: listMap['shuffleId'],
              thumbnails: listMap["thumbnails"] == null ? null : List<artists.Thumbnail>.from(listMap["thumbnails"].map((x) => artists.Thumbnail.fromJson(x))),
          );
          break;

            case 'album' :

             // topResult = albumsFromJson(jsonEncode(listMap.toString()));
              topResult = Albums(
                  artists: [] ,
                  browseId: listMap['browseId'],
                  category: listMap['category'],
                 title: listMap['title'],
                  resultType: listMap['resultType'],

                  thumbnails: [], duration: '', isExplicit: listMap['isExplicit'], type: listMap['type'], year: listMap['year']

              );

              break;

            case ''
                'video' :

            // topResult = albumsFromJson(jsonEncode(listMap.toString()));
              topResult = videos.videoFromJson(jsonEncode(listMap).toString());

              break;
          }
          //print(topResult.toString());

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

      //print(artistFiltered);



      final List<artists.Artists>? artistsearch = artists.ArtistsFromJson(artistFiltered);
      final List<songs.Songs>? songsearch = songs.songsFromJson(songsFiltered);
      final List<CommunityPlaylist>? communityplaylistsearch =
          communityPlaylistFromJson(communityplaylistFiltered);
      final List<Albums> albumsearch = albumsFromJson(albumFiltered);
      // final Topresults toppresult = topresultsFromJson(topresultFiltered);

      var mapofsearchresults = {
        'artistsearch': artistsearch,
        'songsearch': songsearch,
        'albumsearch': albumsearch,
        'communityplaylistsearch': communityplaylistsearch,
         'topresults': topResult
      };


      return mapofsearchresults;
      // return listofsearchresults;
    } else {
      // print(response.statusCode.toString());
      return <artists.Artists>[];
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

      final List<songs.Songs> songOnlyResults = songs.songsFromJson(filtered);
     // print(responselist.toString());
     // return Songs.fromJson(jsonDecode(response.body));
     // print(songOnlyResults.toString());
      return songOnlyResults;





    } else {
      return <songs.Songs> [];
    }
  }

  static Future getOnlyArtists(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(serverAddress +
        'searchwithfilter?query=' +
        searchquery +
        '&filter=artists&limit=' +
        limit.toString()));

    if (response.statusCode == 200){

      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<artists.Artists>? songOnlyResults = artists.ArtistsFromJson(filtered);
      // print(responselist.toString());
      // return Songs.fromJson(jsonDecode(response.body));
      // print(songOnlyResults.toString());
      return songOnlyResults;





    } else {
      return <artists.Artists> [];
    }
  }

  static Future getOnlyAlbums(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(serverAddress +
        'searchwithfilter?query=' +
        searchquery +
        '&filter=albums&limit=' +
        limit.toString()));

    if (response.statusCode == 200){

      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<Albums>? songOnlyResults = albumsFromJson(filtered);
      // print(responselist.toString());
      // return Songs.fromJson(jsonDecode(response.body));
      // print(songOnlyResults.toString());
      return songOnlyResults;





    } else {
      return <Albums> [];
    }
  }

  static Future getOnlyCommunityPlaylists(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(serverAddress +
        'searchwithfilter?query=' +
        searchquery +
        '&filter=community_playlists&limit=' +
        limit.toString()));

    if (response.statusCode == 200){

      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<CommunityPlaylist>? songOnlyResults = communityPlaylistFromJson(filtered);
      // print(responselist.toString());
      // return Songs.fromJson(jsonDecode(response.body));
      // print(songOnlyResults.toString());
      return songOnlyResults;





    } else {
      return <songs.Songs> [];
    }
  }




















  static Future getWatchPlaylist(String videoId,int limit) async {
    final response = await http.get(Uri.parse(serverAddress + 'searchwatchplaylist?videoId=' + videoId + '&limit=' + limit.toString()));


  try {
    if (response.statusCode == 200) {
      var rawResponse = response.body.toString();



      // print(tracks.toString());
      final WatchPlaylists watchPlaylists = watchPlaylistsFromJson(rawResponse);
      //print(watchPlaylists.tracks?.length);
      return watchPlaylists;



    } else {
      //print(response.statusCode.toString());
    }


  } catch (e) {
    //print(e.toString());

  }


  }


  static Future getPlaylist(String playlistId, int limit ) async {

    final response = await http.get(Uri.parse(serverAddress + 'searchplaylist?playlistId=' + playlistId + '&limit=' + limit.toString()));

    try{
      if(response.statusCode == 200){
        var rawResponse = response.body.toString();

        //print(rawResponse);

        final Playlists playlists = playlistsFromJson(rawResponse);
        //print(playlists.tracks?.length);
        return playlists;

      } else {
        //print(response.statusCode.toString());

      }



    } catch (e) {
      //print(e.toString());
    }
  }

  static Future getArtistPage(String channelId) async {
    final response = await http.get(Uri.parse(serverAddress + 'artist?channelid=' + channelId ));

    try {
      if(response.statusCode == 200){
        var rawResponse = response.body.toString();

        //print(rawResponse);

        final artistPage.ArtistsPageData artistsPage  = artistPage.artistsPageDataFromJson(rawResponse);
        //print(artistsPage.name.toString());
        return artistsPage;


      } else {
        //print(response.statusCode.toString());
      }
    } catch (e) {
      //print(e.toString());


    }
  }





}


class ThumbnailLocal {
  ThumbnailLocal({
    required this.height,
    required this.url,
    required this.width,
  });

  final int height;
  final String url;
  final int width;

  factory ThumbnailLocal.fromJson(Map<String, dynamic> json) => ThumbnailLocal(
    height: json["height"] == null ? null : json["height"],
    url: json["url"] == null ? null : json["url"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height == null ? null : height,
    "url": url == null ? null : url,
    "width": width == null ? null : width,
  };
}


