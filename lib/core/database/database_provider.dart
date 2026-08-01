import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';

/// Instance unique de la base locale pour la durée de vie de l'application.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  ref.onDispose(() {
    database.close();
  });

  return database;
});
