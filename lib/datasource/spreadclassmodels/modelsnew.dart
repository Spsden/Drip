// To parse this JSON data, do
//
//     final searchresults = searchresultsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Searchresults> searchresultsFromJson(String str) =>
    List<Searchresults>.from(
        json.decode(str).map((x) => Searchresults.fromJson(x)));

String searchresultsToJson(List<Searchresults> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Searchresults {
  Searchresults({
    required this.author,
    required this.browseId,
    required this.category,
    required this.itemCount,
    required this.resultType,
    required this.thumbnails,
    required this.title,
    required this.album,
    required this.artists,
    required this.duration,
    required this.durationSeconds,
    required this.feedbackTokens,
    required this.isExplicit,
    required this.videoId,
    required this.year,
    required this.views,
    required this.artist,
    required this.radioId,
    required this.shuffleId,
    required this.type,
  });

  String author;
  String browseId;
  String category;
  String itemCount;
  String resultType;
  List<Thumbnail> thumbnails;
  String title;
  Album album;
  List<Album> artists;
  String duration;
  int durationSeconds;
  FeedbackTokens feedbackTokens;
  bool isExplicit;
  String videoId;
  String year;
  String views;
  String artist;
  String radioId;
  String shuffleId;
  String type;

  factory Searchresults.fromJson(Map<String, dynamic> json) => Searchresults(
        author: json["author"] ?? json["author"],
        browseId: json["browseId"] == null ? null : json["browseId"],
        category: json["category"],
        itemCount: json["itemCount"] == null ? null : json["itemCount"],
        resultType: json["resultType"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"] == null ? null : json["title"],
        album: json["album"] ?? Album.fromJson(json["album"]),
        artists: json["artists"] ??
            List<Album>.from(json["artists"].map((x) => Album.fromJson(x))),
        duration: json["duration"] == null ? null : json["duration"],
        durationSeconds: json["duration_seconds"] ?? json["duration_seconds"],
        feedbackTokens: json["feedbackTokens"] ??
            FeedbackTokens.fromJson(json["feedbackTokens"]),
        isExplicit: json["isExplicit"] == null ? null : json["isExplicit"],
        videoId: json["videoId"] == null ? null : json["videoId"],
        year: json["year"] == null ? null : json["year"],
        views: json["views"] == null ? null : json["views"],
        artist: json["artist"] == null ? null : json["artist"],
        radioId: json["radioId"] == null ? null : json["radioId"],
        shuffleId: json["shuffleId"] == null ? null : json["shuffleId"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "browseId": browseId == null ? null : browseId,
        "category": category,
        "itemCount": itemCount == null ? null : itemCount,
        "resultType": resultType,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title == null ? null : title,
        "album": album == null ? null : album.toJson(),
        "artists": artists == null
            ? null
            : List<dynamic>.from(artists.map((x) => x.toJson())),
        "duration": duration == null ? null : duration,
        "duration_seconds": durationSeconds == null ? null : durationSeconds,
        "feedbackTokens":
            feedbackTokens == null ? null : feedbackTokens.toJson(),
        "isExplicit": isExplicit == null ? null : isExplicit,
        "videoId": videoId == null ? null : videoId,
        "year": year == null ? null : year,
        "views": views == null ? null : views,
        "artist": artist == null ? null : artist,
        "radioId": radioId == null ? null : radioId,
        "shuffleId": shuffleId == null ? null : shuffleId,
        "type": type == null ? null : type,
      };
}

class Album {
  Album({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Album.fromJson(Map<String?, dynamic> json) => Album(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class FeedbackTokens {
  FeedbackTokens({
    required this.add,
    required this.remove,
  });

  dynamic add;
  dynamic remove;

  factory FeedbackTokens.fromJson(Map<String, dynamic> json) => FeedbackTokens(
        add: json["add"],
        remove: json["remove"],
      );

  Map<String, dynamic> toJson() => {
        "add": add,
        "remove": remove,
      };
}

class Thumbnail {
  Thumbnail({
    required this.height,
    required this.url,
    required this.width,
  });

  int height;
  String url;
  int width;

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
