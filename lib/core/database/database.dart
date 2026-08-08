import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/anime_params_table.dart';
import 'tables/favorite_anime_table.dart';
import 'tables/favorite_series_table.dart';

part 'accessors/favorite_anime_accessor.dart';
part 'accessors/favorite_series_accessor.dart';
part 'database.g.dart';

/// Point d'entrée unique de la base de données locale de l'application.
@DriftDatabase(
  tables: [FavoriteAnime, FavoriteSeries, AnimeParams],
  daos: [FavoriteAnimeAccessor, FavoriteSeriesAccessor],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(favoriteSeries);
        await m.createTable(animeParams);
        await m.addColumn(favoriteAnime, favoriteAnime.seriesId);
        await m.addColumn(favoriteAnime, favoriteAnime.seasonNumber);
        await m.addColumn(favoriteAnime, favoriteAnime.episodes);
      }
      if (from < 3) {
        await m.addColumn(favoriteAnime, favoriteAnime.lastEpisodeWatched);
      }
      if (from < 4) {
        await m.addColumn(favoriteAnime, favoriteAnime.airedEpisodes);
      }
    },
  );

  static LazyDatabase _openConnection() => LazyDatabase(() async {
    final databaseDirectory = await getApplicationSupportDirectory();
    final databaseFile = File(
      path.join(databaseDirectory.path, 'anime_time.sqlite'),
    );

    // Android n'autorise pas SQLite à utiliser le répertoire /tmp par défaut.
    sqlite3.tempDirectory = (await getTemporaryDirectory()).path;

    return NativeDatabase.createInBackground(databaseFile);
  });
}
