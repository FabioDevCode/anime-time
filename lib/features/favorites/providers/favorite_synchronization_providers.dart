import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/features/favorites/providers/favorite_series_providers.dart';
import 'package:anime_time/features/favorites/services/favorite_synchronization_service.dart';

final favoriteSynchronizationServiceProvider =
    Provider<FavoriteSynchronizationService>((ref) {
      return FavoriteSynchronizationService(
        ref.watch(appDatabaseProvider),
        ref.watch(favoriteSeriesServiceProvider),
      );
    });
