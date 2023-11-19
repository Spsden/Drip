class AlbumDataClass {
  Output? output;

  AlbumDataClass({this.output});

  AlbumDataClass.fromJson(Map<String, dynamic> json) {
    output =
    json['output'] != null ? Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (output != null) {
      data['output'] = output!.toJson();
    }
    return data;
  }
}

class Output {
  String? title;
  String? type;
  List<Thumbnails>? thumbnails;
  String? description;
  List<Artists>? artists;
  String? year;
  int? trackCount;
  String? duration;
  String? audioPlaylistId;
  List<Tracks>? tracks;
  List<OtherVersions>? otherVersions;
  int? durationSeconds;

  Output(
      {this.title,
        this.type,
        this.thumbnails,
        this.description,
        this.artists,
        this.year,
        this.trackCount,
        this.duration,
        this.audioPlaylistId,
        this.tracks,
        this.otherVersions,
        this.durationSeconds});

  Output.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    description = json['description'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    year = json['year'];
    trackCount = json['trackCount'];
    duration = json['duration'];
    audioPlaylistId = json['audioPlaylistId'];
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add(Tracks.fromJson(v));
      });
    }
    if (json['other_versions'] != null) {
      otherVersions = <OtherVersions>[];
      json['other_versions'].forEach((v) {
        otherVersions!.add(OtherVersions.fromJson(v));
      });
    }
    durationSeconds = json['duration_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['year'] = year;
    data['trackCount'] = trackCount;
    data['duration'] = duration;
    data['audioPlaylistId'] = audioPlaylistId;
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    if (otherVersions != null) {
      data['other_versions'] =
          otherVersions!.map((v) => v.toJson()).toList();
    }
    data['duration_seconds'] = durationSeconds;
    return data;
  }
}

class Thumbnails {
  String? url;
  int? width;
  int? height;

  Thumbnails({this.url, this.width, this.height});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Artists {
  String? name;
  String? id;

  Artists({this.name, this.id});

  Artists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Tracks {
  String? videoId;
  String? title;
  List<Artists>? artists;
  String? album;
  String? likeStatus;
  Null? inLibrary;
  Null? thumbnails;
  bool? isAvailable;
  bool? isExplicit;
  String? videoType;
  String? duration;
  int? durationSeconds;

  Tracks(
      {this.videoId,
        this.title,
        this.artists,
        this.album,
        this.likeStatus,
        this.inLibrary,
        this.thumbnails,
        this.isAvailable,
        this.isExplicit,
        this.videoType,
        this.duration,
        this.durationSeconds});

  Tracks.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    album = json['album'];
    likeStatus = json['likeStatus'];
    inLibrary = json['inLibrary'];
    thumbnails = json['thumbnails'];
    isAvailable = json['isAvailable'];
    isExplicit = json['isExplicit'];
    videoType = json['videoType'];
    duration = json['duration'];
    durationSeconds = json['duration_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['title'] = title;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['album'] = album;
    data['likeStatus'] = likeStatus;
    data['inLibrary'] = inLibrary;
    data['thumbnails'] = thumbnails;
    data['isAvailable'] = isAvailable;
    data['isExplicit'] = isExplicit;
    data['videoType'] = videoType;
    data['duration'] = duration;
    data['duration_seconds'] = durationSeconds;
    return data;
  }
}

class OtherVersions {
  String? title;
  String? year;
  String? browseId;
  List<Thumbnails>? thumbnails;
  bool? isExplicit;

  OtherVersions(
      {this.title, this.year, this.browseId, this.thumbnails, this.isExplicit});

  OtherVersions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    browseId = json['browseId'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    isExplicit = json['isExplicit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['year'] = year;
    data['browseId'] = browseId;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    data['isExplicit'] = isExplicit;
    return data;
  }
}
