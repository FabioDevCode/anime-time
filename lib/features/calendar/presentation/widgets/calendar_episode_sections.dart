import 'package:anime_time/features/calendar/data/models/calendar_episode.dart';
import 'package:anime_time/features/calendar/presentation/widgets/calendar_episode_card.dart';
import 'package:flutter/material.dart';

class CalendarEpisodeSections extends StatelessWidget {
  const CalendarEpisodeSections({super.key, required this.episodes});

  final List<CalendarEpisode> episodes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 112),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
          child: CalendarEpisodeCard(
            episode: episode,
            scheduleLabel: _scheduleLabel(episode.airingAt),
          ),
        );
      },
    );
  }
}

String _scheduleLabel(DateTime airingAt) =>
    '${_weekdayName(airingAt.weekday)} ${airingAt.day} ${_monthName(airingAt.month)} • ${_twoDigits(airingAt.hour)}h${_twoDigits(airingAt.minute)}';

String _weekdayName(int weekday) => const [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'Vendredi',
  'Samedi',
  'Dimanche',
][weekday - 1];

String _monthName(int month) => const [
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
][month - 1];

String _twoDigits(int value) => value.toString().padLeft(2, '0');
