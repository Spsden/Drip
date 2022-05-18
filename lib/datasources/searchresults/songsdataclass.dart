// To parse this JSON data, do
//
//     final songs = songsFromJson(jsonString);

import 'dart:convert';

List<Songs> songsFromJson(String str) =>
    List<Songs>.from(json.decode(str).map((x) => Songs.fromJson(x)));

String songsToJson(List<Songs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Songs {
  Songs({
    required this.album,
    required this.artists,
    required this.category,
    required this.duration,
    required this.durationSeconds,
    required this.feedbackTokens,
    required this.isExplicit,
    required this.resultType,
    required this.thumbnails,
    required this.title,
    required this.videoId,
    required this.year,
  });

  Album? album;
  List<Album>? artists;
  String? category;
  String? duration;
  int durationSeconds;
  FeedbackTokens feedbackTokens;
  bool isExplicit;
  String resultType;
  List<Thumbnail> thumbnails;
  String title;
  String videoId;
  dynamic year;

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
        album: Album.fromJson(json["album"]),
        artists:
            List<Album>.from(json["artists"].map((x) => Album.fromJson(x))),
        category: json["category"],
        duration: json["duration"],
        durationSeconds: json["duration_seconds"],
        feedbackTokens: FeedbackTokens.fromJson(json["feedbackTokens"]),
        isExplicit: json["isExplicit"],
        resultType: json["resultType"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
        videoId: json["videoId"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "album": album?.toJson(),
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "category": category,
        "duration": duration,
        "duration_seconds": durationSeconds,
        "feedbackTokens": feedbackTokens.toJson(),
        "isExplicit": isExplicit,
        "resultType": resultType,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title,
        "videoId": videoId,
        "year": year,
      };
}

class Album {
  Album({
    required this.id,
    required this.name,
  });

  String? id;
  String name;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
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
