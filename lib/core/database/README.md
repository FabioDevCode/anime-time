# Drift (base de données locale)

Ce dossier accueillera la configuration de drift (AppDatabase, tables, DAOs).

## Prérequis pour activer drift

drift nécessite Dart >=3.10.0 (Flutter >=3.38.0).

Pour activer :
1. Lancer `flutter upgrade` pour obtenir Flutter 3.38.0+
2. Décommenter dans `pubspec.yaml` :
   ```yaml
   drift: ^2.34.2
   sqlite3_flutter_libs: ^0.5.0
   drift_dev: any
   build_runner: ^2.4.0
   ```
3. Lancer `flutter pub get`
4. Créer `lib/core/database/app_database.dart` avec les tables
5. Lancer `dart run build_runner build`
