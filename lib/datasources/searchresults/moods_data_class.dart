// To parse this JSON data, do
//
//     final moodsCategories = moodsCategoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MoodsCategories moodsCategoriesFromJson(String str) => MoodsCategories.fromJson(json.decode(str));

String moodsCategoriesToJson(MoodsCategories data) => json.encode(data.toJson());

class MoodsCategories {
  MoodsCategories({
    required this.genres,
    required this.forYou,
    required this.moodsMoments,
  });

  final List<ForYou>? genres;
  final List<ForYou>? forYou;
  final List<ForYou>? moodsMoments;

  factory MoodsCategories.fromJson(Map<String?, dynamic> json) => MoodsCategories(
    genres: json["Genres"] == null ? null : List<ForYou>.from(json["Genres"].map((x) => ForYou.fromJson(x))),
    forYou: json["For you"] == null ? null : List<ForYou>.from(json["For you"].map((x) => ForYou.fromJson(x))),
    moodsMoments: json["Moods & moments"] == null ? null : List<ForYou>.from(json["Moods & moments"].map((x) => ForYou.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "Genres": genres == null ? null : List<dynamic>.from(genres!.map((x) => x.toJson())),
    "For you": forYou == null ? null : List<dynamic>.from(forYou!.map((x) => x.toJson())),
    "Moods & moments": moodsMoments == null ? null : List<dynamic>.from(moodsMoments!.map((x) => x.toJson())),
  };
}

class ForYou {
  ForYou({
    required this.params,
    required this.title,
  });

  final String? params;
  final String? title;

  factory ForYou.fromJson(Map<String, dynamic> json) => ForYou(
    params: json["params"] == null ? null : json["params"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String?, dynamic> toJson() => {
    "params": params == null ? null : params,
    "title": title == null ? null : title,
  };
}
