import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ModelCacheManager extends CacheManager {
  static const key = 'modelCache';

  ModelCacheManager._()
      : super(Config(key, stalePeriod: const Duration(days: 30)));

  static final instance = ModelCacheManager._();
}
