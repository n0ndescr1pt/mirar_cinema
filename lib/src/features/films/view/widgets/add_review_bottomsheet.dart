import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/films/view/widgets/custom_slider.dart';

void showCustomBottomSheet(BuildContext context, DetailModel film) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => BottomSheetContent(film: film),
  );
}

class BottomSheetContent extends StatelessWidget {
  final DetailModel film;
  const BottomSheetContent({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Оценить"),
                SizedBox(height: 16),
                CachedNetworkImage(
                  imageUrl: film.posterUrlPreview ??
                      "https://avatars.mds.yandex.net/i?id=0aee8c6e0ef9c5161691cc3c1c3b5361_l-5313598-images-thumbs&n=13",
                  height: 200,
                ),
                SizedBox(height: 16),
                Text(film.nameRu ?? ""),
                if (film.year != null) Text(film.year!.toString()),
                SizedBox(height: 24),
                CustomSlider(film: film, bottomsheetContext: context),
              ],
            ),
          ),
        );
      },
    );
  }
}
