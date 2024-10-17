import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mirar/src/theme/app_colors.dart';

class PreviewCard extends StatelessWidget {
  const PreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 132,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: DecoratedBox(
              decoration:
                  const BoxDecoration(color: AppColors.activeIconBackground),
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColors.text,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 132),
          child: Text(
            "The Batman a big dick sucker ",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.text),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
