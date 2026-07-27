import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/discover/data/discover_repository.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';

final discoverRepositoryProvider = Provider<DiscoverRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return DiscoverRepository(client);
});

// ---------------------------------------------------------------------------

class DiscoverState {
  const DiscoverState({
    this.items = const [],
    this.currentPage = 0,
    this.hasNextPage = true,
    this.isLoadingMore = false,
    this.isLoading = true,
    this.error,
  });

  final List<AnimeMedia> items;
  final int currentPage;
  final bool hasNextPage;
  final bool isLoadingMore;
  final bool isLoading;
  final String? error;

  DiscoverState copyWith({
    List<AnimeMedia>? items,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return DiscoverState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

// ---------------------------------------------------------------------------

class DiscoverNotifier extends Notifier<DiscoverState> {
  static const int _perPage = 24;

  @override
  DiscoverState build() {
    Future.microtask(_loadInitial);
    return const DiscoverState();
  }

  Future<void> _loadInitial() async {
    final repo = ref.read(discoverRepositoryProvider);
    try {
      final result = await repo.fetchRecentReleasingAnime(
        page: 1,
        perPage: _perPage,
      );
      state = state.copyWith(
        items: result.items,
        currentPage: result.currentPage,
        hasNextPage: result.hasNextPage,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ ERREUR DISCOVER: $e');
      }
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadNextPage() async {
    if (!state.hasNextPage || state.isLoadingMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);
    final repo = ref.read(discoverRepositoryProvider);
    try {
      final result = await repo.fetchRecentReleasingAnime(
        page: state.currentPage + 1,
        perPage: _perPage,
      );
      state = state.copyWith(
        items: [...state.items, ...result.items],
        currentPage: result.currentPage,
        hasNextPage: result.hasNextPage,
        isLoadingMore: false,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> refresh() async {
    state = const DiscoverState();
    await _loadInitial();
  }
}

final discoverNotifierProvider =
    NotifierProvider<DiscoverNotifier, DiscoverState>(DiscoverNotifier.new);
