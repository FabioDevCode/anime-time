import 'package:graphql_flutter/graphql_flutter.dart';

// Source canonique : recent_releasing_anime.graphql (même dossier)
// Ce fichier expose le DocumentNode parsé pour utilisation dans le repository.
// Pour un futur codegen (ferry / artemis), le .graphql est prêt à l'emploi.
final recentReleasingAnimeQuery = gql(r'''
  query RecentReleasingAnime($page: Int!, $perPage: Int!) {
    Page(page: $page, perPage: $perPage) {
      pageInfo {
        currentPage
        hasNextPage
      }

      media(
        type: ANIME
        status: RELEASING
        sort: START_DATE_DESC
        isAdult: false
        format: TV
      ) {
        id

        status

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
