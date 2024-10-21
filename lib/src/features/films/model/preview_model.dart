import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';

part 'preview_model.freezed.dart';

@freezed
class PreviewModel with _$PreviewModel {
  const factory PreviewModel({
    required int filmId,
    required String nameRu,
    required String? nameEn,
    required String type,
    required String year,
    required String? description,
    required String? filmLength,
    required List<String> countries,
    required List<String> genres,
    required String rating,
    required int ratingVoteCount,
    required String posterUrl,
    required String posterUrlPreview,
  }) = _PreviewModel;
}

extension PreviewDTOMapper on PreviewDTO {
  PreviewModel toModel() {
    return PreviewModel(
      filmId: filmId,
      nameRu: nameRu,
      nameEn: nameEn,
      type: type,
      year: year,
      description: description,
      filmLength: filmLength,
      countries: countries,
      genres: genres,
      rating: rating,
      ratingVoteCount: ratingVoteCount,
      posterUrl: posterUrl,
      posterUrlPreview: posterUrlPreview,
    );
  }
}
