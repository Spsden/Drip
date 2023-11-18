import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
	factory Item({
		String? id,
		String? type,
		String? title,
		List<String>? images,
		String? image,
		String? subtitle,
		String? subscribers,
		String? artist,
		String? album,
		String? duration,
	}) = _Item;

	factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}