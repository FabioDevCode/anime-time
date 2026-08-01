import 'package:anime_time/core/theme/app_theme.dart';
import 'package:anime_time/features/favorites/presentation/widgets/favorite_anime_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject({
    required bool isFavorite,
    Future<void> Function()? onAdd,
    Future<void> Function()? onRemove,
  }) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 320,
            child: FavoriteAnimeButton(
              isFavorite: isFavorite,
              isProcessing: false,
              onAdd: onAdd ?? () async {},
              onRemove: onRemove ?? () async {},
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('affiche l’action d’ajout lorsqu’un anime est absent', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject(isFavorite: false));

    expect(find.text('Ajouter aux favoris'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
    expect(find.bySemanticsLabel('Retirer des favoris'), findsNothing);
  });

  testWidgets('affiche l’indicateur et le bouton de retrait pour un favori', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject(isFavorite: true));

    expect(find.text('Favoris'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.bySemanticsLabel('Retirer des favoris'), findsOneWidget);
  });

  testWidgets('demande confirmation avant de retirer un anime', (tester) async {
    var removeCalls = 0;

    await tester.pumpWidget(
      buildSubject(
        isFavorite: true,
        onRemove: () async {
          removeCalls++;
        },
      ),
    );

    await tester.tap(find.bySemanticsLabel('Retirer des favoris'));
    await tester.pumpAndSettle();

    expect(find.text('Retirer des favoris ?'), findsOneWidget);
    expect(find.text('Cet anime sera retiré de vos favoris.'), findsOneWidget);

    final removeButton = find.widgetWithText(
      FilledButton,
      'Retirer des favoris',
    );
    final cancelButton = find.widgetWithText(OutlinedButton, 'Annuler');
    expect(
      tester.getSize(removeButton).width,
      closeTo(tester.getSize(cancelButton).width, 0.1),
    );

    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();
    expect(removeCalls, 0);

    await tester.tap(find.bySemanticsLabel('Retirer des favoris'));
    await tester.pumpAndSettle();
    await tester.tap(removeButton);
    await tester.pumpAndSettle();

    expect(removeCalls, 1);
  });
}
