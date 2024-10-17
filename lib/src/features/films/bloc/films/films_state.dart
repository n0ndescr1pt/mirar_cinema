part of 'films_bloc.dart';

@freezed
class FilmsState with _$FilmsState {
  const factory FilmsState.initial() = _InitialState;
  const factory FilmsState.loading() = _LoadingState;
  const factory FilmsState.loaded({
    required List<PreviewModel> topRated,
    required List<PreviewModel> upcoming,
    required List<PreviewModel> popular,
  }) = _LoadedState;
  const factory FilmsState.error({required String error}) = _ErrorState;
}
