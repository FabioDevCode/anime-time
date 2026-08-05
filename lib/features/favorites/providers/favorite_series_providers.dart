import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/favorites/services/favorite_series_service.dart';

final favoriteSeriesServiceProvider = Provider<FavoriteSeriesService>((ref) {
  return FavoriteSeriesService(
    ref.watch(graphqlClientProvider),
    ref.watch(appDatabaseProvider),
  );
});
