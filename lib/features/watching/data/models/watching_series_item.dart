class WatchingSeriesItem {
  const WatchingSeriesItem({
    required this.seriesId,
    required this.unwatchedSeasonNumbers,
    this.displayTitle,
    this.coverImage,
  });

  final int seriesId;
  final String? displayTitle;
  final String? coverImage;

  /// Saisons non terminées, triées par numéro croissant (NOT_YET_RELEASED exclues).
  final List<int> unwatchedSeasonNumbers;
}
