import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_time/common/widgets/app_shell.dart';
import 'package:anime_time/core/router/app_tab.dart';
import 'package:anime_time/features/anime_detail/routes/anime_detail_route.dart';
import 'package:anime_time/features/anime_detail_profile/routes/anime_detail_profile_route.dart';
import 'package:anime_time/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:anime_time/features/discover/presentation/screens/discover_screen.dart';
import 'package:anime_time/features/profile/presentation/screens/profile_screen.dart';
import 'package:anime_time/features/soon/presentation/views/soon_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppTab.discover.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
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
      path: AnimeDetailRoute.path,
      pageBuilder: (context, state) => AnimeDetailRoute.buildPage(state),
    ),
    GoRoute(
      path: AnimeDetailProfileRoute.path,
      pageBuilder: (context, state) => AnimeDetailProfileRoute.buildPage(state),
    ),
  ],
);

Widget _buildTabScreen(AppTab tab) => switch (tab) {
  AppTab.discover => const DiscoverScreen(),
  AppTab.soon => const SoonView(),
  AppTab.calendar => const CalendarScreen(),
  AppTab.profile => const ProfileScreen(),
};
