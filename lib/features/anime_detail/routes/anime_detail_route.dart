import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/anime_detail/presentation/views/anime_detail_view.dart';

/// Route plein écran utilisée pour tous les détails d'anime.
///
/// Elle vit hors du [StatefulShellRoute] : la barre de navigation flottante
/// reste donc sur la page d'origine, sous cette nouvelle vue empilée.
abstract final class AnimeDetailRoute {
  static const path = '/anime/:id';
  static const _transitionDuration = Duration(milliseconds: 250);

  static String location(int animeId) => '/anime/$animeId';

  static Page<void> buildPage(GoRouterState state) {
    final animeId = int.tryParse(state.pathParameters['id'] ?? '');
    if (animeId == null) {
      throw ArgumentError.value(
        state.pathParameters['id'],
        'id',
        'Un identifiant AniList valide est requis.',
      );
    }

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: AnimeDetailView(animeId: animeId),
      transitionDuration: _transitionDuration,
      reverseTransitionDuration: _transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);
        final fadeAnimation = Tween<double>(
          begin: 0.96,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }
}
