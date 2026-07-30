import 'package:flutter/widgets.dart';
import 'package:anime_time/common/widgets/anime_catalog/paginated_anime_catalog_screen.dart';
import 'package:anime_time/features/soon/providers/soon_providers.dart';

class SoonView extends StatelessWidget {
  const SoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedAnimeCatalogScreen(
      catalogProvider: soonNotifierProvider,
      viewModeProvider: soonViewModeProvider,
      showSearch: false,
      showFilter: false,
    );
  }
}
