import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/review/model/dto/review_dto.dart';

part 'review_model.freezed.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required int kinopoiskId,
    required String? nameRu,
    required String? nameEn,
    required double review,
    required String? posterUrl,
    required String? posterUrlPreview,
    required int? ratingImdbVoteCount,
    required List<String> genre,
    required double? ratingKinopoisk,
    required List<String> countries,
    required String userId,
    required DateTime updateDate,
  }) = _ReviewModel;
}
extension ReviewMapper on ReviewDTO {
  ReviewModel toModel() => ReviewModel(
        kinopoiskId: kinopoiskId,
        nameRu: nameRu,
        nameEn: nameEn,
        review: review,
        posterUrl: posterUrl,
        posterUrlPreview: posterUrlPreview,
        ratingImdbVoteCount: ratingImdbVoteCount,
        genre: genre,
        ratingKinopoisk: ratingKinopoisk,
        countries: countries,
        userId: userId,
        updateDate: updateDate,
      );
}