import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.dart';

part 'drip_search_results.freezed.dart';
part 'drip_search_results.g.dart';

@freezed
class DripSearchResults with _$DripSearchResults {
	factory DripSearchResults({
		String? title,
		List<Item>? items,
	}) = _DripSearchResults;

	factory DripSearchResults.fromJson(Map<String, dynamic> json) => _$DripSearchResultsFromJson(json);
}