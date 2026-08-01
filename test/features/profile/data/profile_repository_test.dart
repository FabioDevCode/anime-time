import 'dart:async';

import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/data/favorite_anime_repository.dart';
import 'package:anime_time/features/favorites/data/models/favorite_anime_draft.dart';
import 'package:anime_time/features/profile/data/profile_repository.dart';
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
    profileRepository = ProfileRepository(database.favoriteAnimeAccessor);
  });

  tearDown(() async {
    await database.close();
  });

  test('calcule les statistiques et filtre les listes depuis Drift', () async {
    await favoriteRepository.add(
      const FavoriteAnimeDraft(
        animeId: 1,
        coverImage: 'https://example.com/releasing.jpg',
        status: 'RELEASING',
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

    expect(profileData.statistics.totalFavorites, 4);
    expect(profileData.statistics.releasing, 1);
    expect(profileData.statistics.upcoming, 1);
    expect(profileData.favorites.map((anime) => anime.id), [1, 2]);
    expect(profileData.upcoming.map((anime) => anime.id), [3]);
    expect(profileData.favorites.map((anime) => anime.coverImageLarge), [
      'https://example.com/releasing.jpg',
      'https://example.com/finished.jpg',
    ]);
  });

  test('réémet les données lorsque les favoris locaux changent', () async {
    final updates = StreamIterator(profileRepository.watchProfileData());
    addTearDown(updates.cancel);

    expect(await updates.moveNext(), isTrue);
    expect(updates.current.statistics.totalFavorites, 0);

    await favoriteRepository.add(
      const FavoriteAnimeDraft(animeId: 5, status: 'RELEASING'),
    );

    expect(await updates.moveNext(), isTrue);
    expect(updates.current.statistics.totalFavorites, 1);
    expect(updates.current.statistics.releasing, 1);
    expect(updates.current.favorites.single.id, 5);
  });
}
