import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/anime_catalog/paginated_anime_catalog_screen.dart';
import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:anime_time/features/discover/providers/discover_providers.dart';
import 'package:anime_time/features/discover/routes/discover_filters_route.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedFilter = ref.watch(discoverAppliedFilterProvider);

    // Invalide le provider de catalogue actif à chaque changement de critères
    // pour forcer un rechargement avec les nouvelles données (recherche, filtre).
    ref.listen(discoverAppliedFilterProvider, (_, next) {
      final provider = switch (next.filter) {
        DiscoverFilter.none => discoverNotifierProvider,
        DiscoverFilter.soon => soonDiscoverNotifierProvider,
      };
      ref.invalidate(provider);
    });

    final catalogProvider = switch (appliedFilter.filter) {
      DiscoverFilter.none => discoverNotifierProvider,
      DiscoverFilter.soon => soonDiscoverNotifierProvider,
    };

    return PaginatedAnimeCatalogScreen(
      key: ValueKey(appliedFilter),
      catalogProvider: catalogProvider,
      viewModeProvider: discoverViewModeProvider,
      isFilterActive: appliedFilter.hasActiveFilters,
      onFilter: () => context.push(DiscoverFiltersRoute.path),
      onSearch: () => context.push(
        DiscoverFiltersRoute.path,
        extra: {'focusSearch': true},
      ),
      searchLabel: appliedFilter.searchQuery,
    );
  }
}
