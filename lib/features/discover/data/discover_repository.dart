import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/features/discover/data/graphql/recent_releasing_anime_query.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';

class DiscoverResult {
  const DiscoverResult({
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
  });

  final List<AnimeMedia> items;
  final int currentPage;
  final bool hasNextPage;
}

class DiscoverRepository {
  const DiscoverRepository(this._client);

  final GraphQLClient _client;

  Future<DiscoverResult> fetchRecentReleasingAnime({
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now();
    final today = now.year * 10000 + now.month * 100 + now.day;

    final result = await _client.query(
      QueryOptions(
        document: recentReleasingAnimeQuery,
        variables: {'page': page, 'perPage': perPage, 'today': today},
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

    return DiscoverResult(
      items: mediaList
          .whereType<Map<String, dynamic>>()
          .map(AnimeMedia.fromJson)
          .toList(),
      currentPage: (pageInfo['currentPage'] as int?) ?? page,
      hasNextPage: (pageInfo['hasNextPage'] as bool?) ?? false,
    );
  }
}
