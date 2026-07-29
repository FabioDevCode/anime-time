import 'package:flutter/material.dart';
import 'package:anime_time/features/anime_detail/utils/html_text.dart';

class AnimeDetailSynopsisCard extends StatelessWidget {
  const AnimeDetailSynopsisCard({super.key, required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    final synopsis = description == null ? '' : stripHtml(description!);
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Synopsis',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              synopsis.isEmpty ? 'Aucun synopsis disponible.' : synopsis,
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}
