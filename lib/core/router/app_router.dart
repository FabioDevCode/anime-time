import 'package:go_router/go_router.dart';
import 'package:anime_time/features/home/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [GoRoute(path: '/', builder: (context, state) => const HomeScreen())],
);
