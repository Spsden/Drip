// To parse this JSON data, do
//
//     final playlists = playlistsFromJson(jsonString?);

import 'dart:convert';

Playlists playlistsFromJson(String str) => Playlists.fromJson(json.decode(str));

String playlistsToJson(Playlists data) => json.encode(data.toJson());

class Playlists {
  Playlists({
    required this.author,
    required this.description,
    required this.duration,
    required this.durationSeconds,
    required this.id,
    required this.privacy,
    required this.suggestionsToken,
    required this.thumbnails,
    required this.title,
    required this.trackCount,
    required this.tracks,
    required this.year,
  });

  final Author? author;
  final String? description;
  final String? duration;
  final int durationSeconds;
  final String? id;
  final String? privacy;
  final dynamic suggestionsToken;
  final List<Thumbnail> thumbnails;
  final String? title;
  final int trackCount;
  final List<Track> tracks;
  final String? year;

  factory Playlists.fromJson(Map<String?, dynamic> json) => Playlists(
    author: Author.fromJson(json["author"]),
    description: json["description"],
    duration: json["duration"],
    durationSeconds: json["duration_seconds"],
    id: json["id"],
    privacy: json["privacy"],
    suggestionsToken: json["suggestions_token"],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    trackCount: json["trackCount"],
    tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
    year: json["year"],
  );

  Map<String?, dynamic> toJson() => {
    "author": author?.toJson(),
    "description": description,
    "duration": duration,
    "duration_seconds": durationSeconds,
    "id": id,
    "privacy": privacy,
    "suggestions_token": suggestionsToken,
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "title": title,
    "trackCount": trackCount,
    "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
    "year": year,
  };
}

class Author {
  Author({
    required this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory Author.fromJson(Map<String?, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
  );

  Map<String?, dynamic> toJson() => {
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
  final String? url;
  final int width;

  factory Thumbnail.fromJson(Map<String?, dynamic> json) => Thumbnail(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String?, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}

class Track {
  Track({
    required this.album,
    required this.artists,
    required this.duration,
    required this.durationSeconds,
    required this.isAvailable,
    required this.isExplicit,
    //required this.likeStatus,
    required this.thumbnails,
    required this.title,
    required this.videoId,
  });

  final Author? album;
  final List<Author> artists;
  final String? duration;
  final int durationSeconds;
  final bool isAvailable;
  final bool isExplicit;
  //final LikeStatus likeStatus;
  final List<Thumbnail> thumbnails;
  final String? title;
  final String? videoId;

  factory Track.fromJson(Map<String?, dynamic> json) => Track(
    album: json["album"] == null ? null : Author.fromJson(json["album"]),
    artists: List<Author>.from(json["artists"].map((x) => Author.fromJson(x))),
    duration: json["duration"],
    durationSeconds: json["duration_seconds"],
    isAvailable: json["isAvailable"],
    isExplicit: json["isExplicit"],
    //likeStatus: likeStatusValues.map[json["likeStatus"]],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    videoId: json["videoId"],
  );

  Map<String?, dynamic> toJson() => {
    "album": album == null ? null : album!.toJson(),
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "duration": duration,
    "duration_seconds": durationSeconds,
    "isAvailable": isAvailable,
    "isExplicit": isExplicit,
    //"likeStatus": likeStatusValues.reverse[likeStatus],
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "title": title,
    "videoId": videoId,
  };
}

