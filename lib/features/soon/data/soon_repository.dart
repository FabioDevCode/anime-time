import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/features/soon/data/graphql/soon_anime_query.dart';

class SoonRepository implements AnimeCatalogRepository {
  SoonRepository(this._client, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final GraphQLClient _client;
  final DateTime Function() _now;

  static const int _maxConsecutiveEmptyYears = 3;

  late int _seasonYear;
  var _apiPage = 1;
  var _consecutiveEmptyYears = 0;
  var _currentYearHasItems = false;
  var _phase = _SoonFetchPhase.knownYears;
  var _isInitialized = false;

  @override
  Future<AnimeCatalogPage> fetchPage({
    required int page,
    required int perPage,
  }) async {
    if (page == 1 || !_isInitialized) {
      _resetCursor();
    }

    while (_phase != _SoonFetchPhase.completed) {
      final result = await _fetchApiPage(perPage: perPage);

      if (_phase == _SoonFetchPhase.knownYears) {
        _currentYearHasItems = _currentYearHasItems || result.items.isNotEmpty;

        if (result.hasNextPage) {
          _apiPage += 1;
        } else {
          _completeCurrentYear();
        }

        if (result.items.isNotEmpty) {
          return AnimeCatalogPage(
            items: result.items,
            currentPage: page,
            // A following year or the final "sans année" phase remains to be
            // explored, even after the last API page of a known year.
            hasNextPage: true,
          );
        }

        // Empty API pages must not become empty UI pages: keep progressing
        // sequentially until a page contributes items or the search is done.
        continue;
      }

      if (result.hasNextPage) {
        _apiPage += 1;
      } else {
        _phase = _SoonFetchPhase.completed;
      }

      if (result.items.isNotEmpty || _phase == _SoonFetchPhase.completed) {
        return AnimeCatalogPage(
          items: result.items,
          currentPage: page,
          hasNextPage: _phase != _SoonFetchPhase.completed,
        );
      }
    }

    return AnimeCatalogPage(
      items: const [],
      currentPage: page,
      hasNextPage: false,
    );
  }

  void _resetCursor() {
    _seasonYear = _now().year;
    _apiPage = 1;
    _consecutiveEmptyYears = 0;
    _currentYearHasItems = false;
    _phase = _SoonFetchPhase.knownYears;
    _isInitialized = true;
  }

  void _completeCurrentYear() {
    if (_currentYearHasItems) {
      _consecutiveEmptyYears = 0;
    } else {
      _consecutiveEmptyYears += 1;
    }

    _currentYearHasItems = false;
    _apiPage = 1;

    if (_consecutiveEmptyYears >= _maxConsecutiveEmptyYears) {
      _phase = _SoonFetchPhase.unknownYear;
      return;
    }

    _seasonYear += 1;
  }

  Future<AnimeCatalogPage> _fetchApiPage({required int perPage}) async {
    final result = await _client.query(
      QueryOptions(
        document: soonAnimeQuery,
        variables: {
          'page': _apiPage,
          'perPage': perPage,
          'seasonYear': _phase == _SoonFetchPhase.knownYears
              ? _seasonYear
              : null,
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
      currentPage: (pageInfo['currentPage'] as int?) ?? _apiPage,
      hasNextPage: (pageInfo['hasNextPage'] as bool?) ?? false,
    );
  }
}

enum _SoonFetchPhase { knownYears, unknownYear, completed }
