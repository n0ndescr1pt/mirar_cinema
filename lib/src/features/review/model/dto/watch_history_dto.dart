import 'package:json_annotation/json_annotation.dart';

part 'watch_history_dto.g.dart';

@JsonSerializable()
class WatchHistoryDTO {
  final List<String> genre;
  final List<String> countries;
  final int kinopoiskId;
  final String? nameRu;
  final String? nameEn;
  final String? posterUrl;
  final String? posterUrlPreview;
  final int? ratingImdbVoteCount;
  final double? ratingKinopoisk;
  
  @JsonKey(fromJson: _userIdFromJson)
  final String userId;

  WatchHistoryDTO({
    required this.genre,
    required this.countries,
    required this.kinopoiskId,
    required this.nameRu,
    required this.nameEn,
    required this.posterUrl,
    required this.posterUrlPreview,
    required this.ratingImdbVoteCount,
    required this.ratingKinopoisk,
    required this.userId,
  });

  factory WatchHistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$WatchHistoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$WatchHistoryDTOToJson(this);
}

String _userIdFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json['objectId'] as String;
  }
  return '';
}