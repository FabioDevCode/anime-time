# Drift (base de données locale)

La configuration Drift est centralisée ici :

- `database.dart` : point d'entrée et ouverture SQLite native de la base locale ;
- `tables/favorite_anime_table.dart` : schéma des anime favoris ;
- `accessors/favorite_anime_accessor.dart` : point d'extension `DatabaseAccessor`, sans logique métier pour l'instant.

Pour régénérer le code après une modification du schéma :

```bash
dart run build_runner build
```

`database.g.dart` est généré et doit être conservé dans le projet.
