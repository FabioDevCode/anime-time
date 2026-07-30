import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/features/soon/data/graphql/soon_anime_query.dart';

class SoonRepository implements AnimeCatalogRepository {
  const SoonRepository(this._client);

  final GraphQLClient _client;

  @override
  Future<AnimeCatalogPage> fetchPage({
    required int page,
    required int perPage,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: soonAnimeQuery,
        variables: {'page': page, 'perPage': perPage},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final pageData = result.data?['Page'] as Map<String, dynamic>?;
    if (pageData == null) throw Exception('Invalid response structure');

    final pageInfo = pageData['pageInfo'] as Map<String, dynamic>? ?? {};
    final mediaList = (pageData['media'] as List<dynamic>?) ?? [];

    return AnimeCatalogPage(
      items: mediaList
          .whereType<Map<String, dynamic>>()
          .map(AnimeMedia.fromJson)
          .toList(),
      currentPage: (pageInfo['currentPage'] as int?) ?? page,
      hasNextPage: (pageInfo['hasNextPage'] as bool?) ?? false,
    );
  }
}
