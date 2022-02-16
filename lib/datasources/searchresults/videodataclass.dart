// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Video({
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

  final List<Artist>? artists;
  final String category;
  final String duration;
  final int durationSeconds;
  final String resultType;
  final List<Thumbnail>? thumbnails;
  final String title;
  final String videoId;
  final String views;
  final dynamic year;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    artists: json["artists"] == null ? null : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    category: json["category"] == null ? null : json["category"],
    duration: json["duration"] == null ? null : json["duration"],
    durationSeconds: json["duration_seconds"] == null ? null : json["duration_seconds"],
    resultType: json["resultType"] == null ? null : json["resultType"],
    thumbnails: json["thumbnails"] == null ? null : List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"] == null ? null : json["title"],
    videoId: json["videoId"] == null ? null : json["videoId"],
    views: json["views"] == null ? null : json["views"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "artists": artists == null ? null : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "category": category == null ? null : category,
    "duration": duration == null ? null : duration,
    "duration_seconds": durationSeconds == null ? null : durationSeconds,
    "resultType": resultType == null ? null : resultType,
    "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
    "title": title == null ? null : title,
    "videoId": videoId == null ? null : videoId,
    "views": views == null ? null : views,
    "year": year,
  };
}

class Artist {
  Artist({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
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
