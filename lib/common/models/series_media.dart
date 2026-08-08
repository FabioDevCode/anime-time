class SeriesMedia {
  const SeriesMedia({
    required this.seriesId,
    required this.latestAnimeId,
    this.displayTitleRomaji,
    this.displayTitleEnglish,
    this.displayTitleNative,
    this.coverImage,
  });

  final int seriesId;
  final int latestAnimeId;
  final String? displayTitleRomaji;
  final String? displayTitleEnglish;
  final String? displayTitleNative;
  final String? coverImage;
}
