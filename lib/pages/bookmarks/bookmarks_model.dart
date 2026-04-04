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
