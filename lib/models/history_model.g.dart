// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => HistoryItem(
      id: json['id'] as String,
      userId: json['uid'] as String,
      title: json['title'] as String,
      imgDesc: json['imgDesc'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$HistoryItemToJson(HistoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.userId,
      'title': instance.title,
      'imgDesc': instance.imgDesc,
      'timestamp': instance.timestamp.toIso8601String(),
    };

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
