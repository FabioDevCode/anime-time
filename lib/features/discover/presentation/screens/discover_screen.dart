import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/anime_catalog/paginated_anime_catalog_screen.dart';
import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:anime_time/features/discover/providers/discover_providers.dart';
import 'package:anime_time/features/discover/routes/discover_filters_route.dart';
import 'package:anime_time/features/soon/providers/soon_providers.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedFilter = ref.watch(discoverAppliedFilterProvider);

    final catalogProvider = switch (appliedFilter.filter) {
      DiscoverFilter.none => discoverNotifierProvider,
      DiscoverFilter.soon => soonNotifierProvider,
    };

    return PaginatedAnimeCatalogScreen(
      key: ValueKey(appliedFilter),
      catalogProvider: catalogProvider,
      viewModeProvider: discoverViewModeProvider,
      isFilterActive: appliedFilter.hasActiveFilters,
      onFilter: () => context.push(DiscoverFiltersRoute.path),
    );
  }
}
