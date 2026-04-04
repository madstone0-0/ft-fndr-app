import 'package:json_annotation/json_annotation.dart';

part "bookmarks_model.g.dart";
// ─── Bookmarks ────────────────────────────────────────────────────────────────

@JsonSerializable()
class Bookmark {
  final String id;

  @JsonKey(name: 'uid')
  final String userId;

  @JsonKey(name: 'hid')
  final String historyId;

  @JsonKey(name: 'savedat')
  final DateTime savedAt;

  const Bookmark({
    required this.id,
    required this.userId,
    required this.historyId,
    required this.savedAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}

@JsonSerializable()
class BookmarksResponse {
  final String message;
  final List<Bookmark> data;

  const BookmarksResponse({required this.message, required this.data});

  factory BookmarksResponse.fromJson(Map<String, dynamic> json) => _$BookmarksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarksResponseToJson(this);
}

@JsonSerializable()
class CreateBookmarkRequest {
  final String historyId;

  const CreateBookmarkRequest({required this.historyId});

  factory CreateBookmarkRequest.fromJson(Map<String, dynamic> json) => _$CreateBookmarkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBookmarkRequestToJson(this);
}
