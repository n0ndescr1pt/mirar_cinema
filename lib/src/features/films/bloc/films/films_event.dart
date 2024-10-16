part of 'films_bloc.dart';

@freezed
class FilmsEvent with _$FilmsEvent {
  const factory FilmsEvent.started() = _Started;
}