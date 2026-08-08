import 'package:graphql_flutter/graphql_flutter.dart';

final animeSerieQuery = gql(r'''
  query AnimeSerie($id: Int) {
    Media(id: $id, type: ANIME) {
      id
      idMal
      format
      title {
        romaji
        english
        native
      }
      coverImage {
        large
      }
      bannerImage
      episodes
      status
      season
      seasonYear
      nextAiringEpisode {
        episode
        airingAt
      }
      relations {
        edges {
          relationType
          node {
            id
            idMal
            format
            title {
              romaji
              english
              native
            }
            coverImage {
              large
            }
            bannerImage
            episodes
            status
            season
            seasonYear
            nextAiringEpisode {
              episode
              airingAt
            }
          }
        }
      }
    }
  }
''');
