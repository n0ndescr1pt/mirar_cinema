import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';

@freezed
class SearchModel with _$SearchModel {
  const factory SearchModel({
    required int kinopoiskId,
    required String? nameRu,
    required String? nameEn,
    required String? nameOriginal,
    required List<String> countries,
    required List<String> genres,
    required String? rating,
    required String? year,
    required String? type,
    required String? posterUrl,
    required String? posterUrlPreview,
  }) = _SearchModel;
}
