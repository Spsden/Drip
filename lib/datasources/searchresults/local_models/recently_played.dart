
import 'package:hive/hive.dart';

part 'recently_played.g.dart';
@HiveType(typeId: 1)
class RecentlyPlayed {

  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<String> author;
  @HiveField(2)
  final List<String?> thumbs;
  @HiveField(3)
  final String? urlOfVideo;
  @HiveField(4)
  final String videoId;

  RecentlyPlayed(
      {required this.title,
        required this.author,
        required this.thumbs,
        required this.urlOfVideo,
        required this.videoId});

 


}