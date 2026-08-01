part of '../database.dart';

/// Point d'extension pour les futures requêtes liées aux anime favoris.
///
/// Aucun accès métier n'est défini à cette étape : l'accessor prépare seulement
/// l'API Drift moderne autour de [DatabaseAccessor].
@DriftAccessor(tables: [FavoriteAnime])
class FavoriteAnimeAccessor extends DatabaseAccessor<AppDatabase>
    with _$FavoriteAnimeAccessorMixin {
  FavoriteAnimeAccessor(super.attachedDatabase);
}
