import 'package:graphql_flutter/graphql_flutter.dart';

final animeDetailProfileQuery = gql(r'''
  query AnimeDetails($id: Int) {
    Media(id: $id, type: ANIME) {
      id
      idMal
      title {
        romaji
        english
        native
      }
      description
      coverImage {
        large
      }
      bannerImage
      episodes
      duration
      status
      season
      seasonYear
      averageScore
      genres
      nextAiringEpisode {
        episode
        airingAt
      }
    }
  }
''');
