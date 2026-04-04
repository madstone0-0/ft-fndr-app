import 'package:ft_fndr_app/models/history_repo.dart';
import 'package:ft_fndr_app/services/Locator.dart';

import '/components/history_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_history_widget.dart' show SearchHistoryWidget;
import 'package:flutter/material.dart';

class HistoryGroup {
  final String label;
  final List<HistoryItemData> items;

  const HistoryGroup({required this.label, required this.items});
}

class HistoryItemData {
  final String imgDesc;
  final String title;
  final String timestamp;

  const HistoryItemData({
    required this.imgDesc,
    required this.title,
    required this.timestamp,
  });
}

enum SearchHistoryStatus { initial, loading, success, error }

class SearchHistoryModel extends FlutterFlowModel<SearchHistoryWidget> {
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  final repo = getIt<HistoryRepository>();

  SearchHistoryStatus status = SearchHistoryStatus.initial;
  List<HistoryGroup> historyGroups = [];
  String? errorMessage;

  List<HistoryItemModel> historyItemModels = [];

  int get totalItemCount => historyGroups.fold(0, (sum, group) => sum + group.items.length);

  Future<void> loadHistory(BuildContext context) async {
    status = SearchHistoryStatus.loading;
    errorMessage = null;

    try {
      historyGroups = await repo.getGroupedHistory();
      _initHistoryItemModels(context);
      status = SearchHistoryStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = SearchHistoryStatus.error;
    }
  }

  Future<void> clearHistory(BuildContext context) async {
    status = SearchHistoryStatus.loading;
    errorMessage = null;

    try {
      await repo.clearHistory();
      historyGroups = [];
      _initHistoryItemModels(context);
      status = SearchHistoryStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = SearchHistoryStatus.error;
    }
  }

  void _initHistoryItemModels(BuildContext context) {
    for (final model in historyItemModels) {
      model.dispose();
    }

    historyItemModels = List.generate(
      totalItemCount,
      (_) => createModel(context, () => HistoryItemModel()),
    );
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    for (final model in historyItemModels) {
      model.dispose();
    }
  }
}
