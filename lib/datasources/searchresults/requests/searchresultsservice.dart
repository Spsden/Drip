import 'dart:convert';
import 'dart:core';

import 'package:drip/datasources/searchresults/models/artistpagedataclass.dart'
    as artistPage;
import 'package:drip/datasources/searchresults/models/moods_data_class.dart';
import 'package:drip/datasources/searchresults/models/playlist_data_class.dart';
import 'package:drip/datasources/searchresults/models/playlistdataclass.dart';
import 'package:drip/datasources/searchresults/models/songsdataclass.dart'
    as songs;
import 'package:drip/datasources/searchresults/models/videodataclass.dart'
    as videos;
import 'package:drip/datasources/searchresults/models/watchplaylistdataclass.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/albumdataclass.dart';
import '../models/albumsdataclass.dart';
import '../models/artistsdataclass.dart' as artists;
import '../models/communityplaylistdataclass.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchMusic {
  static String serverAddress = dotenv.get('SERVER');

  // 'https://drip-server-fv6tn36q0-spsden.vercel.app/';

  //static const String serverAddress = 'http://192.168.199.131:5000/';

  static Future<Map> getAllSearchResults(String searchQuery) async {
    try {
      final response = await http
          .get(Uri.parse('${serverAddress}search?query=$searchQuery'));

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
        var featuredPlaylistList = [];
        String? topResultType = 'NONE';

        Object? topResult;

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
          if ((listMap['category']).toString() == 'Featured playlists') {
            featuredPlaylistList.add(listMap);
          }

          //  print(songslist);

          try {
            if ((listMap['category']).toString() == 'Top result') {
              //print(listMap['resultType']);
              print(jsonEncode(listMap));
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
                  topResult = videos.videoFromJson(jsonEncode(listMap));
                  topResultType = 'video';

                  break;
                case 'song':
                  topResult = songs.songFromJson(jsonEncode(listMap));
                  topResultType = 'song';

                  break;
                case 'playlist':
                  topResult = oneCommunityPlaylistFromJson(jsonEncode(listMap));
                  topResultType = 'playlist';
                  break;
              }
            }
          } catch (e) {
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
        var featuredPlaylist = jsonEncode(featuredPlaylistList);

        //print(artistFiltered);

        final List<artists.Artists> artistSearch =
            artists.ArtistsFromJson(artistFiltered);
        final List<songs.Songs> songSearch = songs.songsFromJson(songsFiltered);
        final List<CommunityPlaylist> communityPlaylistSearch =
            communityPlaylistFromJson(communityPlaylistFiltered);
        final List<Albums> albumSearch = albumsFromJson(albumFiltered);
        final List<videos.Video> videoSearch =
            videos.videosFromJson(videosFiltered);
        final List<CommunityPlaylist> featuredPlaylistSearch =
            communityPlaylistFromJson(featuredPlaylist);

        var mapOfSearchResults = {
          'artistSearch': artistSearch,
          'songSearch': songSearch,
          'albumSearch': albumSearch,
          'featuredPlayListSearch': featuredPlaylistSearch,
          'communityPlaylistSearch': communityPlaylistSearch,
          'videoSearch': videoSearch,
          'topResults': topResult,
          'topResultType': topResultType
        };
        print(topResultType);
        print(topResult.toString());

        return mapOfSearchResults;
      } else {
        return {};
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return {};
    }
  }

  static Future getOnlySongs(String searchQuery, int pageNum) async {
    try {
      final response = await http.get(Uri.parse(
          '${serverAddress}searchwithfilter?query=$searchQuery&filter=songs&pageNum=$pageNum'));

      if (response.statusCode == 200) {
        var responseList = jsonDecode(response.body) as List;
        var filtered = jsonEncode(responseList);

        final List<songs.Songs> songOnlyResults = songs.songsFromJson(filtered);

        return songOnlyResults;
      } else {
        return null;

        // <songs.Songs>[];
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e from getOnlySongs");
      }
      return [];
    }
  }

  static Future getOnlyArtists(String searchQuery, int pageNum) async {
    //int numOfResults = 30;

    final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$searchQuery&filter=artists&pageNum=$pageNum&limit=5'));

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

  static Future<AlbumDataClass?> getAlbum(String albumId) async {
    final response = await http.get(
        Uri.parse("http://127.0.0.1:5000/albums?browseid=${albumId}"));
    try {
      if (response.statusCode == 200) {
        final AlbumDataClass albumDataClass =
            AlbumDataClass.fromJson(jsonDecode(response.body));
        // print(albumDataClass.output?.title);
       // print(response.body);

        return albumDataClass;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
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
        var rawResponse = response.body;

        // print(rawResponse);

        final List<PlaylistDataClass> moodPlaylists =
            playlistDataClassFromJson(rawResponse);

        return moodPlaylists;
      } else {
        return [response.statusCode];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
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
