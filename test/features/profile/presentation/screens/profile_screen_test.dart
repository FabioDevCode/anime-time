import 'dart:async';

import 'package:anime_time/common/models/anime_media.dart';
import 'package:anime_time/common/models/series_media.dart';
import 'package:anime_time/common/utils/anime_status.dart';
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
    releasing: [SeriesMedia(seriesId: 1, latestAnimeId: 1)],
    upcoming: [AnimeMedia(id: 3, status: 'NOT_YET_RELEASED')],
  );

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        profileDataProvider.overrideWith((ref) => Stream.value(profileData)),
        favoriteSeriesListProvider.overrideWith(
          (ref) => Stream.value(const []),
        ),
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
      expect(find.text('favoris'), findsOneWidget);
      expect(find.text('En cours'), findsOneWidget);
      expect(find.text('À venir'), findsOneWidget);
      // "En cours" utilise _SeriesCoverCard, seule la section "À venir" utilise AnimeCoverCard.
      expect(find.byType(AnimeCoverCard), findsOneWidget);
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
      expect(
        tester.widget<Card>(statisticCards.first).color,
        'FINISHED'.badgeData!.backgroundColor,
      );
      expect(
        tester.widget<Card>(statisticCards.at(1)).color,
        'RELEASING'.badgeData!.backgroundColor,
      );
      expect(
        tester.widget<Card>(statisticCards.at(2)).color,
        'NOT_YET_RELEASED'.badgeData!.backgroundColor,
      );

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
