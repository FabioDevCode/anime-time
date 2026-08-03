import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/anime_detail_profile/presentation/views/anime_detail_profile_view.dart';

abstract final class AnimeDetailProfileRoute {
  static const path = '/anime-profile/:id';
  static const _transitionDuration = Duration(milliseconds: 250);

  static String location(int animeId) => '/anime-profile/$animeId';

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
      child: AnimeDetailProfileView(animeId: animeId),
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
