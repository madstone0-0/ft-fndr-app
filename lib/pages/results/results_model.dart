import 'dart:io';

import 'package:ft_fndr_app/components/result_card_model.dart';
import 'package:ft_fndr_app/models/search_repo.dart';
import 'package:ft_fndr_app/services/Locator.dart';
import '../../components/FilterChip_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'results_widget.dart';
import 'package:flutter/material.dart';

enum ResultsStatus {
  initial,
  loadingImages,
  imagesLoaded,
  loadingWebPages,
  webPagesLoaded,
  error,
}

class ResultsModel extends FlutterFlowModel<ResultsWidget> {
  final _repo = getIt<SearchRepository>();

  late FilterChipModel filterChipModel1;
  late FilterChipModel filterChipModel2;

  List<ResultCardModel> resultCardModels = [];

  ResultsStatus status = ResultsStatus.initial;
  List<SimilarImageResult> imageResults = [];
  List<WebPageResult> webPageResults = [];
  String? selectedImageUrl;
  String? errorMessage;

  Future<void> search(BuildContext context, String imageFilePath) async {
    status = ResultsStatus.loadingImages;
    errorMessage = null;

    try {
      imageResults = await _repo.searchByImage(File(imageFilePath));
      webPageResults = [];
      selectedImageUrl = null;
      _initResultCardModels(context, imageResults.length);
      status = ResultsStatus.imagesLoaded;
    } catch (e) {
      errorMessage = e.toString();
      status = ResultsStatus.error;
    }
  }

  Future<void> selectImageAndLoadWebPages(
      BuildContext context,
      String imageUrl,
      ) async {
    status = ResultsStatus.loadingWebPages;
    errorMessage = null;
    selectedImageUrl = imageUrl;

    try {
      webPageResults = await _repo.getWebPagesForImage(imageUrl);
      _initResultCardModels(context, webPageResults.length);
      status = ResultsStatus.webPagesLoaded;
    } catch (e) {
      errorMessage = e.toString();
      status = ResultsStatus.error;
    }
  }

  Future<void> retry(BuildContext context, String imageFilePath) async {
    if (selectedImageUrl != null &&
        status != ResultsStatus.imagesLoaded &&
        webPageResults.isEmpty) {
      await selectImageAndLoadWebPages(context, selectedImageUrl!);
      return;
    }

    await search(context, imageFilePath);
  }

  void resetToImageSelection(BuildContext context) {
    webPageResults = [];
    selectedImageUrl = null;
    _initResultCardModels(context, imageResults.length);
    status = ResultsStatus.imagesLoaded;
  }

  void _initResultCardModels(BuildContext context, int count) {
    for (final m in resultCardModels) {
      m.dispose();
    }
    resultCardModels = List.generate(
      count,
          (_) => createModel(context, () => ResultCardModel()),
    );
  }

  @override
  void initState(BuildContext context) {
    filterChipModel1 = createModel(context, () => FilterChipModel());
    filterChipModel2 = createModel(context, () => FilterChipModel());
  }

  @override
  void dispose() {
    filterChipModel1.dispose();
    filterChipModel2.dispose();
    for (final m in resultCardModels) {
      m.dispose();
    }
  }
}
