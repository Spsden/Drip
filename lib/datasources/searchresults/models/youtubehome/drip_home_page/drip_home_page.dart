import 'package:freezed_annotation/freezed_annotation.dart';

import 'output.dart';

part 'drip_home_page.freezed.dart';
part 'drip_home_page.g.dart';

@freezed
class DripHomePage with _$DripHomePage {
	factory DripHomePage({
		List<Output>? output,
	}) = _DripHomePage;

	factory DripHomePage.fromJson(Map<String, dynamic> json) => _$DripHomePageFromJson(json);
}