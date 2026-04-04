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

  const HistoryItemData({required this.imgDesc, required this.title, required this.timestamp});
}

enum SearchHistoryStatus { initial, loading, success, error }

class SearchHistoryModel extends FlutterFlowModel<SearchHistoryWidget> {
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  SearchHistoryStatus status = SearchHistoryStatus.initial;
  List<HistoryGroup> historyGroups = [];
  String? errorMessage;

  List<HistoryItemModel> historyItemModels = [];

  Future<void> loadHistory() async {
    status = SearchHistoryStatus.loading;
    try {
      historyGroups = [
        const HistoryGroup(label: 'Today', items: [
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/traditional%20ghanaian%20kente%20fabric%20stole',
            title: 'Kente Graduation Stole',
            timestamp: '10:45 AM',
          ),
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/brown%20leather%20chelsea%20boots%20fashion',
            title: 'Leather Chelsea Boots',
            timestamp: '09:12 AM',
          ),
        ]),
        const HistoryGroup(label: 'Yesterday', items: [
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/colorful%20african%20dashiki%20shirt',
            title: 'Dashiki Print Shirt',
            timestamp: 'Oct 23, 4:20 PM',
          ),
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/simple%20gold%20band%20ring%20jewelry',
            title: 'Minimalist Gold Ring',
            timestamp: 'Oct 23, 11:05 AM',
          ),
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/blue%20denim%20jacket%20with%20embroidery',
            title: 'Denim Jacket with Patches',
            timestamp: 'Oct 23, 08:30 AM',
          ),
        ]),
        const HistoryGroup(label: 'Earlier this week', items: [
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/handmade%20african%20straw%20basket%20bag',
            title: 'Woven Straw Bag',
            timestamp: 'Oct 21, 2:15 PM',
          ),
          HistoryItemData(
            imgDesc: 'https://dimg.dreamflow.cloud/v1/image/white%20linen%20dress%20fashion',
            title: 'Linen Summer Dress',
            timestamp: 'Oct 20, 5:40 PM',
          ),
        ]),
      ];
      status = SearchHistoryStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = SearchHistoryStatus.error;
    }
  }

  int get totalItemCount => historyGroups.fold(0, (sum, group) => sum + group.items.length);

  void initHistoryItemModels(BuildContext context) {
    for (final m in historyItemModels) {
      m.dispose();
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
