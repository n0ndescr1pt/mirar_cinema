part of 'films_bloc.dart';

@freezed
class FilmsEvent with _$FilmsEvent {
  const factory FilmsEvent.loadTopRated() = _LoadTopRatedEvent;
  const factory FilmsEvent.loadPopular() = _LoadPopularEvent;
  const factory FilmsEvent.loadUpcoming() = _LoadUpcomingEvent;
}
