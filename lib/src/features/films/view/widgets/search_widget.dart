import 'package:flutter/material.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';

class SearchWidget extends StatelessWidget {
  final PreviewModel film;
  const SearchWidget({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Image.network(film.posterUrl, width: 60),
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
      );
    });
  }
}
