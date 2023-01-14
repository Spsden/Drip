// To parse this JSON data, do
//
//     final communityPlaylist = communityPlaylistFromJson(jsonString);

import 'dart:convert';

CommunityPlaylist oneCommunityPlaylistFromJson(String str) => CommunityPlaylist.fromJson(jsonDecode(str));

List<CommunityPlaylist> communityPlaylistFromJson(String str) =>
    List<CommunityPlaylist>.from(
        json.decode(str).map((x) => CommunityPlaylist?.fromJson(x)));

String communityPlaylistToJson(List<CommunityPlaylist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommunityPlaylist {
  CommunityPlaylist({
    required this.author,
    required this.browseId,
    required this.category,
    required this.itemCount,
    required this.resultType,
    required this.thumbnails,
    required this.title,
  });

  String? author;
  String browseId;
  String category;
  String? itemCount;
  String resultType;
  List<Thumbnail> thumbnails;
  String title;

  factory CommunityPlaylist.fromJson(Map<String, dynamic> json) =>
      CommunityPlaylist(
        author: json["author"],
        browseId: json["browseId"],
        category: json["category"],
        itemCount: json["itemCount"],
        resultType: json["resultType"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "browseId": browseId,
        "category": category,
        "itemCount": itemCount,
        "resultType": resultType,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title,
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
