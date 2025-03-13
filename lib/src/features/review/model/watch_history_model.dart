import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/review/model/dto/watch_history_dto.dart';

part 'watch_history_model.freezed.dart';
@freezed
class WatchHistoryModel with _$WatchHistoryModel {
  const factory WatchHistoryModel({
    required List<String> genre,
    required List<String> countries,
    required int kinopoiskId,
    required String? nameRu,
    required String? nameEn,
    required String? posterUrl,
    required String? posterUrlPreview,
    required int? ratingImdbVoteCount,
    required double? ratingKinopoisk,
    required String userId,
  }) = _WatchHistoryModel;
}

extension WatchHistoryMapper on WatchHistoryDTO {
  WatchHistoryModel toModel() => WatchHistoryModel(
        genre: genre,
        countries: countries,
        kinopoiskId: kinopoiskId,
        nameRu: nameRu,
        nameEn: nameEn,
        posterUrl: posterUrl,
        posterUrlPreview: posterUrlPreview,
        ratingImdbVoteCount: ratingImdbVoteCount,
        ratingKinopoisk: ratingKinopoisk,
        userId: userId,
      );
}
