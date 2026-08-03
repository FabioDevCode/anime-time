import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/calendar/data/graphql/calendar_anime_query.dart';
import 'package:anime_time/features/calendar/data/models/calendar_episode.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Construit le calendrier à partir des favoris locaux et des horaires AniList.
///
/// Drift décide quels anime font partie du calendrier. AniList est uniquement
/// interrogé pour compléter ces favoris avec leur prochain épisode.
class CalendarRepository {
  CalendarRepository(
    this._client,
    this._favoriteAnimeAccessor, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final GraphQLClient _client;
  final FavoriteAnimeAccessor _favoriteAnimeAccessor;
  final DateTime Function() _now;

  Stream<List<CalendarEpisode>> watchUpcomingEpisodes() async* {
    await for (final favorites in _favoriteAnimeAccessor.watchReleasing()) {
      yield await _fetchUpcomingEpisodes(favorites);
    }
  }

  Future<List<CalendarEpisode>> _fetchUpcomingEpisodes(
    List<FavoriteAnimeData> favorites,
  ) async {
    final ids = favorites.map((favorite) => favorite.animeId).toList();
    if (ids.isEmpty) return const [];
    final favoriteIds = ids.toSet();

    final result = await _client.query(
      QueryOptions(
        document: calendarAnimeQuery,
        variables: {'ids': ids},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final page = result.data?['Page'] as Map<String, dynamic>?;
    if (page == null) throw Exception('Invalid response structure');

    final now = _now();
    final media = (page['media'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>();

    return media
        .map(_toCalendarEpisode)
        .whereType<CalendarEpisode>()
        .where((episode) => favoriteIds.contains(episode.animeId))
        .where((episode) => !episode.airingAt.isBefore(now))
        .toList()
      ..sort((first, second) => first.airingAt.compareTo(second.airingAt));
  }

  CalendarEpisode? _toCalendarEpisode(Map<String, dynamic> media) {
    final id = media['id'] as int?;
    final title = media['title'] as Map<String, dynamic>?;
    final coverImage = media['coverImage'] as Map<String, dynamic>?;
    final nextAiringEpisode =
        media['nextAiringEpisode'] as Map<String, dynamic>?;
    final episode = nextAiringEpisode?['episode'] as int?;
    final airingAt = nextAiringEpisode?['airingAt'] as int?;

    if (id == null || episode == null || airingAt == null) return null;

    final romaji = title?['romaji'] as String?;
    final nativeTitle = title?['native'] as String?;

    return CalendarEpisode(
      animeId: id,
      title: romaji ?? nativeTitle ?? 'Titre indisponible',
      nativeTitle: nativeTitle,
      coverImage: (coverImage?['large'] as String?) ?? '',
      bannerImage: media['bannerImage'] as String?,
      episode: episode,
      airingAt: DateTime.fromMillisecondsSinceEpoch(airingAt * 1000).toLocal(),
    );
  }
}
