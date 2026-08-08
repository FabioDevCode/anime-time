import 'dart:async';

import 'package:anime_time/common/models/series_media.dart';
import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/features/favorites/providers/favorite_synchronization_providers.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';
import 'package:anime_time/features/profile/data/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(
    ref.watch(appDatabaseProvider).favoriteAnimeAccessor,
  );
});

/// Flux unique pour le profil, alimenté uniquement par la base Drift locale.
final profileDataProvider = StreamProvider<ProfileData>((ref) {
  // Synchronisation journalière en arrière-plan, sans bloquer l'affichage.
  unawaited(
    ref.read(favoriteSynchronizationServiceProvider).synchronizeIfNeeded(),
  );
  return ref.watch(profileRepositoryProvider).watchProfileData();
});

final favoriteSeriesListProvider = StreamProvider<List<SeriesMedia>>((ref) {
  return ref
      .watch(appDatabaseProvider)
      .favoriteSeriesAccessor
      .watchAllWithCover()
      .map(
        (rows) => rows
            .map(
              (row) => SeriesMedia(
                seriesId: row.$1.seriesId,
                displayTitleRomaji: row.$1.displayTitleRomaji,
                displayTitleEnglish: row.$1.displayTitleEnglish,
                displayTitleNative: row.$1.displayTitleNative,
                latestAnimeId: row.$1.latestAnimeId,
                coverImage: row.$2,
              ),
            )
            .toList(),
      );
});
