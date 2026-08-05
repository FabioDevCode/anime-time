import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/features/favorites/data/favorite_anime_repository.dart';
import 'package:anime_time/features/favorites/providers/favorite_series_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteAnimeRepositoryProvider = Provider<FavoriteAnimeRepository>((
  ref,
) {
  return FavoriteAnimeRepository(
    ref.watch(appDatabaseProvider).favoriteAnimeAccessor,
  );
});

final favoriteAnimeControllerProvider = AsyncNotifierProvider.autoDispose
    .family<FavoriteAnimeController, FavoriteAnimeState, int>(
      FavoriteAnimeController.new,
    );

@immutable
class FavoriteAnimeState {
  const FavoriteAnimeState({
    required this.isFavorite,
    this.isProcessing = false,
  });

  final bool isFavorite;
  final bool isProcessing;

  FavoriteAnimeState copyWith({bool? isFavorite, bool? isProcessing}) {
    return FavoriteAnimeState(
      isFavorite: isFavorite ?? this.isFavorite,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

/// Contrôle l'état local d'un anime favori et bloque les actions concurrentes.
class FavoriteAnimeController extends AsyncNotifier<FavoriteAnimeState> {
  FavoriteAnimeController(this._animeId);

  final int _animeId;

  FavoriteAnimeRepository get _repository =>
      ref.read(favoriteAnimeRepositoryProvider);

  @override
  Future<FavoriteAnimeState> build() async {
    final isFavorite = await _repository.isFavorite(_animeId);
    return FavoriteAnimeState(isFavorite: isFavorite);
  }

  Future<bool> add() async {
    final current = state.asData?.value;
    if (current == null || current.isFavorite || current.isProcessing) {
      return false;
    }

    state = AsyncData(current.copyWith(isProcessing: true));

    try {
      await ref.read(favoriteSeriesServiceProvider).addFavoriteAnime(_animeId);
      if (!ref.mounted) {
        return false;
      }

      state = AsyncData(
        current.copyWith(isFavorite: true, isProcessing: false),
      );
      return true;
    } catch (_) {
      if (ref.mounted) {
        state = AsyncData(current.copyWith(isProcessing: false));
      }
      return false;
    }
  }

  Future<bool> remove() async {
    final current = state.asData?.value;
    if (current == null || !current.isFavorite || current.isProcessing) {
      return false;
    }

    state = AsyncData(current.copyWith(isProcessing: true));

    try {
      await _repository.remove(_animeId);
      if (!ref.mounted) {
        return false;
      }

      state = AsyncData(
        current.copyWith(isFavorite: false, isProcessing: false),
      );
      return true;
    } catch (_) {
      if (ref.mounted) {
        state = AsyncData(current.copyWith(isProcessing: false));
      }
      return false;
    }
  }
}
