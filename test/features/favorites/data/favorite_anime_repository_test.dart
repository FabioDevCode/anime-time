import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/data/favorite_anime_repository.dart';
import 'package:anime_time/features/favorites/data/models/favorite_anime_draft.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late FavoriteAnimeRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = FavoriteAnimeRepository(database.favoriteAnimeAccessor);
  });

  tearDown(() async {
    await database.close();
  });

  test('enregistre puis supprime un anime favori', () async {
    const anime = FavoriteAnimeDraft(
      animeId: 15125,
      titleRomaji: 'Teekyu',
      titleNative: 'てーきゅう',
      coverImage: 'https://example.com/cover.jpg',
      status: 'FINISHED',
      season: 'FALL',
      seasonYear: 2012,
    );

    expect(await repository.isFavorite(anime.animeId), isFalse);

    await repository.add(anime);

    expect(await repository.isFavorite(anime.animeId), isTrue);

    final storedAnime = await database
        .select(database.favoriteAnime)
        .getSingle();
    expect(storedAnime.animeId, anime.animeId);
    expect(storedAnime.titleRomaji, anime.titleRomaji);
    expect(storedAnime.titleEnglish, isNull);
    expect(storedAnime.titleNative, anime.titleNative);
    expect(storedAnime.coverImage, anime.coverImage);
    expect(storedAnime.bannerImage, isNull);
    expect(storedAnime.status, anime.status);
    expect(storedAnime.season, anime.season);
    expect(storedAnime.seasonYear, anime.seasonYear);

    await repository.remove(anime.animeId);

    expect(await repository.isFavorite(anime.animeId), isFalse);
  });
}
