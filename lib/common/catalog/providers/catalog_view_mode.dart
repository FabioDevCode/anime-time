import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CatalogViewMode { grid, list }

class CatalogViewModeNotifier extends Notifier<CatalogViewMode> {
  @override
  CatalogViewMode build() => CatalogViewMode.grid;

  void toggle() {
    state = state == CatalogViewMode.grid
        ? CatalogViewMode.list
        : CatalogViewMode.grid;
  }
}
