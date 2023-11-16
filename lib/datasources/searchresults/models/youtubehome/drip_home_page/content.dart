import 'package:freezed_annotation/freezed_annotation.dart';

import 'album.dart';
import 'artist.dart';
import 'thumbnail.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
	factory Content({
		String? title,
		String? videoId,
		List<Artist>? artists,
		List<Thumbnail>? thumbnails,
		bool? isExplicit,
		Album? album,
	}) = _Content;

	factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
}