import 'package:flutter/material.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:mirar/src/features/films/view/widgets/preview_card.dart';
import 'package:mirar/src/theme/app_colors.dart';

class FilmsCategory extends StatelessWidget {
  final String title;
  final List<PreviewModel> films;
  const FilmsCategory({super.key, required this.title, required this.films});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return PreviewCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
