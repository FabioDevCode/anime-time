import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_time/core/database/database.dart';
import 'package:anime_time/features/serie_details/providers/serie_details_providers.dart';

class SerieDetailsSeasonCard extends ConsumerStatefulWidget {
  const SerieDetailsSeasonCard({super.key, required this.season});

  final FavoriteAnimeData season;

  @override
  ConsumerState<SerieDetailsSeasonCard> createState() =>
      _SerieDetailsSeasonCardState();
}

class _SerieDetailsSeasonCardState
    extends ConsumerState<SerieDetailsSeasonCard> {
  bool _isExpanded = false;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  Future<void> _handleEpisodePressed(int episodeNumber) async {
    await ref
        .read(watchProgressRepositoryProvider)
        .toggleEpisode(
          animeId: widget.season.animeId,
          episodeNumber: episodeNumber,
          currentLastWatched: widget.season.lastEpisodeWatched,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _SeasonHeader(
                season: widget.season,
                isExpanded: _isExpanded,
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? _SeasonEpisodeList(
                    season: widget.season,
                    onEpisodePressed: _handleEpisodePressed,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _SeasonHeader extends StatelessWidget {
  const _SeasonHeader({required this.season, required this.isExpanded});

  final FavoriteAnimeData season;
  final bool isExpanded;

  static const _progressColorComplete = Color(0xFF66BB6A);
  static const _progressColorPartial = Color(0xFFFFB74D);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final episodes = season.episodes;
    final airedEpisodes = season.airedEpisodes;
    final watched = season.lastEpisodeWatched;

    // Cas 1 : total connu. Cas 2 : total inconnu mais épisodes diffusés connus.
    final double? progress;
    final bool isComplete;
    final String counterText;
    if (episodes != null) {
      progress = episodes > 0 ? (watched / episodes).clamp(0.0, 1.0) : null;
      isComplete = watched >= episodes;
      counterText = '$watched / $episodes épisode${episodes == 1 ? '' : 's'}';
    } else if (airedEpisodes != null) {
      progress = (watched / (airedEpisodes + 1)).clamp(0.0, 1.0);
      isComplete = false;
      counterText = '$watched/? épisode${watched == 1 ? '' : 's'}';
    } else {
      progress = null;
      isComplete = false;
      counterText = '$watched/? épisode${watched == 1 ? '' : 's'}';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            width: 56,
            height: 84,
            child: season.coverImage == null
                ? ColoredBox(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  )
                : Image.network(
                    season.coverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => ColoredBox(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Saison ${season.seasonNumber ?? '?'}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                counterText,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (progress != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    color: isComplete
                        ? _progressColorComplete
                        : _progressColorPartial,
                    minHeight: 5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SeasonEpisodeList extends StatelessWidget {
  const _SeasonEpisodeList({
    required this.season,
    required this.onEpisodePressed,
  });

  final FavoriteAnimeData season;
  final Future<void> Function(int) onEpisodePressed;

  @override
  Widget build(BuildContext context) {
    final episodes = season.episodes;
    final airedEpisodes = season.airedEpisodes;
    final watched = season.lastEpisodeWatched;
    final seasonNumber = season.seasonNumber ?? 0;
    // Générer jusqu'au total officiel, ou jusqu'aux épisodes diffusés connus.
    final episodeCount = episodes ?? airedEpisodes;

    if (episodeCount == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
        child: Text(
          "Nombre d'épisodes inconnu",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      children: [
        const Divider(height: 1),
        for (var i = 1; i <= episodeCount; i++)
          SerieDetailsEpisodeListItem(
            seasonNumber: seasonNumber,
            episodeNumber: i,
            coverImage: season.coverImage,
            isWatched: i <= watched,
            onTap: () => onEpisodePressed(i),
          ),
        const SizedBox(height: 6),
      ],
    );
  }
}

/// Élément représentant un épisode dans la liste dépliée d'une saison.
class SerieDetailsEpisodeListItem extends StatelessWidget {
  const SerieDetailsEpisodeListItem({
    super.key,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.isWatched,
    required this.onTap,
    this.coverImage,
  });

  final int seasonNumber;
  final int episodeNumber;
  final String? coverImage;
  final bool isWatched;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 40,
                height: 60,
                child: coverImage == null
                    ? ColoredBox(color: colorScheme.surfaceContainerHighest)
                    : Image.network(
                        coverImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => ColoredBox(
                          color: colorScheme.surfaceContainerHighest,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'S${seasonNumber}E$episodeNumber',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Épisode $episodeNumber',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _EpisodeCheckbox(isWatched: isWatched),
          ],
        ),
      ),
    );
  }
}

class _EpisodeCheckbox extends StatelessWidget {
  const _EpisodeCheckbox({required this.isWatched});

  final bool isWatched;

  static const _colorChecked = Color(0xFF66BB6A);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isWatched ? _colorChecked : Colors.transparent,
        border: Border.all(
          color: isWatched ? _colorChecked : colorScheme.outline,
          width: 2,
        ),
      ),
      child: isWatched
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
          : null,
    );
  }
}
