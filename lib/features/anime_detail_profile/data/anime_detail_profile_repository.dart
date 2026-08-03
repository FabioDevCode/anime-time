import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/features/anime_detail_profile/data/graphql/anime_detail_profile_query.dart';
import 'package:anime_time/features/anime_detail_profile/data/models/anime_detail_profile.dart';

class AnimeDetailProfileRepository {
  const AnimeDetailProfileRepository(this._client);

  final GraphQLClient _client;

  Future<AnimeDetailProfile> fetchAnimeDetail(int id) async {
    final result = await _client.query(
      QueryOptions(
        document: animeDetailProfileQuery,
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

    return AnimeDetailProfile.fromJson(media);
  }
}
