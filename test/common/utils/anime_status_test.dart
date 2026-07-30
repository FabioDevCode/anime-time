import 'package:anime_time/common/utils/anime_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NOT_YET_RELEASED is displayed as À venir', () {
    expect('NOT_YET_RELEASED'.badgeData?.label, 'À venir');
  });
}
