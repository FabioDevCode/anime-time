import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/features/discover/data/graphql/recent_releasing_anime_query.dart';

class DiscoverRepository implements AnimeCatalogRepository {
  const DiscoverRepository(this._client, {this.searchQuery});

  final GraphQLClient _client;

  /// Texte de recherche trimé. `null` signifie « pas de filtre de recherche ».
  final String? searchQuery;

  @override
  Future<AnimeCatalogPage> fetchPage({
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now();
    final today = now.year * 10000 + now.month * 100 + now.day;

    final result = await _client.query(
      QueryOptions(
        document: recentReleasingAnimeQuery,
        variables: {
          'page': page,
          'perPage': perPage,
          'today': today,
          'search': searchQuery,
        },
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
