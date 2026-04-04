import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:workmanager/workmanager.dart';

class ImageCacheService {
  static const String taskIdentifier =
      'com.example.ftFndrApp.imageCacheCleanup';
  static const String taskName = 'image_cache_cleanup';

  static bool get _supportsBackgroundCleanup =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  static Future<void> initialize() async {
    if (!_supportsBackgroundCleanup) {
      return;
    }

    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    await Workmanager().registerPeriodicTask(
      taskIdentifier,
      taskName,
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(hours: 1),
      existingWorkPolicy: ExistingWorkPolicy.update,
      constraints: Constraints(
        networkType: NetworkType.notRequired,
        requiresBatteryNotLow: true,
      ),
    );
  }

  static Future<void> clearImageCache() async {
    await DefaultCacheManager().emptyCache();

    final imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    switch (task) {
      case ImageCacheService.taskName:
      case Workmanager.iOSBackgroundTask:
      case ImageCacheService.taskIdentifier:
        await ImageCacheService.clearImageCache();
        return true;
      default:
        return true;
    }
  });
}
