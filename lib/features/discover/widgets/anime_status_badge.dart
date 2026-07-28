import 'package:flutter/material.dart';
import 'package:anime_time/features/discover/utils/anime_status.dart';

/// Badge pill affichant le statut d'un anime.
///
/// Le style est minimal et discret : fond semi-transparent teinté,
/// texte légèrement plus petit que le titre native, police Medium.
class AnimeStatusBadge extends StatelessWidget {
  const AnimeStatusBadge({super.key, required this.data});

  final AnimeStatusBadgeData data;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          data.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: data.textColor,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ),
    );
  }
}
