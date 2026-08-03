import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/core/graphql/graphql_client_provider.dart';
import 'package:anime_time/features/anime_detail_profile/data/anime_detail_profile_repository.dart';
import 'package:anime_time/features/anime_detail_profile/data/models/anime_detail_profile.dart';

final animeDetailProfileRepositoryProvider =
    Provider<AnimeDetailProfileRepository>((ref) {
      return AnimeDetailProfileRepository(ref.watch(graphqlClientProvider));
    });

final animeDetailProfileProvider = FutureProvider.autoDispose
    .family<AnimeDetailProfile, int>((ref, animeId) {
      return ref
          .watch(animeDetailProfileRepositoryProvider)
          .fetchAnimeDetail(animeId);
    });
