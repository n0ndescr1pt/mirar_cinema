import 'package:flutter/material.dart';
import 'package:mirar/src/features/review/model/watch_history_model.dart';
import 'package:mirar/src/features/review/view/widget/history_card.dart';
import 'package:mirar/src/theme/app_colors.dart';

class WatchHistoryList extends StatelessWidget {
  final String title;
  final List<WatchHistoryModel> films;
  final ScrollController scrollController;

  const WatchHistoryList(
      {super.key,
      required this.title,
      required this.films,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            if (films.isEmpty) Text("Пока ничего нет..."),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return HistoryPreviewCard(
                    poster: films[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
