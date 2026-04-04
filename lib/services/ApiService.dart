import 'package:dio/dio.dart';
import 'package:ft_fndr_app/models/auth_models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiService.g.dart';

// Routes
 const String loginRoute = "/auth/login";
 const String signupRoute = "/auth/signup";
 const String logoutRoute = "/auth/logout";
 const String profileRoute = "/auth/profile";

@RestApi(baseUrl: "https://ft-fndr-1093fdee573a.herokuapp.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/")
  @MultiPart()
  Future<SearchResponse> searchForVisuallySimilarImages({
    @Part(name: "file") required MultipartFile file,
  });

  @POST(loginRoute)
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST(signupRoute)
  Future<AuthResponse> signup(@Body() SignupRequest request);

  @POST(logoutRoute)
  Future<void> logout();

  @GET(profileRoute)
  Future<User> getProfile();
}

@JsonSerializable()
class SearchResponse {
  final String message;
  final List<String> data;

  SearchResponse({required this.message, required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
