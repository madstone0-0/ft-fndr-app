// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      id: json['bid'] as String,
      historyId: json['hid'] as String,
      savedAt: DateTime.parse(json['savedat'] as String),
      imgUrl: json['imageurl'] as String,
      domain: json['domain'] as String,
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'bid': instance.id,
      'hid': instance.historyId,
      'savedat': instance.savedAt.toIso8601String(),
      'imageurl': instance.imgUrl,
      'domain': instance.domain,
    };

BookmarksResponse _$BookmarksResponseFromJson(Map<String, dynamic> json) =>
    BookmarksResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Bookmark.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookmarksResponseToJson(BookmarksResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

CreateBookmarkRequest _$CreateBookmarkRequestFromJson(
        Map<String, dynamic> json) =>
    CreateBookmarkRequest(
      historyId: json['historyId'] as String,
    );

Map<String, dynamic> _$CreateBookmarkRequestToJson(
        CreateBookmarkRequest instance) =>
    <String, dynamic>{
      'historyId': instance.historyId,
    };
