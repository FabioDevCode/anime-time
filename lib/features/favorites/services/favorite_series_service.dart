import 'package:drift/drift.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/favorites/data/graphql/anime_serie_query.dart';
import 'package:anime_time/features/favorites/data/models/anime_serie_node.dart';

class FavoriteSeriesService {
  const FavoriteSeriesService(this._client, this._database);

  final GraphQLClient _client;
  final AppDatabase _database;

  Future<void> addFavoriteAnime(int animeId) async {
    final seasons = await _discoverSeries(animeId);
    final ordered = _orderSeries(seasons);
    final seriesId = await _saveSeries(ordered);
    await _saveSeasons(ordered, seriesId);
  }

  Future<List<AnimeSerieNode>> _discoverSeries(int startAnimeId) async {
    final visited = <int>{};
    final toVisit = [startAnimeId];
    final result = <AnimeSerieNode>[];

    while (toVisit.isNotEmpty) {
      final id = toVisit.removeAt(0);
      if (visited.contains(id)) continue;
      visited.add(id);

      final node = await _fetchAnimeSerie(id);
      result.add(node);

      for (final relation in node.relations) {
        if (!visited.contains(relation.nodeId) &&
            (relation.relationType == 'PREQUEL' ||
                relation.relationType == 'SEQUEL') &&
            relation.nodeFormat == 'TV') {
          toVisit.add(relation.nodeId);
        }
      }
    }

    return result;
  }

  Future<AnimeSerieNode> _fetchAnimeSerie(int id) async {
    final result = await _client.query(
      QueryOptions(
        document: animeSerieQuery,
        variables: {'id': id},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final media = result.data?['Media'];
    if (media is! Map<String, dynamic>) {
      throw Exception('Anime introuvable ou réponse AniList invalide.');
    }

    return AnimeSerieNode.fromJson(media);
  }

  List<AnimeSerieNode> _orderSeries(List<AnimeSerieNode> seasons) {
    if (seasons.length <= 1) return seasons;

    final byId = {for (final s in seasons) s.id: s};

    // La première saison est celle sans PREQUEL TV appartenant au set découvert.
    AnimeSerieNode? first;
    for (final season in seasons) {
      final hasKnownPrequel = season.relations.any(
        (r) =>
            r.relationType == 'PREQUEL' &&
            r.nodeFormat == 'TV' &&
            byId.containsKey(r.nodeId),
      );
      if (!hasKnownPrequel) {
        first = season;
        break;
      }
    }
    first ??= seasons.first;

    final ordered = <AnimeSerieNode>[];
    AnimeSerieNode? current = first;
    final seen = <int>{};

    while (current != null && !seen.contains(current.id)) {
      ordered.add(current);
      seen.add(current.id);

      final sequelId = current.relations
          .where(
            (r) =>
                r.relationType == 'SEQUEL' &&
                r.nodeFormat == 'TV' &&
                byId.containsKey(r.nodeId),
          )
          .map((r) => r.nodeId)
          .firstOrNull;

      current = sequelId != null ? byId[sequelId] : null;
    }

    return ordered;
  }

  Future<int> _saveSeries(List<AnimeSerieNode> ordered) async {
    if (ordered.isEmpty) throw Exception('Série vide.');

    final first = ordered.first;
    final latest = ordered.last;
    final animeIds = ordered.map((s) => s.id).toList();

    // Cherche si l'un des anime de la série a déjà un seriesId en base.
    final existingRows = await (_database.select(
      _database.favoriteAnime,
    )..where((t) => t.animeId.isIn(animeIds) & t.seriesId.isNotNull())).get();
    final existingSeriesId = existingRows
        .map((r) => r.seriesId)
        .whereType<int>()
        .firstOrNull;

    final companion = FavoriteSeriesCompanion(
      displayTitleRomaji: Value(first.titleRomaji),
      displayTitleEnglish: Value(first.titleEnglish),
      displayTitleNative: Value(first.titleNative),
      latestAnimeId: Value(latest.id),
    );

    if (existingSeriesId != null) {
      await _database.favoriteSeriesAccessor.updateSeries(
        existingSeriesId,
        companion,
      );
      return existingSeriesId;
    }

    return _database.favoriteSeriesAccessor.insertSeries(companion);
  }

  Future<void> _saveSeasons(List<AnimeSerieNode> ordered, int seriesId) async {
    for (var i = 0; i < ordered.length; i++) {
      final season = ordered[i];
      await _database.favoriteAnimeAccessor.upsert(
        FavoriteAnimeCompanion(
          animeId: Value(season.id),
          seriesId: Value(seriesId),
          seasonNumber: Value(i + 1),
          titleRomaji: Value(season.titleRomaji),
          titleEnglish: Value(season.titleEnglish),
          titleNative: Value(season.titleNative),
          coverImage: Value(season.coverImage),
          bannerImage: Value(season.bannerImage),
          episodes: Value(season.episodes),
          status: Value(season.status),
          season: Value(season.season),
          seasonYear: Value(season.seasonYear),
        ),
      );
    }
  }

  /// Rafraîchit une série existante : rebuild complet si nouvelle saison, sinon metadata seule.
  Future<void> refreshSeries(int seriesId, int latestAnimeId) async {
    final seasons = await _discoverSeries(latestAnimeId);
    final ordered = _orderSeries(seasons);

    final knownRows = await (_database.select(
      _database.favoriteAnime,
    )..where((t) => t.seriesId.equals(seriesId))).get();
    final knownIds = knownRows.map((r) => r.animeId).toSet();
    final discoveredIds = ordered.map((s) => s.id).toSet();

    if (discoveredIds.difference(knownIds).isNotEmpty) {
      await _saveSeries(ordered);
      await _saveSeasons(ordered, seriesId);
    } else {
      await _updateSeasonMetadata(ordered, knownRows);
    }
  }

  Future<void> _updateSeasonMetadata(
    List<AnimeSerieNode> ordered,
    List<FavoriteAnimeData> existing,
  ) async {
    final existingById = {for (final r in existing) r.animeId: r};

    for (final season in ordered) {
      final row = existingById[season.id];
      if (row == null || !_hasMetadataChanged(season, row)) continue;

      await (_database.update(
        _database.favoriteAnime,
      )..where((t) => t.animeId.equals(season.id))).write(
        FavoriteAnimeCompanion(
          titleRomaji: Value(season.titleRomaji),
          titleEnglish: Value(season.titleEnglish),
          titleNative: Value(season.titleNative),
          coverImage: Value(season.coverImage),
          bannerImage: Value(season.bannerImage),
          episodes: Value(season.episodes),
          status: Value(season.status),
          season: Value(season.season),
          seasonYear: Value(season.seasonYear),
        ),
      );
    }
  }

  bool _hasMetadataChanged(AnimeSerieNode node, FavoriteAnimeData row) {
    return node.titleRomaji != row.titleRomaji ||
        node.titleEnglish != row.titleEnglish ||
        node.titleNative != row.titleNative ||
        node.coverImage != row.coverImage ||
        node.bannerImage != row.bannerImage ||
        node.episodes != row.episodes ||
        node.status != row.status ||
        node.season != row.season ||
        node.seasonYear != row.seasonYear;
  }
}
