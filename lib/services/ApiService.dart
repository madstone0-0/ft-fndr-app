import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: "https://ft-fndr-1093fdee573a.herokuapp.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/")
  @MultiPart()
  Future<SearchResponse> searchForVisuallySimilarImages({
    @Part(name: "file") required MultipartFile file,
  });
}

@JsonSerializable()
class SearchResponse {
  final String message;
  final List<String> data;

  SearchResponse({required this.message, required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
