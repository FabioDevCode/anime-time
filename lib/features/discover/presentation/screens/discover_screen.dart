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
    final activeFilter = ref.watch(discoverActiveFilterProvider);

    final catalogProvider = switch (activeFilter) {
      DiscoverFilter.none => discoverNotifierProvider,
      DiscoverFilter.soon => soonNotifierProvider,
    };

    return PaginatedAnimeCatalogScreen(
      key: ValueKey(activeFilter),
      catalogProvider: catalogProvider,
      viewModeProvider: discoverViewModeProvider,
      isFilterActive: activeFilter != DiscoverFilter.none,
      onFilter: () => context.push(DiscoverFiltersRoute.path),
    );
  }
}
