import 'package:ft_fndr_app/models/history_model.dart';
import 'package:ft_fndr_app/pages/search_history/search_history_model.dart';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:ft_fndr_app/services/Locator.dart';

class HistoryRepository {
  final ApiService api;
  final authNotifier = getIt<AuthNotifier>();

  HistoryRepository(this.api);

  Future<List<HistoryGroup>> getGroupedHistory() async {
    final response = await api.getHistory();
    return _groupByDate(response.data);
  }

  Future<void> deleteHistoryItem(String historyId) async {
    await api.deleteHistoryItem(historyId);
  }

  Future<void> clearHistory() async {
    await api.clearHistory();
  }

  // ── Grouping logic ────────────────────────────────────────────────────────

  List<HistoryGroup> _groupByDate(List<HistoryItem> items) {
    if (items.isEmpty) return [];

    // Sort newest first
    final sorted = [...items]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    // Bucket items by label
    final Map<String, List<HistoryItem>> buckets = {};

    for (final item in sorted) {
      final label = _dateLabel(item.timestamp, today, yesterday, startOfWeek);
      buckets.putIfAbsent(label, () => []).add(item);
    }

    const labelOrder = ['Today', 'Yesterday', 'Earlier this week'];
    final orderedKeys = [
      ...labelOrder.where(buckets.containsKey),
      ...buckets.keys.where((k) => !labelOrder.contains(k)),
    ];

    return orderedKeys
        .map((label) => HistoryGroup(
      label: label,
      items: buckets[label]!.map(_toItemData).toList(),
    ))
        .toList();
  }

  String _dateLabel(
      DateTime timestamp,
      DateTime today,
      DateTime yesterday,
      DateTime startOfWeek,
      ) {
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    if (!date.isBefore(startOfWeek)) return 'Earlier this week';

    // Older items: group by "Month Year" e.g. "March 2025"
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[timestamp.month - 1]} ${timestamp.year}';
  }

  HistoryItemData _toItemData(HistoryItem item) {
    return HistoryItemData(
      imgDesc: item.imgUrl,
      title: item.vendorUrl,
      timestamp: _formatTimestamp(item.timestamp),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);

    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final timeStr = '$hour12:$minute $period';

    // Today → "10:45 AM"
    if (date == today) return timeStr;

    // Older → "Oct 23, 4:20 PM"
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[timestamp.month - 1]} ${timestamp.day}, $timeStr';
  }
}