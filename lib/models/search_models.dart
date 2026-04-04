import 'package:json_annotation/json_annotation.dart';
part "search_models.g.dart";

@JsonSerializable()
class SearchResponse {
  final String message;
  final List<String> data;

  const SearchResponse({required this.message, required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
