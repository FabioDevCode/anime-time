import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/calendar/data/calendar_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test(
    'uses only releasing Drift favorites and sorts their upcoming episodes',
    () async {
      await database
          .into(database.favoriteAnime)
          .insert(
            const FavoriteAnimeCompanion(
              animeId: Value(10),
              status: Value('RELEASING'),
            ),
          );
      await database
          .into(database.favoriteAnime)
          .insert(
            const FavoriteAnimeCompanion(
              animeId: Value(20),
              status: Value('FINISHED'),
            ),
          );
      await database
          .into(database.favoriteAnime)
          .insert(
            const FavoriteAnimeCompanion(
              animeId: Value(12),
              status: Value('RELEASING'),
            ),
          );

      final requests = <Map<String, dynamic>>[];
      final repository = CalendarRepository(
        _clientFor(requests),
        database.favoriteAnimeAccessor,
        now: () => DateTime.fromMillisecondsSinceEpoch(1000 * 1000).toLocal(),
      );

      final episodes = await repository.watchUpcomingEpisodes().first;

      expect(requests, [
        {
          'ids': [10, 12],
        },
      ]);
      expect(episodes.map((episode) => episode.animeId), [12, 10]);
      expect(episodes.map((episode) => episode.episode), [3, 5]);
      expect(episodes.first.title, 'Anime proche');
      expect(episodes.first.nativeTitle, '近いアニメ');
    },
  );
}

GraphQLClient _clientFor(List<Map<String, dynamic>> requests) {
  return GraphQLClient(
    link: Link.function((request, [forward]) {
      requests.add(Map<String, dynamic>.from(request.variables));
      return Stream.value(
        const Response(
          data: {
            '__typename': 'Query',
            'Page': {
              '__typename': 'Page',
              'media': [
                {
                  '__typename': 'Media',
                  'id': 10,
                  'status': 'RELEASING',
                  'title': {
                    '__typename': 'MediaTitle',
                    'romaji': 'Anime éloigné',
                    'native': null,
                  },
                  'coverImage': {
                    '__typename': 'MediaCoverImage',
                    'large': 'https://example.test/10.jpg',
                  },
                  'bannerImage': null,
                  'nextAiringEpisode': {
                    '__typename': 'AiringSchedule',
                    'episode': 5,
                    'airingAt': 3000,
                    'timeUntilAiring': 2000,
                  },
                },
                {
                  '__typename': 'Media',
                  'id': 12,
                  'status': 'RELEASING',
                  'title': {
                    '__typename': 'MediaTitle',
                    'romaji': 'Anime proche',
                    'native': '近いアニメ',
                  },
                  'coverImage': {
                    '__typename': 'MediaCoverImage',
                    'large': 'https://example.test/12.jpg',
                  },
                  'bannerImage': 'https://example.test/12-banner.jpg',
                  'nextAiringEpisode': {
                    '__typename': 'AiringSchedule',
                    'episode': 3,
                    'airingAt': 2000,
                    'timeUntilAiring': 1000,
                  },
                },
              ],
            },
          },
          response: {},
        ),
      );
    }),
    cache: GraphQLCache(),
  );
}
