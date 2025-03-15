import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview_model.freezed.dart';

@freezed
class PreviewModel with _$PreviewModel {
  const factory PreviewModel({
    required int kinopoiskId,
    required String? nameRu,
    required String? nameEn,
    required String? nameOriginal,
    required List<String> countries,
    required List<String> genres,
    required double? ratingKinopoisk,
    required double? ratingImdb,
    required int? year,
    required String? type,
    required String? posterUrl,
    required String? posterUrlPreview,
    required String? premiereRu,
  }) = _PreviewModel;
}
