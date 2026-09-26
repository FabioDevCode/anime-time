import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/features/watching/data/models/watching_series_item.dart';
import 'package:anime_time/features/watching/data/watching_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchingRepositoryProvider = Provider<WatchingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return WatchingRepository(
    db.favoriteAnimeAccessor,
    db.favoriteSeriesAccessor,
  );
});

final watchingItemsProvider = StreamProvider<List<WatchingSeriesItem>>((ref) {
  return ref.watch(watchingRepositoryProvider).watchWatchingItems();
});
