// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// List<Searchresults> SearchresultsFromJson(String str) =>
//     List<Searchresults>.from(
//         json.decode(str).map((x) => Searchresults.fromJson(x)));

// class Searchresults {
//   final String category;
//   final String resultType;
//   final String videoId;
//   final String title;
//   final List<Artist> artists;
//   final String views;
//   final String duration;
//   final int duration_seconds;
//   Searchresults({
//     required this.category,
//     required this.resultType,
//     required this.videoId,
//     required this.title,
//     required this.artists,
//     required this.views,
//     required this.duration,
//     required this.duration_seconds,
//   });

//   Searchresults copyWith({
//     String? category,
//     String? resultType,
//     String? videoId,
//     String? title,
//     List<Artist>? artists,
//     String? views,
//     String? duration,
//     int? duration_seconds,
//   }) {
//     return Searchresults(
//       category: category ?? this.category,
//       resultType: resultType ?? this.resultType,
//       videoId: videoId ?? this.videoId,
//       title: title ?? this.title,
//       artists: artists ?? this.artists,
//       views: views ?? this.views,
//       duration: duration ?? this.duration,
//       duration_seconds: duration_seconds ?? this.duration_seconds,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'category': category,
//       'resultType': resultType,
//       'videoId': videoId,
//       'title': title,
//       'artists': artists.map((x) => x.toMap()).toList(),
//       'views': views,
//       'duration': duration,
//       'duration_seconds': duration_seconds,
//     };
//   }

//   factory Searchresults.fromMap(Map<String, dynamic> map) {
//     return Searchresults(
//       category: map['category'] ?? '',
//       resultType: map['resultType'] ?? '',
//       videoId: map['videoId'] ?? '',
//       title: map['title'] ?? '',
//       artists: List<Artist>.from(map['artists']?.map((x) => Artist.fromMap(x))),
//       views: map['views'] ?? '',
//       duration: map['duration'] ?? '',
//       duration_seconds: map['duration_seconds']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Searchresults.fromJson(String source) =>
//       Searchresults.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Searchresults(category: $category, resultType: $resultType, videoId: $videoId, title: $title, artists: $artists, views: $views, duration: $duration, duration_seconds: $duration_seconds)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Searchresults &&
//         other.category == category &&
//         other.resultType == resultType &&
//         other.videoId == videoId &&
//         other.title == title &&
//         listEquals(other.artists, artists) &&
//         other.views == views &&
//         other.duration == duration &&
//         other.duration_seconds == duration_seconds;
//   }

//   @override
//   int get hashCode {
//     return category.hashCode ^
//         resultType.hashCode ^
//         videoId.hashCode ^
//         title.hashCode ^
//         artists.hashCode ^
//         views.hashCode ^
//         duration.hashCode ^
//         duration_seconds.hashCode;
//   }
// }

// class Artist {
//   final String name;
//   final String id;
//   Artist({
//     required this.name,
//     required this.id,
//   });

//   Artist copyWith({
//     String? name,
//     String? id,
//   }) {
//     return Artist(
//       name: name ?? this.name,
//       id: id ?? this.id,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'id': id,
//     };
//   }

//   factory Artist.fromMap(Map<String, dynamic> map) {
//     return Artist(
//       name: map['name'] ?? '',
//       id: map['id'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

//   @override
//   String toString() => 'Artist(name: $name, id: $id)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Artist && other.name == name && other.id == id;
//   }

//   @override
//   int get hashCode => name.hashCode ^ id.hashCode;
// }
