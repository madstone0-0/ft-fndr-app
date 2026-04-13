// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryRequestBody _$HistoryRequestBodyFromJson(Map<String, dynamic> json) =>
    HistoryRequestBody(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoryRequestBodyToJson(HistoryRequestBody instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => HistoryItem(
      id: json['hid'] as String,
      userId: json['uid'] as String,
      vendorUrl: json['vendorurl'] as String,
      imgUrl: json['imageurl'] as String,
      timestamp: DateTime.parse(json['createdat'] as String),
      title: json['title'] as String,
    );

Map<String, dynamic> _$HistoryItemToJson(HistoryItem instance) =>
    <String, dynamic>{
      'hid': instance.id,
      'uid': instance.userId,
      'title': instance.title,
      'vendorurl': instance.vendorUrl,
      'imageurl': instance.imgUrl,
      'createdat': instance.timestamp.toIso8601String(),
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
