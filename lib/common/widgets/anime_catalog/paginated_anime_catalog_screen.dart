import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/catalog/providers/catalog_view_mode.dart';
import 'package:anime_time/common/catalog/providers/paginated_anime_catalog.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_grid.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_list_view.dart';
import 'package:anime_time/common/widgets/anime_catalog/catalog_action_bar.dart';
import 'package:anime_time/features/anime_detail/routes/anime_detail_route.dart';

/// Écran réutilisable pour un catalogue AniList paginé.
///
/// Les features ne fournissent que leurs providers de données et de mode
/// d'affichage. Les interactions et le rendu restent ainsi strictement
/// identiques dans Discover et Soon.
class PaginatedAnimeCatalogScreen extends ConsumerStatefulWidget {
  const PaginatedAnimeCatalogScreen({
    super.key,
    required this.catalogProvider,
    required this.viewModeProvider,
    this.showSearch = true,
    this.showFilter = true,
  });

  final NotifierProvider<
    PaginatedAnimeCatalogNotifier,
    PaginatedAnimeCatalogState
  >
  catalogProvider;
  final NotifierProvider<CatalogViewModeNotifier, CatalogViewMode>
  viewModeProvider;
  final bool showSearch;
  final bool showFilter;

  @override
  ConsumerState<PaginatedAnimeCatalogScreen> createState() =>
      _PaginatedAnimeCatalogScreenState();
}

class _PaginatedAnimeCatalogScreenState
    extends ConsumerState<PaginatedAnimeCatalogScreen> {
  static const double _horizontalPadding = 0;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(widget.catalogProvider.notifier).loadNextPage();
    }
  }

  void _openAnimeDetail(AnimeMedia anime) {
    context.push(AnimeDetailRoute.location(anime.id));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.catalogProvider);

    if (state.isLoading) {
      return const SafeArea(
        bottom: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null && state.items.isEmpty) {
      return SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'Impossible de charger les anime',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () =>
                      ref.read(widget.catalogProvider.notifier).refresh(),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final viewMode = ref.watch(widget.viewModeProvider);

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          if (viewMode == CatalogViewMode.grid)
            AnimeGrid(
              items: state.items,
              scrollController: _scrollController,
              isLoadingMore: state.isLoadingMore,
              topPadding: kCatalogActionBarHeight,
              horizontalPadding: _horizontalPadding,
              onAnimeTap: _openAnimeDetail,
            )
          else
            AnimeListView(
              items: state.items,
              scrollController: _scrollController,
              isLoadingMore: state.isLoadingMore,
              topPadding: kCatalogActionBarHeight,
              horizontalPadding: _horizontalPadding,
              onAnimeTap: _openAnimeDetail,
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CatalogActionBar(
              viewMode: viewMode,
              onToggleViewMode: () =>
                  ref.read(widget.viewModeProvider.notifier).toggle(),
              horizontalPadding: _horizontalPadding,
              showSearch: widget.showSearch,
              showFilter: widget.showFilter,
            ),
          ),
        ],
      ),
    );
  }
}
