part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _InitialState;
  const factory SearchState.error({required String error}) = _ErrorState;
  const factory SearchState.loading() = _LoadingState;
  const factory SearchState.loaded({required List<SearchModel> films}) = _LoadedState;
}
