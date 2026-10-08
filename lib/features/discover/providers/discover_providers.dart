import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/catalog/providers/catalog_view_mode.dart';
import 'package:anime_time/common/catalog/providers/paginated_anime_catalog.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/discover/data/discover_repository.dart';
import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:anime_time/features/soon/data/soon_repository.dart';

final discoverRepositoryProvider = Provider<AnimeCatalogRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  final searchQuery = ref.watch(
    discoverAppliedFilterProvider.select((c) => c.searchQuery),
  );
  return DiscoverRepository(client, searchQuery: searchQuery);
});

final discoverNotifierProvider =
    NotifierProvider<PaginatedAnimeCatalogNotifier, PaginatedAnimeCatalogState>(
      () => PaginatedAnimeCatalogNotifier(
        discoverRepositoryProvider,
        debugLabel: 'DISCOVER',
      ),
    );

final discoverViewModeProvider =
    NotifierProvider<CatalogViewModeNotifier, CatalogViewMode>(
      CatalogViewModeNotifier.new,
    );

/// Repository Soon enrichi de la recherche textuelle issue des filtres appliqués.
/// Distinct de [soonRepositoryProvider] (dans soon_providers.dart) qui ne connaît
/// pas les critères de Découvrir.
final soonDiscoverRepositoryProvider = Provider<AnimeCatalogRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  final searchQuery = ref.watch(
    discoverAppliedFilterProvider.select((c) => c.searchQuery),
  );
  return SoonRepository(client, searchQuery: searchQuery);
});

final soonDiscoverNotifierProvider =
    NotifierProvider<PaginatedAnimeCatalogNotifier, PaginatedAnimeCatalogState>(
      () => PaginatedAnimeCatalogNotifier(
        soonDiscoverRepositoryProvider,
        debugLabel: 'SOON_DISCOVER',
      ),
    );
