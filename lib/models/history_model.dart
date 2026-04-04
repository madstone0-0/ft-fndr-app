import 'package:json_annotation/json_annotation.dart';

part "history_model.g.dart";

@JsonSerializable()
class HistoryItem {
  final String id;

  @JsonKey(name: 'uid')
  final String userId;

  final String title;
  final String imgDesc;
  final DateTime timestamp;

  const HistoryItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.imgDesc,
    required this.timestamp,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) => _$HistoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryItemToJson(this);
}

@JsonSerializable()
class HistoryResponse {
  final String message;
  final List<HistoryItem> data;

  const HistoryResponse({required this.message, required this.data});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => _$HistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}
