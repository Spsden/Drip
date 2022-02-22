// To parse this JSON data, do
//
//     final playlistDataClass = playlistDataClassFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PlaylistDataClass> playlistDataClassFromJson(String str) => List<PlaylistDataClass>.from(json.decode(str).map((x) => PlaylistDataClass.fromJson(x)));

String playlistDataClassToJson(List<PlaylistDataClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistDataClass {
  PlaylistDataClass({
    required this.playlistId,
    required this.thumbnails,
    required this.title,
  });

  final String playlistId;
  final List<Thumbnail>? thumbnails;
  final String title;

  factory PlaylistDataClass.fromJson(Map<String, dynamic> json) => PlaylistDataClass(
    playlistId: json["playlistId"] == null ? null : json["playlistId"],
    thumbnails: json["thumbnails"] == null ? null : List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "playlistId": playlistId == null ? null : playlistId,
    "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
    "title": title == null ? null : title,
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
