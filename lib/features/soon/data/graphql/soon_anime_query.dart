import 'package:graphql_flutter/graphql_flutter.dart';

// Source canonique : soon_anime.graphql (même dossier).
final soonAnimeQuery = gql(r'''
  query SoonAnime($page: Int!, $perPage: Int!, $seasonYear: Int) {
    Page(page: $page, perPage: $perPage) {
      pageInfo {
        currentPage
        hasNextPage
      }
      media(
        type: ANIME
        format: TV
        status: NOT_YET_RELEASED
        seasonYear: $seasonYear
        sort: START_DATE
        isAdult: false
      ) {
        id
        status
        season
        seasonYear
        coverImage {
          large
        }
        title {
          romaji
          english
          native
        }
      }
    }
  }
''');
