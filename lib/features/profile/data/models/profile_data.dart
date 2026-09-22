import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/models/series_media.dart';

/// Comptages affichés en tête de la page profil.
class ProfileStatistics {
  const ProfileStatistics({
    required this.totalFavorites,
    required this.releasing,
    required this.upcoming,
  });

  final int totalFavorites;
  final int releasing;
  final int upcoming;
}

/// Données locales nécessaires à la première version du profil.
class ProfileData {
  const ProfileData({
    required this.statistics,
    required this.favorites,
    required this.releasing,
    required this.upcoming,
  });

  final ProfileStatistics statistics;

  /// Favoris actuellement diffusés ou terminés.
  final List<AnimeMedia> favorites;

  /// Séries avec au moins une saison en cours, dédoublonnées par seriesId.
  final List<SeriesMedia> releasing;

  /// Favoris dont la diffusion n'a pas encore commencé.
  final List<AnimeMedia> upcoming;
}
