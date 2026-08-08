import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/serie_details/data/models/serie_graphql_info.dart';

class SerieDetailsBanner extends StatelessWidget {
  const SerieDetailsBanner({super.key, required this.series, this.graphqlInfo});

  final FavoriteSery series;
  final SerieGraphqlInfo? graphqlInfo;

  static const _bannerHeight = 164.0;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;
    final coverWidth = isTablet ? 168.0 : 136.0;
    final coverHeight = coverWidth * 1.5;
    const coverTop = _bannerHeight - 22;
    final imageUrl = graphqlInfo?.bannerImage ?? graphqlInfo?.coverImageLarge;
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
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => ColoredBox(
                              color: colorScheme.surfaceContainerHigh,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                colorScheme.surface,
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
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
                            child: graphqlInfo?.coverImageLarge == null
                                ? ColoredBox(
                                    color: colorScheme.surfaceContainerHighest,
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  )
                                : Image.network(
                                    graphqlInfo!.coverImageLarge!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => ColoredBox(
                                      color:
                                          colorScheme.surfaceContainerHighest,
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 34),
                          child: Text(
                            series.displayTitleRomaji ??
                                series.displayTitleEnglish ??
                                series.displayTitleNative ??
                                'Titre indisponible',
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                  height: 1.15,
                                ),
                          ),
                        ),
                      ),
                    ],
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
