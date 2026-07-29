import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/features/discover/providers/discover_providers.dart';
import 'package:anime_time/features/discover/providers/discover_view_mode.dart';
import 'package:anime_time/features/discover/widgets/anime_grid.dart';
import 'package:anime_time/features/discover/widgets/discover_action_bar.dart';
import 'package:anime_time/features/discover/widgets/discover_list_view.dart';

const double kDiscoverHorizontalPadding = 0;

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
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
      ref.read(discoverNotifierProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoverNotifierProvider);

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
                      ref.read(discoverNotifierProvider.notifier).refresh(),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final viewMode = ref.watch(discoverViewModeProvider);

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          if (viewMode == DiscoverViewMode.grid)
            AnimeGrid(
              items: state.items,
              scrollController: _scrollController,
              isLoadingMore: state.isLoadingMore,
              topPadding: kDiscoverActionBarHeight,
              horizontalPadding: kDiscoverHorizontalPadding,
            )
          else
            DiscoverListView(
              items: state.items,
              scrollController: _scrollController,
              isLoadingMore: state.isLoadingMore,
              topPadding: kDiscoverActionBarHeight,
              horizontalPadding: kDiscoverHorizontalPadding,
            ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: DiscoverActionBar(
              horizontalPadding: kDiscoverHorizontalPadding,
            ),
          ),
        ],
      ),
    );
  }
}
