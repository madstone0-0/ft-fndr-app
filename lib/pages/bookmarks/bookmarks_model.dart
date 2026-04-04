import '/components/bookmark_item_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart' hide BookmarksWidget;
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'bookmarks_widget.dart' show BookmarksWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:ft_fndr_app/models/bookmarks_model.dart';
import 'package:ft_fndr_app/models/history_model.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:ft_fndr_app/services/Locator.dart';

class BookmarkDisplayItem {
  final String id;
  final String historyId;
  final DateTime savedAt;
  final String title;
  final String imgDesc;

  const BookmarkDisplayItem({
    required this.id,
    required this.historyId,
    required this.savedAt,
    required this.title,
    required this.imgDesc,
  });

  String get savedLabel {
    final diff = DateTime.now().difference(savedAt);
    if (diff.inDays >= 1) {
      final d = diff.inDays;
      return 'Saved $d ${d == 1 ? 'day' : 'days'} ago';
    } else if (diff.inHours >= 1) {
      final h = diff.inHours;
      return 'Saved $h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    return 'Saved just now';
  }

  String get colourHex {
    const palette = ['#C5A073', '#8CAF7D', '#A1B4CF', '#D3A7C1', '#F0C27F', '#7DBFBF'];
    final index = historyId.codeUnits.fold(0, (sum, c) => sum + c) % palette.length;
    return palette[index];
  }
}

enum BookmarksStatus { initial, loading, success, empty, error }

class BookmarksModel extends FlutterFlowModel<BookmarksWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatCard component.
  late StatCardModel statCardModel1;
  // Model for StatCard component.
  late StatCardModel statCardModel2;
  // Model for StatCard component.
  late StatCardModel statCardModel3;
  // Model for BookmarkItem component.
  late BookmarkItemModel bookmarkItemModel1;
  // Model for BookmarkItem component.
  late BookmarkItemModel bookmarkItemModel2;
  // Model for BookmarkItem component.
  late BookmarkItemModel bookmarkItemModel3;
  // Model for BookmarkItem component.
  late BookmarkItemModel bookmarkItemModel4;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  String? get choiceChipsValue1 =>
      choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) =>
      choiceChipsValueController1?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  String? get choiceChipsValue2 =>
      choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) =>
      choiceChipsValueController2?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController4;
  String? get choiceChipsValue4 =>
      choiceChipsValueController4?.value?.firstOrNull;
  set choiceChipsValue4(String? val) =>
      choiceChipsValueController4?.value = val != null ? [val] : [];

  // API data state
  BookmarksStatus status = BookmarksStatus.initial;
  List<BookmarkDisplayItem> bookmarks = [];
  List<HistoryItem> historyItems = [];
  String? errorMessage;

  // Dynamic sub-models for the live bookmark list
  List<BookmarkItemModel> bookmarkItemModels = [];

  // Computed stats
  int get savedCount => bookmarks.length;
  int get sitesCount => bookmarks.map((b) => b.title).toSet().length;

  Future<void> loadBookmarks() async {
    status = BookmarksStatus.loading;
    errorMessage = null;

    try {
      final api = getIt<ApiService>();
      final results = await Future.wait([
        api.getBookmarks(),
        api.getHistory(),
      ]);

      final bookmarksResp = results[0] as BookmarksResponse;
      final historyResp = results[1] as HistoryResponse;

      historyItems = historyResp.data;
      final historyMap = {for (final h in historyResp.data) h.id: h};

      bookmarks = bookmarksResp.data.map((b) {
        final history = historyMap[b.historyId];
        return BookmarkDisplayItem(
          id: b.id,
          historyId: b.historyId,
          savedAt: b.savedAt,
          title: history?.title ?? 'Unknown item',
          imgDesc: history?.imgDesc ?? '',
        );
      }).toList();

      status = bookmarks.isEmpty ? BookmarksStatus.empty : BookmarksStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = BookmarksStatus.error;
    }
  }

  Future<bool> deleteBookmark(String bookmarkId) async {
    try {
      await getIt<ApiService>().deleteBookmark(bookmarkId);
      bookmarks.removeWhere((b) => b.id == bookmarkId);
      if (bookmarks.isEmpty) status = BookmarksStatus.empty;
      return true;
    } catch (_) {
      return false;
    }
  }

  void initBookmarkItemModels(BuildContext context) {
    for (final m in bookmarkItemModels) {
      m.dispose();
    }
    bookmarkItemModels = List.generate(
      bookmarks.length,
      (_) => createModel(context, () => BookmarkItemModel()),
    );
  }
  @override
  void initState(BuildContext context) {
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    statCardModel3 = createModel(context, () => StatCardModel());
    bookmarkItemModel1 = createModel(context, () => BookmarkItemModel());
    bookmarkItemModel2 = createModel(context, () => BookmarkItemModel());
    bookmarkItemModel3 = createModel(context, () => BookmarkItemModel());
    bookmarkItemModel4 = createModel(context, () => BookmarkItemModel());
  }

  @override
  void dispose() {
    statCardModel1.dispose();
    statCardModel2.dispose();
    statCardModel3.dispose();
    bookmarkItemModel1.dispose();
    bookmarkItemModel2.dispose();
    bookmarkItemModel3.dispose();
    bookmarkItemModel4.dispose();
  }
}
