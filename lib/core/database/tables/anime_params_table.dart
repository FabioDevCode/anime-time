import 'package:drift/drift.dart';

/// Paramètres globaux liés aux anime — une seule ligne attendue (id fixe).
class AnimeParams extends Table {
  IntColumn get id => integer()();

  /// Horodatage de la dernière synchronisation des favoris.
  DateTimeColumn get lastFavoritesSync => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
