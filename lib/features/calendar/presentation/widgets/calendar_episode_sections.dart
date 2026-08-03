import 'package:anime_time/features/calendar/data/models/calendar_episode.dart';
import 'package:anime_time/features/calendar/presentation/widgets/calendar_episode_card.dart';
import 'package:flutter/material.dart';

class CalendarEpisodeSections extends StatelessWidget {
  const CalendarEpisodeSections({super.key, required this.episodes});

  final List<CalendarEpisode> episodes;

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(episodes, DateTime.now());

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 112),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 20),
          child: _CalendarSection(section: section),
        );
      },
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection({required this.section});

  final _EpisodeSection section;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   section.title,
        //   style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        // ),
        // const SizedBox(height: 8),
        for (final episode in section.episodes) ...[
          CalendarEpisodeCard(
            episode: episode,
            scheduleLabel: _scheduleLabel(episode.airingAt, DateTime.now()),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

List<_EpisodeSection> _buildSections(
  List<CalendarEpisode> episodes,
  DateTime now,
) {
  final today = DateUtils.dateOnly(now);
  final tomorrow = today.add(const Duration(days: 1));
  final endOfWeek = today.add(
    Duration(days: DateTime.daysPerWeek - today.weekday),
  );
  final sections = <_EpisodeSection>[];
  final laterByDay = <DateTime, List<CalendarEpisode>>{};
  final todayEpisodes = <CalendarEpisode>[];
  final tomorrowEpisodes = <CalendarEpisode>[];
  final thisWeekEpisodes = <CalendarEpisode>[];

  for (final episode in episodes) {
    final date = DateUtils.dateOnly(episode.airingAt);
    if (date == today) {
      todayEpisodes.add(episode);
    } else if (date == tomorrow) {
      tomorrowEpisodes.add(episode);
    } else if (!date.isAfter(endOfWeek)) {
      thisWeekEpisodes.add(episode);
    } else {
      laterByDay.putIfAbsent(date, () => []).add(episode);
    }
  }

  if (todayEpisodes.isNotEmpty) {
    sections.add(_EpisodeSection('Aujourd’hui', todayEpisodes));
  }
  if (tomorrowEpisodes.isNotEmpty) {
    sections.add(_EpisodeSection('Demain', tomorrowEpisodes));
  }
  if (thisWeekEpisodes.isNotEmpty) {
    sections.add(_EpisodeSection('Cette semaine', thisWeekEpisodes));
  }
  for (final entry in laterByDay.entries) {
    sections.add(_EpisodeSection(_dayHeading(entry.key), entry.value));
  }

  return sections;
}

String _scheduleLabel(DateTime airingAt, DateTime now) {
  final date = DateUtils.dateOnly(airingAt);
  final today = DateUtils.dateOnly(now);
  final tomorrow = today.add(const Duration(days: 1));
  final day = switch (date) {
    _ when date == today => 'Aujourd’hui',
    _ when date == tomorrow => 'Demain',
    _ => _weekdayName(airingAt.weekday),
  };

  return '$day • ${_twoDigits(airingAt.hour)}h${_twoDigits(airingAt.minute)}';
}

String _dayHeading(DateTime date) =>
    '${_weekdayName(date.weekday)} ${date.day} ${_monthName(date.month)}';

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

class _EpisodeSection {
  const _EpisodeSection(this.title, this.episodes);

  final String title;
  final List<CalendarEpisode> episodes;
}
