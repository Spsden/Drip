import 'package:drip/datasources/searchresults/models/playlistdataclass.dart';

import 'package:hive/hive.dart';

part 'saved_playlist.g.dart';

@HiveType(typeId: 2)
class SavedPlayList {
  @HiveField(0)
  final String playListTitle;
  @HiveField(1)
  final String playListSource;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String thumbnail;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String author;
  @HiveField(6)
  final String trackCount;
  @HiveField(7)
  final String year;
  @HiveField(8)
  final List<Track> tracks;

  SavedPlayList({
    required this.playListTitle,
    required this.playListSource,
    required this.id,
    required this.thumbnail,
    required this.description,
    required this.author,
    required this.trackCount,
    required this.year,
    required this.tracks,
  });
}
