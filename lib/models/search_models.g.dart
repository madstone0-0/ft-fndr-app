// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

WebPageSearchResponse _$WebPageSearchResponseFromJson(
        Map<String, dynamic> json) =>
    WebPageSearchResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WebPageSearchResponseToJson(
        WebPageSearchResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
