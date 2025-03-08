import 'package:flutter/material.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:mirar/src/features/films/view/widgets/preview_card.dart';
import 'package:mirar/src/theme/app_colors.dart';

class FilmsCategory extends StatelessWidget {
  final String title;
  final List<PreviewModel> films;
  final ScrollController scrollController;

  const FilmsCategory(
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
                  .displaySmall
                  ?.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return PreviewCard(
                    poster: films[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
