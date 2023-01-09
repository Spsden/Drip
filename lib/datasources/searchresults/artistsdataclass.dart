// // To parse this JSON data, do
// //
// //     final searchresults = searchresultsFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// List<Artists>? ArtistsFromJson(String str) =>
//     List<Artists>.from(json.decode(str).map((x) => Artists.fromJson(x)));
//
// String ArtistsToJson(List<Artists> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Artists {
//   Artists({
//     required this.artist,
//     required this.browseId,
//     required this.category,
//     required this.radioId,
//     required this.resultType,
//     required this.shuffleId,
//     required this.thumbnails,
//   });
//
//   String? artist;
//   String? browseId;
//   String? category;
//   String? radioId;
//   String? resultType;
//   String? shuffleId;
//   List<Thumbnail> thumbnails;
//
//   factory Artists.fromJson(Map<String?, dynamic> json) => Artists(
//       artist: json["artist"],
//       browseId: json["browseId"],
//       category: json["category"],
//       radioId: json["radioId"],
//       resultType: json["resultType"],
//       shuffleId: json["shuffleId"],
//       thumbnails: List<Thumbnail>.from(
//           json["thumbnails"].Artistsmap((x) => Thumbnail.fromJson(x))));
//
//   Map<String, dynamic> toJson() => {
//         "artist": artist,
//         "browseId": browseId,
//         "category": category,
//         "radioId": radioId,
//         "resultType": resultType,
//         "shuffleId": shuffleId,
//         "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
//       };
// }
//
// class Thumbnail {
//   Thumbnail({
//     this.height,
//     this.url,
//     this.width,
//   });
//
//   int? height;
//   String? url;
//   int? width;
//
//   factory Thumbnail.fromJson(Map<String?, dynamic> json) => Thumbnail(
//         height: json["height"],
//         url: json["url"],
//         width: json["width"],
//       );
//
//   Map<String?, dynamic> toJson() => {
//         "height": height,
//         "url": url,
//         "width": width,
//       };
// }


// To parse this JSON data, do
//
//     final artists = artistsFromJson(jsonString);

import 'dart:convert';
Artists artistFromJson(String str) => Artists.fromJson(jsonDecode(str));
List<Artists> ArtistsFromJson(String str) => List<Artists>.from(json.decode(str).map((x) => Artists.fromJson(x)));

String artistsToJson(List<Artists> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Artists {
  Artists(  {
    required this.artist,
    required this.browseId,
    required this.category,
    required this.radioId,
    required this.resultType,
    required this.shuffleId,
    required this.thumbnails,
    required this.subscribers

  });

  final String? artist;
  final String? browseId;
  final String? category;
  final String? radioId;
  final String? resultType;
  final String? shuffleId;
  final String? subscribers;

  final List<Thumbnail>? thumbnails;

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
    artist: json["artist"],
    browseId: json["browseId"],
    category: json["category"],
    radioId: json["radioId"],
    resultType: json["resultType"],
    shuffleId: json["shuffleId"],

    thumbnails: json["thumbnails"] == null ? null : List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))), subscribers: '',

  );

  Map<String, dynamic> toJson() => {
    "artist": artist,
    "browseId": browseId,
    "category": category,
    "radioId": radioId,
    "resultType": resultType,
    "shuffleId": shuffleId,
    "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
  };
}

class Thumbnail {
  Thumbnail({
    required this.height,
    required this.url,
    required this.width,
  });

  final int height;
  final String url;
  final int width;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
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

