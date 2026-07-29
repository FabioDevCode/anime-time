import 'package:flutter/material.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';

class AnimeCoverCard extends StatelessWidget {
  const AnimeCoverCard({super.key, required this.anime, this.onTap});

  final AnimeMedia anime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: anime.coverImageLarge != null
                ? Image.network(
                    anime.coverImageLarge!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _Placeholder(colorScheme: colorScheme),
                  )
                : _Placeholder(colorScheme: colorScheme),
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
