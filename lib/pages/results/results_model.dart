import 'dart:io';

import 'package:ft_fndr_app/components/result_card_model.dart';
import 'package:ft_fndr_app/models/history_repo.dart';
import 'package:ft_fndr_app/models/search_repo.dart';
import 'package:ft_fndr_app/services/Locator.dart';
import '../../components/FilterChip_model.dart';
import '/components/result_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'results_widget.dart';
import 'package:flutter/material.dart';

enum ResultsStatus { initial, loading, success, error }

class ResultsModel extends FlutterFlowModel<ResultsWidget> {
  final _repo = getIt<SearchRepository>();

  late FilterChipModel filterChipModel1;
  late FilterChipModel filterChipModel2;


  List<ResultCardModel> resultCardModels = [];

  ResultsStatus status = ResultsStatus.initial;
  List<SearchResult> results = [];
  String? errorMessage;

  Future<void> search(BuildContext context, String imageFilePath) async {
    status = ResultsStatus.loading;
    try {
      results = await _repo.searchByImage(File(imageFilePath));
      _initResultCardModels(context);
      status = ResultsStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = ResultsStatus.error;
    }
  }

  void _initResultCardModels(BuildContext context) {
    for (final m in resultCardModels) {
      m.dispose();
    }
    resultCardModels = List.generate(
      results.length,
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
