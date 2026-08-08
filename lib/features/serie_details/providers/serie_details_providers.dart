import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/serie_details/data/models/serie_graphql_info.dart';
import 'package:anime_time/features/serie_details/data/serie_details_repository.dart';

final serieDetailsRepositoryProvider = Provider<SerieDetailsRepository>((ref) {
  return SerieDetailsRepository(ref.watch(graphqlClientProvider));
});

final serieDetailsGraphqlProvider = FutureProvider.autoDispose
    .family<SerieGraphqlInfo?, int>((ref, latestAnimeId) async {
      try {
        return await ref
            .watch(serieDetailsRepositoryProvider)
            .fetchLatestSeasonInfo(latestAnimeId);
      } catch (_) {
        return null;
      }
    });

final serieStreamProvider = StreamProvider.autoDispose
    .family<FavoriteSery?, int>((ref, seriesId) {
      return ref
          .watch(appDatabaseProvider)
          .favoriteSeriesAccessor
          .watchById(seriesId);
    });

final seasonsStreamProvider = StreamProvider.autoDispose
    .family<List<FavoriteAnimeData>, int>((ref, seriesId) {
      return ref
          .watch(appDatabaseProvider)
          .favoriteAnimeAccessor
          .watchBySeriesId(seriesId);
    });
