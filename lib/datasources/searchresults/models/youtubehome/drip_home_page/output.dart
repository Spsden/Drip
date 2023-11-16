import 'package:freezed_annotation/freezed_annotation.dart';

import 'content.dart';

part 'output.freezed.dart';
part 'output.g.dart';

@freezed
class Output with _$Output {
	factory Output({
		String? title,
		List<Content>? contents,
	}) = _Output;

	factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);
}