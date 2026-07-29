import 'package:flutter_test/flutter_test.dart';
import 'package:anime_time/features/anime_detail/data/models/anime_detail.dart';
import 'package:anime_time/features/anime_detail/utils/html_text.dart';

void main() {
  test('AnimeDetail maps the AniList detail response', () {
    final anime = AnimeDetail.fromJson({
      'id': 16498,
      'idMal': 1535,
      'title': {'romaji': 'Shingeki no Kyojin', 'native': '進撃の巨人'},
      'description': '<i>Synopsis</i>',
      'coverImage': {'large': 'https://example.com/cover.jpg'},
      'bannerImage': 'https://example.com/banner.jpg',
      'episodes': 25,
      'duration': 24,
      'status': 'RELEASING',
      'season': 'FALL',
      'seasonYear': 2023,
      'averageScore': 92,
      'genres': ['Action', 'Drama'],
      'nextAiringEpisode': {'episode': 12, 'airingAt': 1700000000},
    });

    expect(anime.id, 16498);
    expect(anime.titleRomaji, 'Shingeki no Kyojin');
    expect(anime.genres, ['Action', 'Drama']);
    expect(anime.nextAiringEpisode?.episode, 12);
  });

  test('stripHtml preserves AniList line breaks and removes tags', () {
    expect(
      stripHtml('<p>Premier <i>paragraphe</i>.</p><br>Second &amp; final.'),
      'Premier paragraphe.\n\nSecond & final.',
    );
  });
}
