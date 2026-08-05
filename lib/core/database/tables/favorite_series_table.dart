import 'package:drift/drift.dart';

/// Une ligne représente une série pouvant contenir plusieurs saisons.
class FavoriteSeries extends Table {
  IntColumn get seriesId => integer().autoIncrement()();

  /// Titres correspondant à la première saison de la série.
  TextColumn get displayTitleRomaji => text().nullable()();
  TextColumn get displayTitleEnglish => text().nullable()();
  TextColumn get displayTitleNative => text().nullable()();

  /// Toujours la saison avec le plus grand seasonNumber.
  IntColumn get latestAnimeId => integer()();
}
