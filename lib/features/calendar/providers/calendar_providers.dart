import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/calendar/data/calendar_repository.dart';
import 'package:anime_time/features/calendar/data/models/calendar_episode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository(
    ref.watch(graphqlClientProvider),
    ref.watch(appDatabaseProvider).favoriteAnimeAccessor,
  );
});

/// Émet un nouveau calendrier dès que les favoris locaux changent.
final calendarEpisodesProvider = StreamProvider<List<CalendarEpisode>>((ref) {
  return ref.watch(calendarRepositoryProvider).watchUpcomingEpisodes();
});
