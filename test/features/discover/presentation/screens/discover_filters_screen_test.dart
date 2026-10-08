import 'package:anime_time/core/theme/app_theme.dart';
import 'package:anime_time/features/discover/presentation/screens/discover_filters_screen.dart';
import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Écran simple sans GoRouter (pour les tests qui ne tapent pas Appliquer).
Widget buildSubject({DiscoverFilterCriteria? initial}) {
  return ProviderScope(
    overrides: [
      if (initial != null)
        discoverAppliedFilterProvider.overrideWith(
          () => _FixedFilterNotifier(initial),
        ),
    ],
    child: MaterialApp(
      theme: AppTheme.dark,
      home: const DiscoverFiltersScreen(),
    ),
  );
}

/// Prépare un router avec `/` comme page d'accueil et `/filters` accessible
/// via push, puis navigue vers `/filters` pour simuler l'ouverture réelle.
///
/// Renvoie le router (pour naviguer) et le widget racine.
({GoRouter router, ProviderContainer container, Widget widget}) setupRouterSubject({
  DiscoverFilterCriteria? initial,
}) {
  final container = ProviderContainer(
    overrides: [
      if (initial != null)
        discoverAppliedFilterProvider.overrideWith(
          () => _FixedFilterNotifier(initial),
        ),
    ],
  );

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SizedBox.shrink()),
      GoRoute(
        path: '/filters',
        builder: (_, __) => const DiscoverFiltersScreen(),
      ),
    ],
  );

  final widget = UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(theme: AppTheme.dark, routerConfig: router),
  );

  return (router: router, container: container, widget: widget);
}

class _FixedFilterNotifier extends DiscoverFilterNotifier {
  _FixedFilterNotifier(this._initial);
  final DiscoverFilterCriteria _initial;

  @override
  DiscoverFilterCriteria build() => _initial;
}

