part of 'review_bloc.dart';

@freezed
class ReviewEvent with _$ReviewEvent {
  const factory ReviewEvent.started() = _Started;
  const factory ReviewEvent.addReviewMovie(
      {required DetailModel film,
      required String userId,
      required double review}) = _AddReviewMovie;
  const factory ReviewEvent.getReviewMovie({required String userId}) =
      _GetReviewMovie;
}
