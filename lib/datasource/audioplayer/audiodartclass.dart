class Music  {
  String? trackName;
  String? albumName;
  int? trackNumber;
  //int? year;
  String? albumArtistName;
  List<String>? trackArtistNames;
  String? filePath;
  String? networkAlbumArt;
  int? trackDuration;
 // int? bitrate;
  String? trackId;
  String? albumId;
 // int? timeAdded;
 // dynamic extras;


  @override
  Map<String, dynamic> toMap() {
    var artists = ['Unknown Artist'];

    return {
      'trackName': this.trackName,
      'albumName': this.albumName,
      'trackNumber': this.trackNumber,
     // 'year': this.year,
      'albumArtistName': (this.albumArtistName?.isEmpty ?? true)
          ? 'Unknown Artist'
          : this.albumArtistName,
      'trackArtistNames': artists,
      'filePath': this.filePath,
      'trackDuration': this.trackDuration,
    //  'bitrate': this.bitrate,
      'networkAlbumArt': this.networkAlbumArt,
      'trackId': this.trackId,
      'albumId': this.albumId,
     // 'timeAdded': this.timeAdded,
    };
  }

  Future songDetails(String audioUrl,String videoId, String artist, String title, String thumbnail) async{
   trackId =videoId;
    albumArtistName= artist;
    trackName = title;
   networkAlbumArt = thumbnail;
   filePath = audioUrl;

  //  notifyListeners();



  }
  // factory Track.fromMap(Map<String, dynamic> map) => Track(
  //   trackName: [null, ''].contains(map['trackName'])
  //       ? path.basename(map['filePath'])
  //       : map['trackName'],
  //   albumName: [null, ''].contains(map['albumName'])
  //       ? 'Unknown Album'
  //       : map['albumName'],
  //   trackNumber: map['trackNumber'],
  //   year: map['year'],
  //   albumArtistName: [null, ''].contains(map['albumArtistName'])
  //       ? 'Unknown Artist'
  //       : map['albumArtistName'],
  //   trackArtistNames:
  //   (map['trackArtistNames'] ?? <String>['Unknown Artist'])
  //       .cast<String>(),
  //   filePath: map['filePath'],
  //   networkAlbumArt: map['networkAlbumArt'],
  //   trackDuration: map['trackDuration'],
  //   bitrate: map['bitrate'],
  //   trackId: map['trackId'],
  //   albumId: map['albumId'],
  //
  // );





  Music({
    this.trackName,
    this.albumName,
    this.trackNumber,
    //this.year,
    this.albumArtistName,
    this.trackArtistNames,
    this.filePath,
    this.networkAlbumArt,
    this.trackDuration,
    //this.bitrate,
    this.trackId,
    this.albumId,
   // this.timeAdded,
  });
}