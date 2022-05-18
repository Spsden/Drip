// To parse this JSON data, do
//
//     final watchPlaylists = watchPlaylistsFromJson(jsonString);

import 'dart:convert';

WatchPlaylists watchPlaylistsFromJson(String str) => WatchPlaylists.fromJson(json.decode(str));

String watchPlaylistsToJson(WatchPlaylists data) => json.encode(data.toJson());

class WatchPlaylists {
  WatchPlaylists({
     required this.lyrics,
     required this.playlistId,
     required this.tracks,
  });

  final String? lyrics;
  final String? playlistId;
  final List<Track>? tracks;

  factory WatchPlaylists.fromJson(Map<String, dynamic> json) => WatchPlaylists(
    lyrics: json["lyrics"],
    playlistId: json["playlistId"],
    tracks: json["tracks"] == null ? null : List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lyrics": lyrics,
    "playlistId": playlistId,
    "tracks": tracks == null ? null : List<dynamic>.from(tracks!.map((x) => x.toJson())),
  };
}

class Track {
  Track({
     required this.album,
     required this.artists,
     required this.feedbackTokens,
     required this.length,
     required this.likeStatus,
     required this.thumbnail,
     required this.title,
     required this.videoId,
     required this.year,
     required this.views,
  });

  final Album? album;
  final List<Album>? artists;
  final dynamic feedbackTokens;
  final String? length;
  final dynamic likeStatus;
  final List<Thumbnail>? thumbnail;
  final String? title;
  final String? videoId;
  final String? year;
  final String? views;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    album: json["album"] == null ? null : Album.fromJson(json["album"]),
    artists: json["artists"] == null ? null : List<Album>.from(json["artists"].map((x) => Album.fromJson(x))),
    feedbackTokens: json["feedbackTokens"],
    length: json["length"],
    likeStatus: json["likeStatus"],
    thumbnail: json["thumbnail"] == null ? null : List<Thumbnail>.from(json["thumbnail"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    videoId: json["videoId"],
    year: json["year"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "album": album == null ? null : album!.toJson(),
    "artists": artists == null ? null : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "feedbackTokens": feedbackTokens,
    "length": length,
    "likeStatus": likeStatus,
    "thumbnail": thumbnail == null ? null : List<dynamic>.from(thumbnail!.map((x) => x.toJson())),
    "title": title,
    "videoId": videoId,
    "year": year,
    "views": views,
  };
}

class Album {
  Album({
     required this.id,
     required this.name,
  });

  final String? id;
  final String? name;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
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
