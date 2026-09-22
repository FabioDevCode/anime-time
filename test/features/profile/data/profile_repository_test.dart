import 'dart:async';

import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/data/favorite_anime_repository.dart';
import 'package:anime_time/features/favorites/data/models/favorite_anime_draft.dart';
import 'package:anime_time/features/profile/data/profile_repository.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late FavoriteAnimeRepository favoriteRepository;
  late ProfileRepository profileRepository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    favoriteRepository = FavoriteAnimeRepository(
      database.favoriteAnimeAccessor,
    );
    profileRepository = ProfileRepository(
      database.favoriteAnimeAccessor,
      database.favoriteSeriesAccessor,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('calcule les statistiques et filtre les listes depuis Drift', () async {
    final seriesId = await database.favoriteSeriesAccessor.insertSeries(
      FavoriteSeriesCompanion(
        latestAnimeId: const Value(1),
        displayTitleRomaji: const Value('Bleach'),
      ),
    );
    await database.favoriteAnimeAccessor.upsert(
      FavoriteAnimeCompanion(
        animeId: const Value(1),
        seriesId: Value(seriesId),
        coverImage: const Value('https://example.com/releasing.jpg'),
        status: const Value('RELEASING'),
      ),
    );
    await favoriteRepository.add(
      const FavoriteAnimeDraft(
        animeId: 2,
        coverImage: 'https://example.com/finished.jpg',
        status: 'FINISHED',
      ),
    );
    await favoriteRepository.add(
      const FavoriteAnimeDraft(
        animeId: 3,
        coverImage: 'https://example.com/upcoming.jpg',
        status: 'NOT_YET_RELEASED',
      ),
    );
    await favoriteRepository.add(
      const FavoriteAnimeDraft(animeId: 4, status: 'HIATUS'),
    );

    final profileData = await profileRepository.watchProfileData().first;

    expect(profileData.statistics.totalFavorites, 1);
    expect(profileData.statistics.releasing, 1);
    expect(profileData.statistics.upcoming, 1);
    expect(profileData.favorites.map((a) => a.id), [1, 2]);
    expect(profileData.upcoming.map((a) => a.id), [3]);
    expect(profileData.releasing.map((s) => s.seriesId), [seriesId]);
    expect(profileData.favorites.map((a) => a.coverImageLarge), [
      'https://example.com/releasing.jpg',
      'https://example.com/finished.jpg',
    ]);
  });

  test('dédoublonne les séries RELEASING dans le carousel', () async {
    final seriesId = await database.favoriteSeriesAccessor.insertSeries(
      FavoriteSeriesCompanion(latestAnimeId: const Value(2)),
    );
    for (final id in [1, 2]) {
      await database.favoriteAnimeAccessor.upsert(
        FavoriteAnimeCompanion(
          animeId: Value(id),
          seriesId: Value(seriesId),
          status: const Value('RELEASING'),
        ),
      );
    }

    final profileData = await profileRepository.watchProfileData().first;

    expect(profileData.statistics.releasing, 2);
    expect(profileData.releasing, hasLength(1));
    expect(profileData.releasing.single.seriesId, seriesId);
  });

  test('réémet les données lorsque les favoris locaux changent', () async {
    final updates = StreamIterator(profileRepository.watchProfileData());
    addTearDown(updates.cancel);

    expect(await updates.moveNext(), isTrue);
    expect(updates.current.statistics.totalFavorites, 0);
    expect(updates.current.releasing, isEmpty);

    final seriesId = await database.favoriteSeriesAccessor.insertSeries(
      FavoriteSeriesCompanion(latestAnimeId: const Value(5)),
    );
    // L'insertion de la série émet une mise à jour intermédiaire.
    expect(await updates.moveNext(), isTrue);

    await database.favoriteAnimeAccessor.upsert(
      FavoriteAnimeCompanion(
        animeId: const Value(5),
        seriesId: Value(seriesId),
        status: const Value('RELEASING'),
      ),
    );
    expect(await updates.moveNext(), isTrue);
    expect(updates.current.statistics.totalFavorites, 1);
    expect(updates.current.statistics.releasing, 1);
    expect(updates.current.releasing.single.seriesId, seriesId);
    expect(updates.current.favorites.single.id, 5);
  });
}
