import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/app_shell.dart';
import 'package:anime_time/features/anime_detail/routes/anime_detail_route.dart';
import 'package:anime_time/features/discover/presentation/screens/discover_screen.dart';
import 'package:anime_time/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:anime_time/features/search/presentation/screens/search_screen.dart';
import 'package:anime_time/features/settings/presentation/screens/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/discover',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AnimeDetailRoute.path,
      pageBuilder: (context, state) => AnimeDetailRoute.buildPage(state),
    ),
  ],
);
