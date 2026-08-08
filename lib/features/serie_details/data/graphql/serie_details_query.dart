import 'package:graphql_flutter/graphql_flutter.dart';

final serieDetailsQuery = gql(r'''
  query SerieDetails($id: Int!) {
    Media(id: $id, type: ANIME) {
      id
      description
      coverImage {
        large
      }
      bannerImage
      status
      genres
      duration
      season
      seasonYear
      averageScore
    }
  }
''');
