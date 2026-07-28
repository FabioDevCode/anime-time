import 'package:flutter/material.dart';

/// Données d'affichage d'un badge de statut anime.
class AnimeStatusBadgeData {
  const AnimeStatusBadgeData({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
}

/// Extension sur le statut brut retourné par l'API AniList.
///
/// Retourne un [AnimeStatusBadgeData] pour les statuts reconnus,
/// ou `null` si aucun badge ne doit être affiché.
///
/// Pour ajouter un nouveau statut, il suffit d'ajouter une entrée
/// dans la map [_statusMap] sans modifier aucun widget.
extension AnimeStatusExtension on String {
  static const Map<String, AnimeStatusBadgeData> _statusMap = {
    'RELEASING': AnimeStatusBadgeData(
      label: 'En cours',
      backgroundColor: Color(0x2266BB6A),
      textColor: Color(0xFF81C784),
    ),
    'FINISHED': AnimeStatusBadgeData(
      label: 'Terminée',
      backgroundColor: Color(0x22909090),
      textColor: Color(0xFF9E9E9E),
    ),
    // Futurs statuts :
    // 'NOT_YET_RELEASED': AnimeStatusBadgeData(label: 'À venir', ...),
    // 'HIATUS': AnimeStatusBadgeData(label: 'Pause', ...),
    // 'CANCELLED': AnimeStatusBadgeData(label: 'Annulé', ...),
  };

  AnimeStatusBadgeData? get badgeData => _statusMap[this];
}
