import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ft_fndr_app/models/search_models.dart';
import 'package:ft_fndr_app/services/ApiService.dart';

class SimilarImageResult {
  final String imageUrl;

  const SimilarImageResult({
    required this.imageUrl,
  });
}

class WebPageResult {
  final String imageUrl;
  final String pageUrl;
  final String domain;
  final String displayUrl;

  const WebPageResult({
    required this.imageUrl,
    required this.pageUrl,
    required this.domain,
    required this.displayUrl,
  });
}

class SearchRepository {
  final ApiService _api;

  SearchRepository(this._api);

  Future<List<SimilarImageResult>> searchByImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();

    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: imageFile.path.split('/').last,
    );

    final response = await _api.searchForVisuallySimilarImages(
      file: multipartFile,
    );

    return response.data.where((url) => url.isNotEmpty).map((url) => SimilarImageResult(imageUrl: url)).toList();
  }

  Future<List<WebPageResult>> getWebPagesForImage(String imageUrl) async {
    final response = await _api.searchWebPages(imageUrl);

    return response.data
        .where((url) => url.isNotEmpty)
        .map(
          (pageUrl) => WebPageResult(
            imageUrl: imageUrl,
            pageUrl: pageUrl,
            domain: _extractDomain(pageUrl),
            displayUrl: _toDisplayUrl(pageUrl),
          ),
        )
        .toList();
  }

  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
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
