import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/serie_details/presentation/views/serie_details_view.dart';

abstract final class SerieDetailsRoute {
  static const path = '/serie/:id';
  static const _transitionDuration = Duration(milliseconds: 250);

  static String location(int seriesId) => '/serie/$seriesId';

  static Page<void> buildPage(GoRouterState state) {
    final seriesId = int.tryParse(state.pathParameters['id'] ?? '');
    if (seriesId == null) {
      throw ArgumentError.value(
        state.pathParameters['id'],
        'id',
        'Un identifiant de série valide est requis.',
      );
    }

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: SerieDetailsView(seriesId: seriesId),
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
