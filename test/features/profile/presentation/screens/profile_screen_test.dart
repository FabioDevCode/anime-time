import 'dart:async';

import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/widgets/anime_catalog/anime_cover_card.dart';
import 'package:anime_time/core/theme/app_theme.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';
import 'package:anime_time/features/profile/presentation/screens/profile_screen.dart';
import 'package:anime_time/features/profile/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const profileData = ProfileData(
    statistics: ProfileStatistics(
      totalFavorites: 12,
      releasing: 4,
      upcoming: 3,
    ),
    favorites: [
      AnimeMedia(id: 1, status: 'RELEASING'),
      AnimeMedia(id: 2, status: 'FINISHED'),
    ],
    upcoming: [AnimeMedia(id: 3, status: 'NOT_YET_RELEASED')],
  );

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        profileDataProvider.overrideWith((ref) => Stream.value(profileData)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark,
        home: const Scaffold(body: ProfileScreen()),
      ),
    );
  }

  testWidgets(
    'affiche les données locales du profil dans une mise en page responsive',
    (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.bottom, isFalse);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('Favoris'), findsOneWidget);
      expect(find.text('En cours'), findsOneWidget);
      expect(find.text('À venir'), findsNWidgets(2));
      expect(find.text('Dernière mise à jour : 27/07/2026'), findsOneWidget);

      expect(find.text('Mes favoris'), findsOneWidget);
      expect(find.text('Voir plus'), findsNWidgets(2));
      expect(find.byType(AnimeCoverCard), findsNWidgets(3));
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ListView && widget.scrollDirection == Axis.horizontal,
          description: 'les deux carrousels horizontaux',
        ),
        findsNWidgets(2),
      );

      final statisticsRow = find.byWidgetPredicate(
        (widget) =>
            widget is Row && widget.children.whereType<Expanded>().length == 3,
        description: 'la ligne de statistiques à trois Expanded',
      );
      expect(statisticsRow, findsOneWidget);

      final statisticCards = find.descendant(
        of: statisticsRow,
        matching: find.byType(Card),
      );
      expect(statisticCards, findsNWidgets(3));

      final mobileCardWidth = tester.getSize(statisticCards.first).width;
      expect(
        tester.getSize(statisticCards.at(1)).width,
        closeTo(mobileCardWidth, 0.01),
      );
      expect(
        tester.getSize(statisticCards.at(2)).width,
        closeTo(mobileCardWidth, 0.01),
      );

      tester.view.physicalSize = const Size(800, 1000);
      await tester.pump();

      expect(
        tester.getSize(statisticCards.first).width,
        greaterThan(mobileCardWidth),
      );
    },
  );
}
