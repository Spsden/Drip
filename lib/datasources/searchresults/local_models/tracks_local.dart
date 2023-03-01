

import 'package:hive/hive.dart';

part 'tracks_local.g.dart';
@HiveType(typeId: 3)
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


  @HiveField(0)
  final List<String>? album;
  @HiveField(1)
  final List<String> artists;
  @HiveField(2)
  final String? duration;
  @HiveField(3)
  final int durationSeconds;
  @HiveField(4)
  final bool isAvailable;
  @HiveField(5)
  final bool isExplicit;
  //final LikeStatus likeStatus;
  @HiveField(6)
  final List<String> thumbnails;
  @HiveField(7)
  final String? title;
  @HiveField(8)
  final String? videoId;


}

