import 'package:freezed_annotation/freezed_annotation.dart';

part 'thumbnail.freezed.dart';
part 'thumbnail.g.dart';

@freezed
class Thumbnail with _$Thumbnail {
	factory Thumbnail({
		String? url,
		int? width,
		int? height,
	}) = _Thumbnail;

	factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
}