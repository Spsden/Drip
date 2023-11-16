import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';
part 'artist.g.dart';

@freezed
class Artist with _$Artist {
	factory Artist({
		String? name,
		String? id,
	}) = _Artist;

	factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}