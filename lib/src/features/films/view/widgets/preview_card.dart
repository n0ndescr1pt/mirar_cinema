import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:mirar/src/theme/app_colors.dart';

class PreviewCard extends StatelessWidget {
  final PreviewModel poster;
  const PreviewCard({super.key, required this.poster});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.goNamed(AppRoute.film.name,
            pathParameters: {'kinoposikId': poster.kinopoiskId.toString()});
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 180,
                width: 122,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: AppColors.activeIconBackground),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: poster.posterUrl ??
                          "https://avatars.mds.yandex.net/i?id=0aee8c6e0ef9c5161691cc3c1c3b5361_l-5313598-images-thumbs&n=13",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 122),
                child: Text(
                  poster.nameRu != null ? poster.nameRu! : poster.nameEn ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.text),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          if (poster.ratingKinopoisk != null)
            Positioned(
              left: 6,
              top: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4)
                ),
                width: 36,
                height: 20,
                child: Text(
                  poster.ratingKinopoisk.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
