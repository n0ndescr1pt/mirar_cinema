import 'package:flutter/material.dart';
import 'package:mirar/src/features/review/model/review_model.dart';
import 'package:mirar/src/features/review/view/widget/review_card.dart';
import 'package:mirar/src/theme/app_colors.dart';

class ReviewList extends StatelessWidget {
  final String title;
  final ScrollController scrollController;
  final List<ReviewModel> films;
  const ReviewList(
      {super.key,
      required this.title,
      required this.scrollController,
      required this.films});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ...films.map((film) => ReviewCard(film: film)).toList(),
      ],
    );
  }
}
