import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ft_fndr_app/models/search_models.dart';
import 'package:ft_fndr_app/services/ApiService.dart';

class SearchResult {
  final String imageUrl;
  final String domain;
  final String displayUrl;

  const SearchResult({
    required this.imageUrl,
    required this.domain,
    required this.displayUrl,
  });
}

class SearchRepository {
  final ApiService _apiService;

  SearchRepository(this._apiService);

  Future<List<SearchResult>> searchByImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: imageFile.path.split('/').last,
    );

    final response = await _apiService.searchForVisuallySimilarImages(
      file: multipartFile,
    );

    return _toSearchResults(response);
  }

  List<SearchResult> _toSearchResults(SearchResponse response) {
    return response.data
        .where((url) => url.isNotEmpty)
        .map((url) => SearchResult(
      imageUrl: url,
      domain: _extractDomain(url),
      displayUrl: _toDisplayUrl(url),
    ))
        .toList();
  }

  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      // Strip www. prefix
      return uri.host.replaceFirst(RegExp(r'^www\.'), '');
    } catch (_) {
      return url;
    }
  }

  String _toDisplayUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return '${uri.scheme}://${uri.host}';
    } catch (_) {
      return url;
    }
  }
}