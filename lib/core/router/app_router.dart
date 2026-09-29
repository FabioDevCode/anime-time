import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/app_shell.dart';
import 'package:anime_time/features/splash/presentation/screens/splash_screen.dart';
import 'package:anime_time/core/router/app_tab.dart';
import 'package:anime_time/features/anime_detail/routes/anime_detail_route.dart';
import 'package:anime_time/features/anime_detail_profile/routes/anime_detail_profile_route.dart';
import 'package:anime_time/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:anime_time/features/discover/presentation/screens/discover_screen.dart';
import 'package:anime_time/features/discover/routes/discover_filters_route.dart';
import 'package:anime_time/features/profile/presentation/screens/profile_screen.dart';
import 'package:anime_time/features/serie_details/routes/serie_details_route.dart';
import 'package:anime_time/features/watching/presentation/screens/watching_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
const _splashTransitionDuration = Duration(milliseconds: 500);

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionDuration: _splashTransitionDuration,
        reverseTransitionDuration: _splashTransitionDuration,
        transitionsBuilder: _fadeTransition,
      ),
    ),
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) =>
          CustomTransitionPage<void>(
            key: state.pageKey,
            child: AppShell(navigationShell: navigationShell),
            transitionDuration: _splashTransitionDuration,
            reverseTransitionDuration: _splashTransitionDuration,
            transitionsBuilder: _fadeTransition,
          ),
      branches: AppTab.values
          .map(
            (tab) => StatefulShellBranch(
              routes: [
                GoRoute(
                  name: tab.routeName,
                  path: tab.path,
                  builder: (context, state) => _buildTabScreen(tab),
                ),
              ],
            ),
          )
          .toList(),
    ),
    GoRoute(
      path: DiscoverFiltersRoute.path,
      pageBuilder: (context, state) => DiscoverFiltersRoute.buildPage(state),
    ),
    GoRoute(
      path: AnimeDetailRoute.path,
      pageBuilder: (context, state) => AnimeDetailRoute.buildPage(state),
    ),
    GoRoute(
      path: AnimeDetailProfileRoute.path,
      pageBuilder: (context, state) => AnimeDetailProfileRoute.buildPage(state),
    ),
    GoRoute(
      path: SerieDetailsRoute.path,
      pageBuilder: (context, state) => SerieDetailsRoute.buildPage(state),
    ),
  ],
);

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final fadeAnimation = CurveTween(curve: Curves.easeInOut).animate(animation);
  return FadeTransition(opacity: fadeAnimation, child: child);
}

Widget _buildTabScreen(AppTab tab) => switch (tab) {
  AppTab.discover => const DiscoverScreen(),
  AppTab.watching => const WatchingScreen(),
  AppTab.calendar => const CalendarScreen(),
  AppTab.profile => const ProfileScreen(),
};
