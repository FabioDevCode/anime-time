import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiscoverFilterCriteria', () {
    test('default has no active filters', () {
      const criteria = DiscoverFilterCriteria();
      expect(criteria.filter, DiscoverFilter.none);
      expect(criteria.searchQuery, isNull);
      expect(criteria.hasActiveFilters, isFalse);
    });

    test('soon filter is active', () {
      const criteria = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      expect(criteria.hasActiveFilters, isTrue);
    });

    test('searchQuery alone makes hasActiveFilters true', () {
      const criteria = DiscoverFilterCriteria(searchQuery: 'One Piece');
      expect(criteria.hasActiveFilters, isTrue);
    });

    test('searchQuery and soon filter both active', () {
      const criteria = DiscoverFilterCriteria(
        filter: DiscoverFilter.soon,
        searchQuery: 'One Piece',
      );
      expect(criteria.hasActiveFilters, isTrue);
    });

    test('copyWith overrides filter', () {
      const original = DiscoverFilterCriteria();
      final updated = original.copyWith(filter: DiscoverFilter.soon);
      expect(updated.filter, DiscoverFilter.soon);
      expect(updated.searchQuery, isNull);
    });

    test('copyWith overrides searchQuery', () {
      const original = DiscoverFilterCriteria(searchQuery: 'Naruto');
      final updated = original.copyWith(searchQuery: 'One Piece');
      expect(updated.searchQuery, 'One Piece');
    });

    test('copyWith clearSearch sets searchQuery to null', () {
      const original = DiscoverFilterCriteria(searchQuery: 'Naruto');
      final updated = original.copyWith(clearSearch: true);
      expect(updated.searchQuery, isNull);
    });

    test('copyWith without arguments returns equal instance', () {
      const criteria = DiscoverFilterCriteria(
        filter: DiscoverFilter.soon,
        searchQuery: 'One Piece',
      );
      expect(criteria.copyWith(), criteria);
    });

    test('equality includes searchQuery', () {
      const a = DiscoverFilterCriteria(
        filter: DiscoverFilter.soon,
        searchQuery: 'One Piece',
      );
      const b = DiscoverFilterCriteria(
        filter: DiscoverFilter.soon,
        searchQuery: 'One Piece',
      );
      const c = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(equals(c)));
    });

    test('different searchQuery values are not equal', () {
      const a = DiscoverFilterCriteria(searchQuery: 'Naruto');
      const b = DiscoverFilterCriteria(searchQuery: 'One Piece');
      expect(a, isNot(equals(b)));
    });
  });

  group('DiscoverFilterNotifier', () {
    ProviderContainer buildContainer() {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      return container;
    }

    test('initial state has no active filters', () {
      final container = buildContainer();
      expect(
        container.read(discoverAppliedFilterProvider).hasActiveFilters,
        isFalse,
      );
      expect(
        container.read(discoverAppliedFilterProvider).filter,
        DiscoverFilter.none,
      );
      expect(
        container.read(discoverAppliedFilterProvider).searchQuery,
        isNull,
      );
    });

    test('apply updates state with filter and searchQuery', () {
      final container = buildContainer();
      const criteria = DiscoverFilterCriteria(
        filter: DiscoverFilter.soon,
        searchQuery: 'One Piece',
      );

      container.read(discoverAppliedFilterProvider.notifier).apply(criteria);

      expect(container.read(discoverAppliedFilterProvider), criteria);
      expect(
        container.read(discoverAppliedFilterProvider).hasActiveFilters,
        isTrue,
      );
    });

    test('apply with empty criteria clears active filters', () {
      final container = buildContainer();
      container.read(discoverAppliedFilterProvider.notifier).apply(
        const DiscoverFilterCriteria(
          filter: DiscoverFilter.soon,
          searchQuery: 'One Piece',
        ),
      );

      container.read(discoverAppliedFilterProvider.notifier).apply(
        const DiscoverFilterCriteria(),
      );

      expect(
        container.read(discoverAppliedFilterProvider).hasActiveFilters,
        isFalse,
      );
      expect(
        container.read(discoverAppliedFilterProvider).searchQuery,
        isNull,
      );
    });
  });
}
