import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/favorite_anime_table.dart';

part 'accessors/favorite_anime_accessor.dart';
part 'database.g.dart';

/// Point d'entrée unique de la base de données locale de l'application.
@DriftDatabase(tables: [FavoriteAnime], daos: [FavoriteAnimeAccessor])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

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
