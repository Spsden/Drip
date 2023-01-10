// To parse this JSON data, do
//
//     final albums = albumsFromJson(jsonString);

import 'dart:convert';
Albums albumFromJson(String str) => Albums.fromJson(jsonDecode(str));
List<Albums> albumsFromJson(String str) =>
    List<Albums>.from(json.decode(str).map((x) => Albums.fromJson(x)));

String albumsToJson(List<Albums> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Albums {
  Albums({
    required this.artists,
    required this.browseId,
    required this.category,
    required this.duration,
    required this.isExplicit,
    required this.resultType,
    required this.thumbnails,
    required this.title,
    required this.type,
    required this.year,
  });

  List<Artist> artists;
  String browseId;
  String category;
  dynamic duration;
  bool isExplicit;
  String resultType;
  List<Thumbnail>? thumbnails;
  String title;
  String type;
  String year;

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist?.fromJson(x))),
        browseId: json["browseId"],
        category: json["category"],
        duration: json["duration"],
        isExplicit: json["isExplicit"],
        resultType: json["resultType"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
        type: json["type"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "browseId": browseId,
        "category": category,
        "duration": duration,
        "isExplicit": isExplicit,
        "resultType": resultType,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "year": year,
      };
}

class Artist {
  Artist({
    required this.id,
    required this.name,
  });

  String? id;
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
