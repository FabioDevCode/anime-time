import 'package:anime_time/features/soon/data/soon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  group('SoonRepository — mode normal (sans recherche)', () {
    test(
      'loads known years in order, skips isolated empty years, then loads unknown years',
      () async {
        final requests = <Map<String, dynamic>>[];
        final repository = SoonRepository(
          _clientFor(requests, [
            _page(ids: [1], hasNextPage: true, seasonYear: 2026),
            _page(ids: [2], seasonYear: 2026),
            _page(ids: []),
            _page(ids: [3], seasonYear: 2028),
            _page(ids: []),
            _page(ids: []),
            _page(ids: []),
            _page(ids: [99]),
          ]),
          now: () => DateTime(2026, 1, 1),
        );

        final firstPage = await repository.fetchPage(page: 1, perPage: 24);
        final secondPage = await repository.fetchPage(page: 2, perPage: 24);
        final thirdPage = await repository.fetchPage(page: 3, perPage: 24);
        final lastPage = await repository.fetchPage(page: 4, perPage: 24);

        expect(firstPage.items.map((anime) => anime.id), [1]);
        expect(firstPage.items.single.season, 'WINTER');
        expect(firstPage.items.single.seasonYear, 2026);
        expect(firstPage.hasNextPage, isTrue);
        expect(secondPage.items.map((anime) => anime.id), [2]);
        expect(secondPage.hasNextPage, isTrue);
        expect(thirdPage.items.map((anime) => anime.id), [3]);
        expect(thirdPage.hasNextPage, isTrue);
        expect(lastPage.items.map((anime) => anime.id), [99]);
        expect(lastPage.hasNextPage, isFalse);

        expect(requests, [
          {'page': 1, 'perPage': 24, 'seasonYear': 2026, 'search': null},
          {'page': 2, 'perPage': 24, 'seasonYear': 2026, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2027, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2028, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2029, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2030, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2031, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': null, 'search': null},
        ]);
      },
    );

    test(
      'restarts from the current year when the first logical page is fetched',
      () async {
        final requests = <Map<String, dynamic>>[];
        final repository = SoonRepository(
          _clientFor(requests, [
            _page(ids: [1], seasonYear: 2026),
            _page(ids: [2], seasonYear: 2026),
          ]),
          now: () => DateTime(2026, 1, 1),
        );

        await repository.fetchPage(page: 1, perPage: 24);
        await repository.fetchPage(page: 1, perPage: 24);

        expect(requests, [
          {'page': 1, 'perPage': 24, 'seasonYear': 2026, 'search': null},
          {'page': 1, 'perPage': 24, 'seasonYear': 2026, 'search': null},
        ]);
      },
    );
  });

  group('SoonRepository — mode recherche', () {
    test(
      'bypasses year strategy: uses direct pagination with search and seasonYear null',
      () async {
        final requests = <Map<String, dynamic>>[];
        final repository = SoonRepository(
          _clientFor(requests, [
            _page(ids: [10], hasNextPage: true),
            _page(ids: [11]),
          ]),
          searchQuery: 'One Piece',
          now: () => DateTime(2026, 1, 1),
        );

        final page1 = await repository.fetchPage(page: 1, perPage: 24);
        final page2 = await repository.fetchPage(page: 2, perPage: 24);

        expect(page1.items.map((a) => a.id), [10]);
        expect(page1.hasNextPage, isTrue);
        expect(page2.items.map((a) => a.id), [11]);
        expect(page2.hasNextPage, isFalse);

        expect(requests, [
          {'page': 1, 'perPage': 24, 'seasonYear': null, 'search': 'One Piece'},
          {'page': 2, 'perPage': 24, 'seasonYear': null, 'search': 'One Piece'},
        ]);
      },
    );

    test('empty search query falls back to normal year strategy', () async {
      final requests = <Map<String, dynamic>>[];
      final repository = SoonRepository(
        _clientFor(requests, [_page(ids: [1], seasonYear: 2026)]),
        searchQuery: '',
        now: () => DateTime(2026, 1, 1),
      );

      await repository.fetchPage(page: 1, perPage: 24);

      expect(requests.single['search'], isNull);
      expect(requests.single['seasonYear'], 2026);
    });
  });
}

GraphQLClient _clientFor(
  List<Map<String, dynamic>> requests,
  List<Map<String, dynamic>> responses,
) {
  var responseIndex = 0;

  return GraphQLClient(
    link: Link.function((request, [forward]) {
      requests.add(Map<String, dynamic>.from(request.variables));
      final response = responses[responseIndex++];
      return Stream.value(Response(data: response, response: const {}));
    }),
    cache: GraphQLCache(),
  );
}

Map<String, dynamic> _page({
  required List<int> ids,
  bool hasNextPage = false,
  int? seasonYear,
}) {
  return {
    '__typename': 'Query',
    'Page': {
      '__typename': 'Page',
      'pageInfo': {
        '__typename': 'PageInfo',
        'currentPage': 1,
        'hasNextPage': hasNextPage,
      },
      'media': [
        for (final id in ids)
          {
            '__typename': 'Media',
            'id': id,
            'status': 'NOT_YET_RELEASED',
            'season': 'WINTER',
            'seasonYear': seasonYear,
            'coverImage': {
              '__typename': 'MediaCoverImage',
              'large': 'https://example.test/$id.jpg',
            },
            'title': {
              '__typename': 'MediaTitle',
              'romaji': 'Anime $id',
              'english': null,
              'native': null,
            },
          },
      ],
    },
  };
}
