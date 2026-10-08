import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DiscoverFilter { none, soon }

/// Critères de recherche transmis à Découvrir lors de l'application des filtres.
///
/// Cette classe est conçue pour évoluer : catégories supplémentaires, etc.
/// pourront y être ajoutés sans modifier l'architecture.
class DiscoverFilterCriteria {
  const DiscoverFilterCriteria({
    this.filter = DiscoverFilter.none,
    this.searchQuery,
  });

  final DiscoverFilter filter;

  /// Texte de recherche appliqué. Toujours trimé avant d'être stocké ici ;
  /// `null` signifie « pas de recherche » (`""` n'est jamais utilisé).
  final String? searchQuery;

  bool get hasActiveFilters =>
      filter != DiscoverFilter.none || searchQuery != null;

  DiscoverFilterCriteria copyWith({
    DiscoverFilter? filter,
    String? searchQuery,
    bool clearSearch = false,
  }) {
    return DiscoverFilterCriteria(
      filter: filter ?? this.filter,
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DiscoverFilterCriteria &&
      other.filter == filter &&
      other.searchQuery == searchQuery;

  @override
  int get hashCode => Object.hash(filter, searchQuery);
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
