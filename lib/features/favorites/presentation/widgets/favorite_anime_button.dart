import 'dart:async';

import 'package:anime_time/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

/// Bouton réutilisable permettant d'ajouter ou retirer un anime des favoris.
///
/// Il ne connaît ni Riverpod ni Drift : la page hôte lui fournit l'état et les
/// actions à déclencher.
class FavoriteAnimeButton extends StatelessWidget {
  const FavoriteAnimeButton({
    super.key,
    required this.isFavorite,
    required this.isProcessing,
    required this.onAdd,
    required this.onRemove,
  });

  static const _height = 52.0;
  static const _removeButtonSize = 52.0;
  static const _buttonGap = 10.0;
  static const _animationDuration = Duration(milliseconds: 250);
  static const _removeButtonColor = Color.fromARGB(255, 202, 32, 32);
  static const _favoriteColor = Color(0xFF3FAE68);

  final bool isFavorite;
  final bool isProcessing;
  final Future<void> Function() onAdd;
  final Future<void> Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mainButtonWidth = isFavorite
              ? (constraints.maxWidth - _removeButtonSize - _buttonGap)
                    .clamp(0.0, constraints.maxWidth)
                    .toDouble()
              : constraints.maxWidth;

          return IgnorePointer(
            ignoring: isProcessing,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: _animationDuration,
                  curve: Curves.easeInOutCubic,
                  width: mainButtonWidth,
                  height: _height,
                  child: AnimatedSwitcher(
                    duration: _animationDuration,
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.96,
                            end: 1,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: isFavorite
                        ? const _FavoriteIndicatorButton(
                            key: ValueKey('favorite-indicator'),
                          )
                        : _AddFavoriteButton(
                            key: const ValueKey('add-favorite'),
                            isProcessing: isProcessing,
                            onPressed: () => unawaited(onAdd()),
                          ),
                  ),
                ),
                AnimatedContainer(
                  duration: _animationDuration,
                  curve: Curves.easeInOutCubic,
                  width: isFavorite ? _buttonGap : 0,
                ),
                ClipRect(
                  child: AnimatedContainer(
                    duration: _animationDuration,
                    curve: Curves.easeInOutCubic,
                    width: isFavorite ? _removeButtonSize : 0,
                    height: _height,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeInOut,
                      opacity: isFavorite ? 1 : 0,
                      child: ExcludeSemantics(
                        excluding: !isFavorite,
                        child: IgnorePointer(
                          ignoring: !isFavorite,
                          child: SizedBox(
                            width: _removeButtonSize,
                            height: _height,
                            child: Semantics(
                              button: true,
                              label: 'Retirer des favoris',
                              child: IconButton.filled(
                                onPressed: isProcessing
                                    ? null
                                    : () => unawaited(
                                        _requestRemovalConfirmation(context),
                                      ),
                                icon: isProcessing
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.close_rounded),
                                tooltip: 'Retirer des favoris',
                                style: IconButton.styleFrom(
                                  backgroundColor: _removeButtonColor,
                                  disabledBackgroundColor: _removeButtonColor
                                      .withValues(alpha: 0.62),
                                  foregroundColor: Colors.white,
                                  disabledForegroundColor: Colors.white,
                                  shape: const CircleBorder(),
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
        },
      ),
    );
  }

  Future<void> _requestRemovalConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        final screenWidth = MediaQuery.of(dialogContext).size.width;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          title: const Text('Retirer des favoris'),
          content: SizedBox(
            width: screenWidth * 0.75,
            child: const Text(
              'Êtes-vous sûr(e) de vouloir supprimer cet anime de vos favoris ?',
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          actions: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    style: FilledButton.styleFrom(
                      backgroundColor: _removeButtonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Retirer des favoris'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant,
                      side: BorderSide(color: colorScheme.outline),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Annuler'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await onRemove();
    }
  }
}

class _AddFavoriteButton extends StatelessWidget {
  const _AddFavoriteButton({
    super.key,
    required this.isProcessing,
    required this.onPressed,
  });

  final bool isProcessing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return SizedBox.expand(
      child: FilledButton.icon(
        onPressed: isProcessing ? null : onPressed,
        icon: isProcessing
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: appColors.onBrandBackground,
                ),
              )
            : const Icon(Icons.favorite_border_rounded),
        label: Text(
          isProcessing ? 'Ajout aux favoris...' : 'Ajouter aux favoris',
        ),
        style: FilledButton.styleFrom(
          backgroundColor: appColors.brandBackground,
          disabledBackgroundColor: appColors.brandBackground.withValues(
            alpha: 0.62,
          ),
          foregroundColor: appColors.onBrandBackground,
          disabledForegroundColor: appColors.onBrandBackground,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}

class _FavoriteIndicatorButton extends StatelessWidget {
  const _FavoriteIndicatorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.favorite_rounded),
        label: const Text('Favoris'),
        style: OutlinedButton.styleFrom(
          foregroundColor: FavoriteAnimeButton._favoriteColor,
          disabledForegroundColor: FavoriteAnimeButton._favoriteColor,
          side: const BorderSide(color: FavoriteAnimeButton._favoriteColor),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
