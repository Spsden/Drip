import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
class Album with _$Album {
	factory Album({
		String? name,
		String? id,
	}) = _Album;

	factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}