void main() {
  group('DiscoverFiltersScreen', () {
    testWidgets(
      'Cas 1 — aucun filtre appliqué : Appliquer ferme la page sans modifier applied',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        expect(
          find.byWidgetPredicate((w) => w is FilterChip && w.selected == true),
          findsNothing,
        );

        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        // DiscoverFiltersScreen a été dépilé
        expect(find.text('Appliquer'), findsNothing);
        expect(container.read(discoverAppliedFilterProvider).hasActiveFilters, isFalse);
      },
    );

    testWidgets(
      'Cas 2 — sélection de Prochainement : le chip devient sélectionné, la page reste ouverte',
      (tester) async {
        await tester.pumpWidget(buildSubject());

        final chipBefore = tester.widget<FilterChip>(
          find.byWidgetPredicate((w) => w is FilterChip),
        );
        expect(chipBefore.selected, isFalse);

        await tester.tap(find.text('Prochainement'));
        await tester.pump();

        final chipAfter = tester.widget<FilterChip>(
          find.byWidgetPredicate((w) => w is FilterChip),
        );
        expect(chipAfter.selected, isTrue);

        // La page Filtres est toujours présente
        expect(find.text('Appliquer'), findsOneWidget);
      },
    );

    testWidgets(
      "Cas 3 — Prochainement appliqué : le chip s'affiche initialement sélectionné",
      (tester) async {
        await tester.pumpWidget(
          buildSubject(
            initial: const DiscoverFilterCriteria(filter: DiscoverFilter.soon),
          ),
        );

        final chip = tester.widget<FilterChip>(
          find.byWidgetPredicate((w) => w is FilterChip),
        );
        expect(chip.selected, isTrue);
      },
    );

    testWidgets(
      "Cas 3 — désélection sans Appliquer : applied n'est pas modifié",
      (tester) async {
        DiscoverFilterCriteria? appliedAfterPop;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              discoverAppliedFilterProvider.overrideWith(
                () => _FixedFilterNotifier(
                  const DiscoverFilterCriteria(filter: DiscoverFilter.soon),
                ),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.dark,
              home: Consumer(
                builder: (context, ref, _) {
                  appliedAfterPop = ref.watch(discoverAppliedFilterProvider);
                  return const DiscoverFiltersScreen();
                },
              ),
            ),
          ),
        );

        // Décocher Prochainement
        await tester.tap(find.text('Prochainement'));
        await tester.pump();

        // L'applied est inchangé (soon), seul le draft a changé
        expect(appliedAfterPop?.filter, DiscoverFilter.soon);
      },
    );

    testWidgets(
      'Cas 4 — Réinitialiser remet le draft à none sans naviguer',
      (tester) async {
        await tester.pumpWidget(buildSubject());

        // Sélectionner Prochainement
        await tester.tap(find.text('Prochainement'));
        await tester.pump();
        expect(
          tester.widget<FilterChip>(
            find.byWidgetPredicate((w) => w is FilterChip),
          ).selected,
          isTrue,
        );

        // Réinitialiser
        await tester.tap(find.text('Réinitialiser'));
        await tester.pump();

        expect(
          tester.widget<FilterChip>(
            find.byWidgetPredicate((w) => w is FilterChip),
          ).selected,
          isFalse,
        );

        // La page est toujours ouverte
        expect(find.text('Appliquer'), findsOneWidget);
      },
    );

    testWidgets(
      'Cas 4 — Réinitialiser ne modifie pas applied',
      (tester) async {
        DiscoverFilterCriteria? seen;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              discoverAppliedFilterProvider.overrideWith(
                () => _FixedFilterNotifier(
                  const DiscoverFilterCriteria(filter: DiscoverFilter.soon),
                ),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.dark,
              home: Consumer(
                builder: (context, ref, _) {
                  seen = ref.watch(discoverAppliedFilterProvider);
                  return const DiscoverFiltersScreen();
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Réinitialiser'));
        await tester.pump();

        expect(seen?.filter, DiscoverFilter.soon);
      },
    );

    testWidgets(
      'Cas 5 — réouverture avec filtre actif : chip initialement sélectionné',
      (tester) async {
        await tester.pumpWidget(
          buildSubject(
            initial: const DiscoverFilterCriteria(filter: DiscoverFilter.soon),
          ),
        );

        final chip = tester.widget<FilterChip>(
          find.byWidgetPredicate((w) => w is FilterChip),
        );
        expect(chip.selected, isTrue);
      },
    );

    testWidgets(
      'Appliquer transmet le draft au provider applied',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Prochainement'));
        await tester.pump();

        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        expect(
          container.read(discoverAppliedFilterProvider).filter,
          DiscoverFilter.soon,
        );
        // La page a été dépilée après l'application
        expect(find.text('Appliquer'), findsNothing);
      },
    );

    // ── Tests recherche ──────────────────────────────────────────────────────

    testWidgets(
      'Recherche saisie + Appliquer → applied.searchQuery = texte trimé',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'One Piece');
        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        expect(
          container.read(discoverAppliedFilterProvider).searchQuery,
          'One Piece',
        );
        expect(
          container.read(discoverAppliedFilterProvider).filter,
          DiscoverFilter.none,
        );
      },
    );

    testWidgets(
      'Recherche + Prochainement + Appliquer → applied contient les deux',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Prochainement'));
        await tester.pump();
        await tester.enterText(find.byType(TextField), 'Naruto');
        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        final applied = container.read(discoverAppliedFilterProvider);
        expect(applied.searchQuery, 'Naruto');
        expect(applied.filter, DiscoverFilter.soon);
      },
    );

    testWidgets(
      'Recherche vide ("") + Appliquer → applied.searchQuery est null',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        expect(container.read(discoverAppliedFilterProvider).searchQuery, isNull);
      },
    );

    testWidgets(
      'Recherche composée uniquement d\'espaces + Appliquer → applied.searchQuery est null',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), '   ');
        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        expect(container.read(discoverAppliedFilterProvider).searchQuery, isNull);
      },
    );

    testWidgets(
      'Trim : espaces avant/après supprimés avant application',
      (tester) async {
        final (:router, :container, :widget) = setupRouterSubject();
        addTearDown(container.dispose);

        await tester.pumpWidget(widget);
        router.push('/filters');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), '  One Piece  ');
        await tester.tap(find.text('Appliquer'));
        await tester.pumpAndSettle();

        expect(
          container.read(discoverAppliedFilterProvider).searchQuery,
          'One Piece',
        );
      },
    );

    testWidgets(
      'Saisie sans Appliquer → applied.searchQuery inchangé',
      (tester) async {
        DiscoverFilterCriteria? seen;

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.dark,
              home: Consumer(
                builder: (context, ref, _) {
                  seen = ref.watch(discoverAppliedFilterProvider);
                  return const DiscoverFiltersScreen();
                },
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField), 'One Piece');
        await tester.pump();

        expect(seen?.searchQuery, isNull);
      },
    );

    testWidgets(
      "Réouverture : champ initialisé avec la recherche appliquée",
      (tester) async {
        await tester.pumpWidget(
          buildSubject(
            initial: const DiscoverFilterCriteria(searchQuery: 'One Piece'),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller?.text, 'One Piece');
      },
    );

    testWidgets(
      'Réinitialiser efface le champ de recherche',
      (tester) async {
        await tester.pumpWidget(buildSubject());

        await tester.enterText(find.byType(TextField), 'One Piece');
        await tester.pump();

        await tester.tap(find.text('Réinitialiser'));
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller?.text, isEmpty);
        expect(find.text('Appliquer'), findsOneWidget);
      },
    );

    testWidgets(
      'Réinitialiser avec recherche ne modifie pas applied',
      (tester) async {
        DiscoverFilterCriteria? seen;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              discoverAppliedFilterProvider.overrideWith(
                () => _FixedFilterNotifier(
                  const DiscoverFilterCriteria(searchQuery: 'One Piece'),
                ),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.dark,
              home: Consumer(
                builder: (context, ref, _) {
                  seen = ref.watch(discoverAppliedFilterProvider);
                  return const DiscoverFiltersScreen();
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Réinitialiser'));
        await tester.pump();

        expect(seen?.searchQuery, 'One Piece');
      },
    );

    testWidgets(
      'focusSearch: false → pas de FocusNode actif au démarrage',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.dark,
              home: const DiscoverFiltersScreen(focusSearch: false),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.focusNode?.hasFocus, isFalse);
      },
    );
  });
}
