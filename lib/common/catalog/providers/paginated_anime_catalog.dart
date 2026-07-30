import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/models/anime_media.dart';

class PaginatedAnimeCatalogState {
  const PaginatedAnimeCatalogState({
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

  PaginatedAnimeCatalogState copyWith({
    List<AnimeMedia>? items,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return PaginatedAnimeCatalogState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Contrôleur Riverpod commun aux catalogues Discover et Soon.
///
/// Chaque feature fournit simplement son repository ; toute la gestion de
/// pagination, de rafraîchissement et des états de chargement reste identique.
class PaginatedAnimeCatalogNotifier
    extends Notifier<PaginatedAnimeCatalogState> {
  PaginatedAnimeCatalogNotifier(
    this._repositoryProvider, {
    required this.debugLabel,
  });

  static const int _perPage = 24;

  final Provider<AnimeCatalogRepository> _repositoryProvider;
  final String debugLabel;

  @override
  PaginatedAnimeCatalogState build() {
    Future.microtask(_loadInitial);
    return const PaginatedAnimeCatalogState();
  }

  Future<void> _loadInitial() async {
    final repository = ref.read(_repositoryProvider);
    try {
      final result = await repository.fetchPage(page: 1, perPage: _perPage);
      state = state.copyWith(
        items: result.items,
        currentPage: result.currentPage,
        hasNextPage: result.hasNextPage,
        isLoading: false,
        clearError: true,
      );
    } catch (error) {
      if (kDebugMode) {
        debugPrint('❌ ERREUR $debugLabel: $error');
      }
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> loadNextPage() async {
    if (!state.hasNextPage || state.isLoadingMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);
    final repository = ref.read(_repositoryProvider);
    try {
      final result = await repository.fetchPage(
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
    state = const PaginatedAnimeCatalogState();
    await _loadInitial();
  }
}
