part of 'film_bloc.dart';

@freezed
class FilmState with _$FilmState {
  const factory FilmState.initial() = _InitialState;
  const factory FilmState.loaded({required DetailModel film}) = _LoadedState;
}
