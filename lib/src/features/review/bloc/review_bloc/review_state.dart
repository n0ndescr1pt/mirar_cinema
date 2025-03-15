part of 'review_bloc.dart';

@freezed
class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = _Initial;
  const factory ReviewState.loaded({required List<ReviewModel> reviews}) =
      _Loaded;
  const factory ReviewState.loading() = _Loading;
}
