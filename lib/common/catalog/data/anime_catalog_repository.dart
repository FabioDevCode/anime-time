import 'package:anime_time/common/models/anime_media.dart';

/// Contrat de données partagé par les catalogues paginés d'anime.
abstract interface class AnimeCatalogRepository {
  Future<AnimeCatalogPage> fetchPage({required int page, required int perPage});
}

class AnimeCatalogPage {
  const AnimeCatalogPage({
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
  });

  final List<AnimeMedia> items;
  final int currentPage;
  final bool hasNextPage;
}
