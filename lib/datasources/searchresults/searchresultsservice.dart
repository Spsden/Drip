import 'dart:convert';
import 'dart:core';

import 'package:drip/datasources/searchresults/artistpagedataclass.dart'
    as artistPage;
import 'package:drip/datasources/searchresults/moods_data_class.dart';
import 'package:drip/datasources/searchresults/playlist_data_class.dart';
import 'package:drip/datasources/searchresults/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart' as songs;
import 'package:drip/datasources/searchresults/videodataclass.dart' as videos;
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'albumsdataclass.dart';
import 'artistsdataclass.dart' as artists;
import 'communityplaylistdataclass.dart';

class SearchMusic {
  //static const String serverAddress = 'http://spden.pythonanywhere.com/';
  //static const String serverAddress = 'https://dripapi.vercel.app/';

   static const String serverAddress = 'http://192.168.199.131:5000/';

  static  Future<Map>  getAllSearchResults(String searchquery) async {
    try {
      final response = await http
          .get(Uri.parse('${serverAddress}search?query=$searchquery'));

      if (response.statusCode == 200) {
        String responsestring = response.body.toString();
        var servres = json.decode(responsestring) as Map;
        var filtered = jsonEncode(servres['output']);

        var morefilter = jsonDecode(filtered) as List;

        var artistslist = [];
        var albumlist = [];
        var songslist = [];
        var communityPlaylistList = [];
        var videosList = [];
        String? topResultType = 'NONE';


        Object? topResult = 'Lol';



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
          if ((listMap['category']).toString() == 'Community playlists') {
            communityPlaylistList.add(listMap);
          }
          if ((listMap['category']).toString() == 'Videos') {
            videosList.add(listMap);
          }

          try{
            if ((listMap['category']).toString() == 'Top result') {
              switch (listMap['resultType'] as String) {
                case 'artist':
                  topResult = artists.artistFromJson(jsonEncode(listMap));
                  topResultType = 'artist';
                  break;

                case 'album':
                  topResult = albumFromJson(jsonEncode(listMap));
                  topResultType = 'album';

                  break;

                case 'video':
                  topResult =
                      videos.videoFromJson(jsonEncode(listMap));
                  topResultType = 'video';

                  break;
                case 'song':
                  topResult = songs.songFromJson(jsonEncode(listMap));
                  topResultType = 'song';

                  break;
              }


            }

          } catch (e){
            if (kDebugMode) {
              print('$e topResultsException');
            }
          }


        }

        var artistFiltered = jsonEncode(artistslist);
        var albumFiltered = jsonEncode(albumlist);
        var songsFiltered = jsonEncode(songslist);
        // var topresultFiltered = jsonEncode(topResult);
        var communityPlaylistFiltered = jsonEncode(communityPlaylistList);
        var videosFiltered = jsonEncode(videosList);

        //print(artistFiltered);

        final List<artists.Artists> artistSearch =
            artists.ArtistsFromJson(artistFiltered);
        final List<songs.Songs> songSearch = songs.songsFromJson(songsFiltered);
        final List<CommunityPlaylist> communityPlaylistSearch =
            communityPlaylistFromJson(communityPlaylistFiltered);
        final List<Albums> albumSearch = albumsFromJson(albumFiltered);
        final List<videos.Video> videoSearch =
            videos.videosFromJson(videosFiltered);
        // final Topresults toppresult = topresultsFromJson(topresultFiltered);

        var mapOfSearchResults = {
          'artistSearch': artistSearch,
          'songSearch': songSearch,
          'albumSearch': albumSearch,
          'communityPlaylistSearch': communityPlaylistSearch,
          'videoSearch': videoSearch,
          'topResults': topResult,
          'topResultType': topResultType
        };

        return mapOfSearchResults;
        // return listofsearchresults;
      } else {
        // print(response.statusCode.toString());
        return {};
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());

      }return{};
    }
  }

  static Future getOnlySongs(String searchquery, int limit) async {
    final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$searchquery&filter=songs&limit=$limit'));

    if (response.statusCode == 200) {
      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<songs.Songs> songOnlyResults = songs.songsFromJson(filtered);

      return songOnlyResults;
    } else {
      return <songs.Songs>[];
    }
  }

  static Future getOnlyArtists(String searchquery, int pageNum) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$searchquery&filter=artists&pageNum=$pageNum'));

    if (response.statusCode == 200) {
      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<artists.Artists> songOnlyResults =
          artists.ArtistsFromJson(filtered);
      return songOnlyResults;
    } else {
      return <artists.Artists>[];
    }
  }

  static Future getOnlyAlbums(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$searchquery&filter=albums&limit=$limit'));

    if (response.statusCode == 200) {
      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<Albums> songOnlyResults = albumsFromJson(filtered);
      // print(responselist.toString());
      // return Songs.fromJson(jsonDecode(response.body));
      // print(songOnlyResults.toString());
      return songOnlyResults;
    } else {
      return <Albums>[];
    }
  }

  static Future getOnlyCommunityPlaylists(String searchquery, int limit) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$searchquery&filter=community_playlists&limit=$limit'));

    if (response.statusCode == 200) {
      var responselist = jsonDecode(response.body) as List;
      var filtered = jsonEncode(responselist);

      final List<CommunityPlaylist> songOnlyResults =
          communityPlaylistFromJson(filtered);
      // print(responselist.toString());
      // return Songs.fromJson(jsonDecode(response.body));
      // print(songOnlyResults.toString());
      return songOnlyResults;
    } else {
      return <CommunityPlaylist>[];
    }
  }

  static Future getWatchPlaylist(String videoId, int limit) async {
    final response = await http.get(Uri.parse(
        '${serverAddress}searchwatchplaylist?videoId=$videoId&limit=$limit'));

    try {
      if (response.statusCode == 200) {
        var rawResponse = response.body.toString();

        // print(tracks.toString());
        final WatchPlaylists watchPlaylists =
            watchPlaylistsFromJson(rawResponse);
        //print(watchPlaylists.tracks?.length);
        return watchPlaylists;
      } else {
        //print(response.statusCode.toString());
      }
    } catch (e) {
      //print(e.toString());

    }
  }

  static Future getPlaylist(String playlistId, int limit) async {
    final response = await http.get(Uri.parse(
        '${serverAddress}searchplaylist?playlistId=$playlistId&limit=$limit'));

    try {
      if (response.statusCode == 200) {
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
    final response = await http
        .get(Uri.parse('${serverAddress}artist?channelid=$channelId'));

    try {
      if (response.statusCode == 200) {
        var rawResponse = response.body.toString();

        //print(rawResponse);

        final artistPage.ArtistsPageData artistsPage =
            artistPage.artistsPageDataFromJson(rawResponse);
        //print(artistsPage.name.toString());
        return artistsPage;
      } else {
        //print(response.statusCode.toString());
      }
    } catch (e) {
      //print(e.toString());

    }
  }

  static Future getMoods() async {
    final response = await http.get(Uri.parse('${serverAddress}moodcat'));

    try {
      if (response.statusCode == 200) {
        var rawResponse = response.body.toString();

        //  print(rawResponse);

        final MoodsCategories moodsCategories =
            moodsCategoriesFromJson(rawResponse);
        //print(artistsPage.name.toString());
        return moodsCategories;
      } else {
        //print(response.statusCode.toString());
      }
    } catch (e) {
      //print(e.toString());

    }
  }

  static Future getMoodPlaylists(String params) async {
    final response = await http
        .get(Uri.parse('${serverAddress}moodplaylist?params=$params'));

    try {
      if (response.statusCode == 200) {
        var rawResponse = response.body.toString();

        final List<PlaylistDataClass> moodPlaylists =
            playlistDataClassFromJson(rawResponse);

        return moodPlaylists;
      } else {}
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
        height: json["height"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
      };
}
