part of 'film_bloc.dart';

@freezed
class FilmEvent with _$FilmEvent {
  const factory FilmEvent.clearDetails() = _ClearDetailsEvent;
  const factory FilmEvent.loadDetails({required String filmId}) = _LoadDetailsEvent;
}