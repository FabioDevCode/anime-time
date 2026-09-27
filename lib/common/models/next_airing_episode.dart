class NextAiringEpisode {
  const NextAiringEpisode({required this.episode, required this.airingAt});

  final int? episode;
  final int? airingAt;

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) {
    return NextAiringEpisode(
      episode: json['episode'] as int?,
      airingAt: json['airingAt'] as int?,
    );
  }
}
