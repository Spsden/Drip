// To parse this JSON data, do
//
//     final ArtistsPageData = ArtistsPageDataFromJson(jsonString?);

import 'package:meta/meta.dart';
import 'dart:convert';

ArtistsPageData ArtistsPageDataFromJson(String str) => ArtistsPageData.fromJson(json.decode(str));

String ArtistsPageDataToJson(ArtistsPageData data) => json.encode(data.toJson());

class ArtistsPageData {
  ArtistsPageData({
    required this.albums,
    required this.channelId,
    required this.description,
    required this.name,
    required this.radioId,
    required this.related,
    required this.shuffleId,
    required this.singles,
    required this.songs,
    required this.subscribed,
    required this.subscribers,
    required this.thumbnails,
    required this.videos,
    required this.views,
  });

  final Albums albums;
  final String? channelId;
  final String? description;
  final String? name;
  final String? radioId;
  final Related related;
  final dynamic shuffleId;
  final Albums singles;
  final Songs songs;
  final bool subscribed;
  final String? subscribers;
  final List<Thumbnail> thumbnails;
  final Videos videos;
  final String? views;

  factory ArtistsPageData.fromJson(Map<String?, dynamic> json) => ArtistsPageData(
    albums: Albums.fromJson(json["albums"]),
    channelId: json["channelId"],
    description: json["description"],
    name: json["name"],
    radioId: json["radioId"],
    related: Related.fromJson(json["related"]),
    shuffleId: json["shuffleId"],
    singles: Albums.fromJson(json["singles"]),
    songs: Songs.fromJson(json["songs"]),
    subscribed: json["subscribed"],
    subscribers: json["subscribers"],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    videos: Videos.fromJson(json["videos"]),
    views: json["views"],
  );

  Map<String?, dynamic> toJson() => {
    "albums": albums.toJson(),
    "channelId": channelId,
    "description": description,
    "name": name,
    "radioId": radioId,
    "related": related.toJson(),
    "shuffleId": shuffleId,
    "singles": singles.toJson(),
    "songs": songs.toJson(),
    "subscribed": subscribed,
    "subscribers": subscribers,
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "videos": videos.toJson(),
    "views": views,
  };
}

class Albums {
  Albums({
    required this.browseId,
    required this.params,
    required this.results,
  });

  final String? browseId;
  final String? params;
  final List<AlbumsResult> results;

  factory Albums.fromJson(Map<String?, dynamic> json) => Albums(
    browseId: json["browseId"],
    params: json["params"],
    results: List<AlbumsResult>.from(json["results"].map((x) => AlbumsResult.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "browseId": browseId,
    "params": params,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class AlbumsResult {
  AlbumsResult({
    required this.browseId,
    required this.thumbnails,
    required this.title,
    required this.year,
    required this.subscribers,
  });

  final String? browseId;
  final List<Thumbnail> thumbnails;
  final String? title;
  final String? year;
  final String? subscribers;

  factory AlbumsResult.fromJson(Map<String?, dynamic> json) => AlbumsResult(
    browseId: json["browseId"],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    year: json["year"] == null ? null : json["year"],
    subscribers: json["subscribers"] == null ? null : json["subscribers"],
  );

  Map<String?, dynamic> toJson() => {
    "browseId": browseId,
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "title": title,
    "year": year == null ? null : year,
    "subscribers": subscribers == null ? null : subscribers,
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

class Related {
  Related({
    required this.browseId,
    required this.results,
  });

  final dynamic browseId;
  final List<AlbumsResult> results;

  factory Related.fromJson(Map<String?, dynamic> json) => Related(
    browseId: json["browseId"],
    results: List<AlbumsResult>.from(json["results"].map((x) => AlbumsResult.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "browseId": browseId,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Songs {
  Songs({
    required this.browseId,
    required this.results,
  });

  final String? browseId;
  final List<SongsResult> results;

  factory Songs.fromJson(Map<String?, dynamic> json) => Songs(
    browseId: json["browseId"],
    results: List<SongsResult>.from(json["results"].map((x) => SongsResult.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "browseId": browseId,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class SongsResult {
  SongsResult({
    required this.album,
    required this.artists,
    required this.isAvailable,
    required this.isExplicit,
    required this.likeStatus,
    required this.thumbnails,
    required this.title,
    required this.videoId,
  });

  final Album album;
  final List<Album> artists;
  final bool isAvailable;
  final bool isExplicit;
  final String? likeStatus;
  final List<Thumbnail> thumbnails;
  final String? title;
  final String? videoId;

  factory SongsResult.fromJson(Map<String?, dynamic> json) => SongsResult(
    album: Album.fromJson(json["album"]),
    artists: List<Album>.from(json["artists"].map((x) => Album.fromJson(x))),
    isAvailable: json["isAvailable"],
    isExplicit: json["isExplicit"],
    likeStatus: json["likeStatus"],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    videoId: json["videoId"],
  );

  Map<String?, dynamic> toJson() => {
    "album": album.toJson(),
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "isAvailable": isAvailable,
    "isExplicit": isExplicit,
    "likeStatus": likeStatus,
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "title": title,
    "videoId": videoId,
  };
}

class Album {
  Album({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Album.fromJson(Map<String?, dynamic> json) => Album(
    id: json["id"],
    name: json["name"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Videos {
  Videos({
    required this.browseId,
    required this.results,
  });

  final String? browseId;
  final List<VideosResult> results;

  factory Videos.fromJson(Map<String?, dynamic> json) => Videos(
    browseId: json["browseId"],
    results: List<VideosResult>.from(json["results"].map((x) => VideosResult.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "browseId": browseId,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class VideosResult {
  VideosResult({
    required this.artists,
    //required this.playlistId,
    required this.thumbnails,
    required this.title,
    required this.videoId,
    required this.views,
  });

  final List<Album> artists;
  //final PlaylistId? playlistId;
  final List<Thumbnail> thumbnails;
  final String? title;
  final String? videoId;
  final String? views;

  factory VideosResult.fromJson(Map<String?, dynamic> json) => VideosResult(
    artists: List<Album>.from(json["artists"].map((x) => Album.fromJson(x))),
   // playlistId: playlistIdValues.map[json["playlistId"]],
    thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
    videoId: json["videoId"],
    views: json["views"],
  );

  Map<String?, dynamic> toJson() => {
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    //"playlistId": playlistIdValues.reverse[playlistId],
    "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
    "title": title,
    "videoId": videoId,
    "views": views,
  };
}

