import 'package:anime_time/features/discover/providers/discover_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiscoverFilterCriteria', () {
    test('default has no active filters', () {
      const criteria = DiscoverFilterCriteria();
      expect(criteria.filter, DiscoverFilter.none);
      expect(criteria.hasActiveFilters, isFalse);
    });

    test('soon filter is active', () {
      const criteria = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      expect(criteria.hasActiveFilters, isTrue);
    });

    test('copyWith overrides filter', () {
      const original = DiscoverFilterCriteria();
      final updated = original.copyWith(filter: DiscoverFilter.soon);
      expect(updated.filter, DiscoverFilter.soon);
    });

    test('copyWith without arguments returns equal instance', () {
      const criteria = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      expect(criteria.copyWith(), criteria);
    });

    test('equality and hashCode', () {
      const a = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      const b = DiscoverFilterCriteria(filter: DiscoverFilter.soon);
      const c = DiscoverFilterCriteria();
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(equals(c)));
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
      expect(container.read(discoverAppliedFilterProvider).hasActiveFilters, isFalse);
      expect(container.read(discoverAppliedFilterProvider).filter, DiscoverFilter.none);
    });

    test('apply updates state to provided criteria', () {
      final container = buildContainer();
      const criteria = DiscoverFilterCriteria(filter: DiscoverFilter.soon);

      container.read(discoverAppliedFilterProvider.notifier).apply(criteria);

      expect(container.read(discoverAppliedFilterProvider), criteria);
      expect(container.read(discoverAppliedFilterProvider).hasActiveFilters, isTrue);
    });

    test('apply with none clears active filters', () {
      final container = buildContainer();
      container.read(discoverAppliedFilterProvider.notifier).apply(
        const DiscoverFilterCriteria(filter: DiscoverFilter.soon),
      );

      container.read(discoverAppliedFilterProvider.notifier).apply(
        const DiscoverFilterCriteria(),
      );

      expect(container.read(discoverAppliedFilterProvider).hasActiveFilters, isFalse);
    });
  });
}
