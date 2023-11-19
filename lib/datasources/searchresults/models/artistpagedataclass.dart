class ArtistPageData {
  Output? output;

  ArtistPageData({this.output});

  ArtistPageData.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? views;
  String? name;
  String? channelId;
  Null shuffleId;
  Null radioId;
  String? subscribers;
  bool? subscribed;
  List<Thumbnails>? thumbnails;
  Songs? songs;
  Albums? albums;
  Albums? singles;
  Songs? videos;
  Related? related;

  Output(
      {this.description,
        this.views,
        this.name,
        this.channelId,
        this.shuffleId,
        this.radioId,
        this.subscribers,
        this.subscribed,
        this.thumbnails,
        this.songs,
        this.albums,
        this.singles,
        this.videos,
        this.related});

  Output.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    views = json['views'];
    name = json['name'];
    channelId = json['channelId'];
    shuffleId = json['shuffleId'];
    radioId = json['radioId'];
    subscribers = json['subscribers'];
    subscribed = json['subscribed'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    songs = json['songs'] != null ? Songs.fromJson(json['songs']) : null;
    albums =
    json['albums'] != null ? Albums.fromJson(json['albums']) : null;
    singles =
    json['singles'] != null ? Albums.fromJson(json['singles']) : null;
    videos = json['videos'] != null ? Songs.fromJson(json['videos']) : null;
    related =
    json['related'] != null ? Related.fromJson(json['related']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['views'] = views;
    data['name'] = name;
    data['channelId'] = channelId;
    data['shuffleId'] = shuffleId;
    data['radioId'] = radioId;
    data['subscribers'] = subscribers;
    data['subscribed'] = subscribed;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    if (songs != null) {
      data['songs'] = songs!.toJson();
    }
    if (albums != null) {
      data['albums'] = albums!.toJson();
    }
    if (singles != null) {
      data['singles'] = singles!.toJson();
    }
    if (videos != null) {
      data['videos'] = videos!.toJson();
    }
    if (related != null) {
      data['related'] = related!.toJson();
    }
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

class Songs {
  String? browseId;
  List<SongResults>? results;

  Songs({this.browseId, this.results});

  Songs.fromJson(Map<String, dynamic> json) {
    browseId = json['browseId'];
    if (json['results'] != null) {
      results = <SongResults>[];
      json['results'].forEach((v) {
        results!.add(SongResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['browseId'] = browseId;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongResults {
  String? videoId;
  String? title;
  List<Artists>? artists;
  Artists? album;
  String? likeStatus;
  Null inLibrary;
  List<Thumbnails>? thumbnails;
  bool? isAvailable;
  bool? isExplicit;
  String? videoType;

  SongResults(
      {this.videoId,
        this.title,
        this.artists,
        this.album,
        this.likeStatus,
        this.inLibrary,
        this.thumbnails,
        this.isAvailable,
        this.isExplicit,
        this.videoType});

  SongResults.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? Artists.fromJson(json['album']) : null;
    likeStatus = json['likeStatus'];
    inLibrary = json['inLibrary'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    isAvailable = json['isAvailable'];
    isExplicit = json['isExplicit'];
    videoType = json['videoType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['title'] = title;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    if (album != null) {
      data['album'] = album!.toJson();
    }
    data['likeStatus'] = likeStatus;
    data['inLibrary'] = inLibrary;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    data['isAvailable'] = isAvailable;
    data['isExplicit'] = isExplicit;
    data['videoType'] = videoType;
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

class Albums {
  String? browseId;
  List<AlbumResults>? results;
  String? params;

  Albums({this.browseId, this.results, this.params});

  Albums.fromJson(Map<String, dynamic> json) {
    browseId = json['browseId'];
    if (json['results'] != null) {
      results = <AlbumResults>[];
      json['results'].forEach((v) {
        results!.add(AlbumResults.fromJson(v));
      });
    }
    params = json['params'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['browseId'] = browseId;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['params'] = params;
    return data;
  }
}

class AlbumResults {
  String? title;
  String? year;
  String? browseId;
  List<Thumbnails>? thumbnails;
  bool? isExplicit;

  AlbumResults(
      {this.title, this.year, this.browseId, this.thumbnails, this.isExplicit});

  AlbumResults.fromJson(Map<String, dynamic> json) {
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

class RelatedResults {
  String? title;
  String? browseId;
  List<Thumbnails>? thumbnails;
  String? subscribers;

  RelatedResults({this.title, this.browseId, this.thumbnails,this.subscribers});

  RelatedResults.fromJson(Map<String, dynamic> json) {
    title = json['title'];

    browseId = json['browseId'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    subscribers = json['subscribers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['browseId'] = browseId;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoResults {
  String? title;
  String? videoId;
  List<Artists>? artists;
  String? playlistId;
  List<Thumbnails>? thumbnails;
  String? views;

  VideoResults(
      {this.title,
        this.videoId,
        this.artists,
        this.playlistId,
        this.thumbnails,
        this.views});

  VideoResults.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videoId = json['videoId'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    playlistId = json['playlistId'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['videoId'] = videoId;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['playlistId'] = playlistId;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    data['views'] = views;
    return data;
  }
}

class Related {
  Null browseId;
  List<RelatedResults>? results;

  Related({this.browseId, this.results});

  Related.fromJson(Map<String, dynamic> json) {
    browseId = json['browseId'];
    if (json['results'] != null) {
      results = <RelatedResults>[];
      json['results'].forEach((v) {
        results!.add(RelatedResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['browseId'] = browseId;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SinglesResults {
  String? title;
  String? browseId;
  String? subscribers;
  List<Thumbnails>? thumbnails;

  SinglesResults({this.title, this.browseId, this.subscribers, this.thumbnails});

  SinglesResults.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    browseId = json['browseId'];
    subscribers = json['subscribers'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['browseId'] = browseId;
    data['subscribers'] = subscribers;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
