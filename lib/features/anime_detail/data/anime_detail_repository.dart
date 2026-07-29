import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/features/anime_detail/data/graphql/anime_details_query.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

class AnimeDetailRepository {
  const AnimeDetailRepository(this._client);

  final GraphQLClient _client;

  Future<AnimeDetail> fetchAnimeDetail(int id) async {
    final result = await _client.query(
      QueryOptions(
        document: animeDetailsQuery,
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

    return AnimeDetail.fromJson(media);
  }
}
