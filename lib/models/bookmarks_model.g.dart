// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      id: json['id'] as String,
      userId: json['uid'] as String,
      historyId: json['hid'] as String,
      savedAt: DateTime.parse(json['savedat'] as String),
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.userId,
      'hid': instance.historyId,
      'savedat': instance.savedAt.toIso8601String(),
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
