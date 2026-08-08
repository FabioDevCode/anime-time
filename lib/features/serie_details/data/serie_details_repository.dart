import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/features/serie_details/data/graphql/serie_details_query.dart';
import 'package:anime_time/features/serie_details/data/models/serie_graphql_info.dart';

class SerieDetailsRepository {
  const SerieDetailsRepository(this._client);

  final GraphQLClient _client;

  Future<SerieGraphqlInfo> fetchLatestSeasonInfo(int latestAnimeId) async {
    final result = await _client.query(
      QueryOptions(
        document: serieDetailsQuery,
        variables: {'id': latestAnimeId},
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

    return SerieGraphqlInfo.fromJson(media);
  }
}
