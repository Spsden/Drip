// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

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
    category: json["category"],
    duration: json["duration"],
    durationSeconds: json["duration_seconds"],
    resultType: json["resultType"],
    thumbnails: json["thumbnails"] == null ? null : List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    videoId: json["videoId"],
    views: json["views"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "artists": artists == null ? null : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "category": category,
    "duration": duration,
    "duration_seconds": durationSeconds,
    "resultType": resultType,
    "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
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

  final String? id;
  final String name;

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
