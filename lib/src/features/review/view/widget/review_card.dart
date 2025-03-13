import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/review/model/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel film;
  const ReviewCard({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.film.name,
            pathParameters: {'kinoposikId': film.kinopoiskId.toString()});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('d MMMM yyyy', 'ru').format(film.updateDate),
            ),
            const SizedBox(height: 8),
            // Используем LayoutBuilder для получения конечных ограничений
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Постер
                CachedNetworkImage(
                  width: 75,
                  height: 105,
                  fit: BoxFit.cover,
                  imageUrl: film.posterUrlPreview ??
                      "https://avatars.mds.yandex.net/i?id=0aee8c6e0ef9c5161691cc3c1c3b5361_l-5313598-images-thumbs&n=13",
                ),
                const SizedBox(width: 12),
                // Остальная информация занимает оставшееся пространство
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (film.nameRu != null)
                        Text(
                          film.nameRu!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      if (film.nameEn != null)
                        Text(
                          film.nameEn!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        film.genre.take(3).join(', '),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      // Ряд с рейтингами, оценкой и страной
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (film.ratingKinopoisk != null)
                            Text(
                              film.ratingKinopoisk!.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          const SizedBox(width: 4),
                          if (film.ratingImdbVoteCount != null)
                            Text(
                              film.ratingImdbVoteCount!.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              film.review.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Используем Expanded, чтобы занять всё оставшееся пространство
                          Spacer(),
                          Text(
                            film.countries.first,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
