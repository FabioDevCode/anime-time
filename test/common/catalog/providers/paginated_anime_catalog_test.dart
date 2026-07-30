import 'package:anime_time/common/catalog/data/anime_catalog_repository.dart';
import 'package:anime_time/common/catalog/providers/paginated_anime_catalog.dart';
import 'package:anime_time/common/models/anime_media.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads subsequent pages with the shared pagination size', () async {
    final repository = _FakeAnimeCatalogRepository();
    final repositoryProvider = Provider<AnimeCatalogRepository>(
      (ref) => repository,
    );
    final catalogProvider =
        NotifierProvider<
          PaginatedAnimeCatalogNotifier,
          PaginatedAnimeCatalogState
        >(
          () => PaginatedAnimeCatalogNotifier(
            repositoryProvider,
            debugLabel: 'TEST',
          ),
        );
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.listen(catalogProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);

    expect(container.read(catalogProvider).items, hasLength(1));
    expect(repository.requests, [(page: 1, perPage: 24)]);

    await container.read(catalogProvider.notifier).loadNextPage();

    expect(container.read(catalogProvider).items, hasLength(2));
    expect(repository.requests, [
      (page: 1, perPage: 24),
      (page: 2, perPage: 24),
    ]);
  });
}

class _FakeAnimeCatalogRepository implements AnimeCatalogRepository {
  final requests = <({int page, int perPage})>[];

  @override
  Future<AnimeCatalogPage> fetchPage({
    required int page,
    required int perPage,
  }) async {
    requests.add((page: page, perPage: perPage));
    return AnimeCatalogPage(
      items: [AnimeMedia(id: page, status: 'NOT_YET_RELEASED')],
      currentPage: page,
      hasNextPage: page == 1,
    );
  }
}
