import 'package:graphql_flutter/graphql_flutter.dart';

// Source canonique : calendar_anime.graphql (même dossier).
final calendarAnimeQuery = gql(r'''
  query CalendarAnime($ids: [Int]) {
    Page(perPage: 50) {
      media(
        id_in: $ids
        type: ANIME
      ) {
        id
        status
        title {
          romaji
          native
        }
        coverImage {
          large
        }
        bannerImage
        nextAiringEpisode {
          episode
          airingAt
          timeUntilAiring
        }
      }
    }
  }
''');
