import 'package:graphql_flutter/graphql_flutter.dart';

/// Source canonique : anime_details.graphql (même dossier).
final animeDetailsQuery = gql(r'''
  query AnimeDetails($id: Int) {
    Media(id: $id, type: ANIME) {
      id
      idMal
      title {
        romaji
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
