import 'package:flutter/material.dart';
import 'package:anime_time/common/utils/html_text.dart';

class SerieDetailsSynopsisCard extends StatefulWidget {
  const SerieDetailsSynopsisCard({super.key, required this.description});

  final String? description;

  @override
  State<SerieDetailsSynopsisCard> createState() =>
      _SerieDetailsSynopsisCardState();
}

class _SerieDetailsSynopsisCardState extends State<SerieDetailsSynopsisCard> {
  bool _isExpanded = false;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final synopsis = widget.description == null
        ? ''
        : stripHtml(widget.description!);
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Synopsis',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: const Icon(Icons.expand_more_rounded),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            synopsis.isEmpty
                                ? 'Aucun synopsis disponible.'
                                : synopsis,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.45,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
