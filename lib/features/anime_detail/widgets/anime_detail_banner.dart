import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';

class AnimeDetailBanner extends StatelessWidget {
  const AnimeDetailBanner({super.key, required this.anime});

  final AnimeDetail anime;

  static const _bannerHeight = 204.0;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;
    final coverWidth = isTablet ? 168.0 : 136.0;
    final coverHeight = coverWidth * 1.5;
    const coverTop = _bannerHeight - 72;
    final imageUrl = anime.bannerImage ?? anime.coverImageLarge;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: coverTop + coverHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: _bannerHeight,
            width: double.infinity,
            child: ClipRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null)
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            ColoredBox(color: colorScheme.surfaceContainerHigh),
                      ),
                    )
                  else
                    ColoredBox(color: colorScheme.surfaceContainerHigh),
                  ColoredBox(color: Colors.black.withValues(alpha: 0.18)),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.22),
                          Colors.black.withValues(alpha: 0.64),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: coverTop,
            left: 0,
            right: 0,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: coverWidth,
                          height: coverHeight,
                          child: anime.coverImageLarge == null
                              ? ColoredBox(
                                  color: colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                )
                              : Image.network(
                                  anime.coverImageLarge!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => ColoredBox(
                                    color: colorScheme.surfaceContainerHighest,
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
