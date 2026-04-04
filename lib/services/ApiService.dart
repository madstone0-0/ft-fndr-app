import 'package:dio/dio.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../models/bookmarks_model.dart';
import '../models/history_model.dart';
import '../models/search_models.dart';
import '../models/shared.dart';
part 'ApiService.g.dart';

// Routes
const String authBase = "/auth";
const String loginRoute = "$authBase/login";
const String signupRoute = "$authBase/register";
const String logoutRoute = "$authBase/logout";
const String profileRoute = "$authBase/profile";

const String bookmarkBase = "/bookmarks";
const String bookmarksGetRoute = "$bookmarkBase/";
const String bookmarksCreateRoute = "$bookmarkBase/";
const String bookmarksDeleteRoute = "$bookmarkBase/{id}";

const String historyBase = "/history";
const String historyGetRoute = "$historyBase/";
const String historyClearRoute = "$historyBase/clear";
const String historyDeleteRoute = "$historyBase/{id}";

const String searchRoute = "/search";

@RestApi(baseUrl: "https://ft-fndr-1093fdee573a.herokuapp.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Search
  @POST(searchRoute)
  @MultiPart()
  Future<SearchResponse> searchForVisuallySimilarImages({
    @Part(name: "file") required MultipartFile file,
  });

  // Auth
  @POST(loginRoute)
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST(signupRoute)
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST(logoutRoute)
  Future<void> logout();

  @GET(profileRoute)
  Future<User> getProfile();

  // Bookmarks
  @GET(bookmarksGetRoute)
  Future<BookmarksResponse> getBookmarks();

  @POST(bookmarksCreateRoute)
  Future<MessageResponse> createBookmark(@Body() CreateBookmarkRequest request);

  @DELETE(bookmarksDeleteRoute)
  Future<MessageResponse> deleteBookmark(@Path("id") String bookmarkId);

  // History
  @GET(historyGetRoute)
  Future<HistoryResponse> getHistory();

  @DELETE(historyDeleteRoute)
  Future<MessageResponse> deleteHistoryItem(@Path("id") String historyId);

  @POST(historyClearRoute)
  Future<MessageResponse> clearHistory();
}



