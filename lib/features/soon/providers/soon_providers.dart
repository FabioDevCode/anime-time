import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/catalog/providers/catalog_view_mode.dart';
import 'package:anime_time/common/catalog/providers/paginated_anime_catalog.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/soon/data/soon_repository.dart';

final soonRepositoryProvider = Provider<AnimeCatalogRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return SoonRepository(client);
});

final soonNotifierProvider =
    NotifierProvider<PaginatedAnimeCatalogNotifier, PaginatedAnimeCatalogState>(
      () => PaginatedAnimeCatalogNotifier(
        soonRepositoryProvider,
        debugLabel: 'SOON',
      ),
    );

final soonViewModeProvider =
    NotifierProvider<CatalogViewModeNotifier, CatalogViewMode>(
      CatalogViewModeNotifier.new,
    );
