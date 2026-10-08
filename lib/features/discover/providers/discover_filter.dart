import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DiscoverFilter { none, soon }

/// Critères de recherche transmis à Découvrir lors de l'application des filtres.
///
/// Cette classe est conçue pour évoluer : [searchQuery], des catégories
/// supplémentaires, etc. pourront y être ajoutés sans modifier l'architecture.
class DiscoverFilterCriteria {
  const DiscoverFilterCriteria({this.filter = DiscoverFilter.none});

  final DiscoverFilter filter;

  bool get hasActiveFilters => filter != DiscoverFilter.none;

  DiscoverFilterCriteria copyWith({DiscoverFilter? filter}) {
    return DiscoverFilterCriteria(filter: filter ?? this.filter);
  }

  @override
  bool operator ==(Object other) =>
      other is DiscoverFilterCriteria && other.filter == filter;

  @override
  int get hashCode => filter.hashCode;
}

class DiscoverFilterNotifier extends Notifier<DiscoverFilterCriteria> {
  @override
  DiscoverFilterCriteria build() => const DiscoverFilterCriteria();

  void apply(DiscoverFilterCriteria criteria) => state = criteria;
}

final discoverAppliedFilterProvider =
    NotifierProvider<DiscoverFilterNotifier, DiscoverFilterCriteria>(
      DiscoverFilterNotifier.new,
    );
