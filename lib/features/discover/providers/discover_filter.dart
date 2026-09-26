import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DiscoverFilter { none, soon }

class DiscoverFilterNotifier extends Notifier<DiscoverFilter> {
  @override
  DiscoverFilter build() => DiscoverFilter.none;

  void select(DiscoverFilter filter) => state = filter;
}

final discoverActiveFilterProvider =
    NotifierProvider<DiscoverFilterNotifier, DiscoverFilter>(
      DiscoverFilterNotifier.new,
    );
