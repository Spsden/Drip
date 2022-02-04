// To parse this JSON data, do
//
//     final topresults = topresultsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Topresults topresultsFromJson(String str) =>
    Topresults.fromJson(json.decode(str));

String topresultsToJson(Topresults data) => json.encode(data.toJson());

class Topresults {
  Topresults({
    required this.artists,
    required this.category,
    required this.duration,
    required this.durationSeconds,
    required this.resultType,
    required this.thumbnails,
    required this.title,
    required this.videoId,
    required this.views,
    required this.year,
  });

  List<Artist> artists;
  String category;
  String duration;
  int durationSeconds;
  String resultType;
  List<Thumbnail> thumbnails;
  String title;
  String videoId;
  String views;
  dynamic year;

  factory Topresults.fromJson(Map<String, dynamic> json) => Topresults(
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        category: json["category"],
        duration: json["duration"],
        durationSeconds: json["duration_seconds"],
        resultType: json["resultType"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
        videoId: json["videoId"],
        views: json["views"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "category": category,
        "duration": duration,
        "duration_seconds": durationSeconds,
        "resultType": resultType,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title,
        "videoId": videoId,
        "views": views,
        "year": year,
      };
}

class Artist {
  Artist({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
