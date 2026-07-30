import 'package:flutter/widgets.dart';
import 'package:anime_time/common/widgets/anime_catalog/paginated_anime_catalog_screen.dart';
import 'package:anime_time/features/discover/providers/discover_providers.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedAnimeCatalogScreen(
      catalogProvider: discoverNotifierProvider,
      viewModeProvider: discoverViewModeProvider,
    );
  }
}
