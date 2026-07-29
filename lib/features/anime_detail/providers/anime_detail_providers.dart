import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/anime_detail/data/anime_detail_repository.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

final animeDetailRepositoryProvider = Provider<AnimeDetailRepository>((ref) {
  return AnimeDetailRepository(ref.watch(graphqlClientProvider));
});

final animeDetailProvider = FutureProvider.autoDispose.family<AnimeDetail, int>(
  (ref, animeId) {
    return ref.watch(animeDetailRepositoryProvider).fetchAnimeDetail(animeId);
  },
);
