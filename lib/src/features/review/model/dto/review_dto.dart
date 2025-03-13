import 'package:json_annotation/json_annotation.dart';

part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDTO {
  final int kinopoiskId;
  final String? nameRu;
  final String? nameEn;
  final double review;
  final String? posterUrl;
  final String? posterUrlPreview;
  final int? ratingImdbVoteCount;
  final List<String> genre;
  final double? ratingKinopoisk;
  final List<String> countries;
  @JsonKey(fromJson: _userIdFromJson)
  final String userId;
  @JsonKey(fromJson: _updateDateFromJson)
  final DateTime updateDate;

  ReviewDTO({
    required this.kinopoiskId,
    required this.nameRu,
    required this.nameEn,
    required this.review,
    required this.posterUrl,
    required this.posterUrlPreview,
    required this.ratingImdbVoteCount,
    required this.genre,
    required this.ratingKinopoisk,
    required this.countries,
    required this.userId,
    required this.updateDate,
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewDTOToJson(this);
}

String _userIdFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json['objectId'] as String;
  }
  return '';
}

DateTime _updateDateFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    final date = json['updateDate'] as String;
    return DateTime.parse(date);
  }
  return DateTime.now();
}
