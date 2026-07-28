import 'package:flutter/material.dart';
import 'package:anime_time/features/discover/data/models/anime_media.dart';
import 'package:anime_time/features/discover/utils/anime_status.dart';
import 'package:anime_time/features/discover/widgets/anime_status_badge.dart';

class AnimeListItem extends StatelessWidget {
  const AnimeListItem({super.key, required this.anime, this.onTap});

  final AnimeMedia anime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 56,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: anime.coverImageLarge != null
                        ? Image.network(
                            anime.coverImageLarge!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _ImagePlaceholder(colorScheme: colorScheme),
                          )
                        : _ImagePlaceholder(colorScheme: colorScheme),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (anime.titleRomaji != null)
                      Text(
                        anime.titleRomaji!,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (anime.titleNative != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        anime.titleNative!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (anime.status.badgeData case final badge?) ...[
                      const SizedBox(height: 6),
                      AnimeStatusBadge(data: badge),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
