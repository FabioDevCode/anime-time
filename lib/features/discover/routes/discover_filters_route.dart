import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/features/discover/presentation/screens/discover_filters_screen.dart';

abstract final class DiscoverFiltersRoute {
  static const path = '/discover/filters';
  static const _transitionDuration = Duration(milliseconds: 250);

  static Page<void> buildPage(GoRouterState state) {
    final extra = state.extra as Map<String, dynamic>?;
    final focusSearch = extra?['focusSearch'] == true;

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: DiscoverFiltersScreen(focusSearch: focusSearch),
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
