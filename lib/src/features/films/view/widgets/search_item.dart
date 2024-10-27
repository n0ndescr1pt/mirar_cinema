import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';

class SearchItemWidget extends StatelessWidget {
  final PreviewModel film;
  const SearchItemWidget({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.goNamed(AppRoute.film.name,
              pathParameters: {'kinoposikId': film.filmId.toString()});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 300),
                fit: BoxFit.fill,
                placeholder: (context, url) => const SizedBox(
                  height: 88,
                  width: 60,
                ),
                width: 60,
                height: 88,
                imageUrl: film.posterUrlPreview,
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: constraints.maxWidth / 1.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.nameRu,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      film.nameEn ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(film.rating),
              const SizedBox(width: 12),
            ],
          ),
        ),
      );
    });
  }
}
