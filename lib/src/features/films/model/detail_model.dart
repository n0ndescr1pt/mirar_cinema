import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/dto/detail_dto.dart';

part 'detail_model.freezed.dart';

@freezed
class DetailModel with _$DetailModel {
  const factory DetailModel({
    required int kinopoiskId,
    required String? kinopoiskHDId,
    required String? imdbId,
    required String? nameRu,
    required String? nameEn,
    required String? nameOriginal,
    required String? posterUrl,
    required String? posterUrlPreview,
    required String? coverUrl,
    required String? logoUrl,
    required int? reviewsCount,
    required double? ratingGoodReview,
    required int? ratingGoodReviewVoteCount,
    required double? ratingKinopoisk,
    required int? ratingKinopoiskVoteCount,
    required double? ratingImdb,
    required int? ratingImdbVoteCount,
    required double? ratingFilmCritics,
    required int? ratingFilmCriticsVoteCount,
    required double? ratingAwait,
    required int? ratingAwaitCount,
    required double? ratingRfCritics,
    required int? ratingRfCriticsVoteCount,
    required String? webUrl,
    required int? year,
    required int? filmLength,
    required String? slogan,
    required String? description,
    required String? shortDescription,
    required String? editorAnnotation,
    required bool? isTicketsAvailable,
    required String? productionStatus,
    required String? type,
    required String? ratingMpaa,
    required String? ratingAgeLimits,
    required bool? hasImax,
    required bool? has3D,
    required String? lastSync,
    required List<String> countries,
    required List<String> genres,
    required int? startYear,
    required int? endYear,
    required bool? serial,
    required bool? shortFilm,
    required bool? completed,
  }) = _DetailModel;
}

extension DetailDTOMapper on DetailDTO {
  DetailModel toModel() {
    return DetailModel(
      kinopoiskId: kinopoiskId,
      kinopoiskHDId: kinopoiskHDId,
      imdbId: imdbId,
      nameRu: nameRu,
      nameEn: nameEn,
      nameOriginal: nameOriginal,
      posterUrl: posterUrl,
      posterUrlPreview: posterUrlPreview,
      coverUrl: coverUrl,
      logoUrl: logoUrl,
      reviewsCount: reviewsCount,
      ratingGoodReview: ratingGoodReview,
      ratingGoodReviewVoteCount: ratingGoodReviewVoteCount,
      ratingKinopoisk: ratingKinopoisk,
      ratingKinopoiskVoteCount: ratingKinopoiskVoteCount,
      ratingImdb: ratingImdb,
      ratingImdbVoteCount: ratingImdbVoteCount,
      ratingFilmCritics: ratingFilmCritics,
      ratingFilmCriticsVoteCount: ratingFilmCriticsVoteCount,
      ratingAwait: ratingAwait,
      ratingAwaitCount: ratingAwaitCount,
      ratingRfCritics: ratingRfCritics,
      ratingRfCriticsVoteCount: ratingRfCriticsVoteCount,
      webUrl: webUrl,
      year: year,
      filmLength: filmLength,
      slogan: slogan,
      description: description,
      shortDescription: shortDescription,
      editorAnnotation: editorAnnotation,
      isTicketsAvailable: isTicketsAvailable,
      productionStatus: productionStatus,
      type: type,
      ratingMpaa: ratingMpaa,
      ratingAgeLimits: ratingAgeLimits,
      hasImax: hasImax,
      has3D: has3D,
      lastSync: lastSync,
      countries: countries,
      genres: genres,
      startYear: startYear,
      endYear: endYear,
      serial: serial,
      shortFilm: shortFilm,
      completed: completed,
    );
  }
}

extension DetailModelExtension on DetailModel {
  Map<String, dynamic> toWatchHistory(String userId) {
    return {
      'kinopoiskId': kinopoiskId,
      'nameRu': nameRu,
      'nameEn': nameOriginal,
      'posterUrl': posterUrl,
      'posterUrlPreview': posterUrlPreview,
      'ratingImdbVoteCount': ratingImdbVoteCount ?? 0,
      'genre': genres,
      'ratingKinopoisk': ratingKinopoisk ?? 0.0,
      'countries': countries,
      'userId': userId,
    };
  }
}

extension ReviewModelExtension on DetailModel {
  Map<String, dynamic> toReviewHistoryMap(String userId, double review) {
    return {
      'kinopoiskId': kinopoiskId,
      'nameRu': nameRu,
      'nameEn': nameOriginal,
      'review': review,
      'posterUrl': posterUrl,
      'posterUrlPreview': posterUrlPreview,
      'ratingImdbVoteCount': ratingImdbVoteCount,
      'genre': genres,
      'ratingKinopoisk': ratingKinopoisk,
      'countries': countries,
      'userId': userId,
    };
  }
}
