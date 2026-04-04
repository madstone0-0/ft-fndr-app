import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:json_annotation/json_annotation.dart';

part "history_model.g.dart";

@JsonSerializable()
class HistoryRequestBody {
  final User user;

  const HistoryRequestBody({required this.user});

  factory HistoryRequestBody.fromJson(Map<String, dynamic> json) => _$HistoryRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryRequestBodyToJson(this);
}

@JsonSerializable()
class HistoryItem {
  @JsonKey(name: 'hid')
  final String id;

  @JsonKey(name: 'uid')
  final String userId;

  @JsonKey(name: "vendorurl")
  final String vendorUrl;
  @JsonKey(name: "imageurl")
  final String imgUrl;
  @JsonKey(name: "createdat")
  final DateTime timestamp;

  const HistoryItem({
    required this.id,
    required this.userId,
    required this.vendorUrl,
    required this.imgUrl,
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
