import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'films_event.dart';
part 'films_state.dart';
part 'films_bloc.freezed.dart';

@singleton
class FilmsBloc extends Bloc<FilmsEvent, FilmsState> {
  final Talker _talker;
  final IFilmRepository _filmRepository;

  List<PreviewModel> topRated = [];
  List<PreviewModel> upcoming = [];
  List<PreviewModel> popular = [];
  FilmsBloc({required Talker talker, required IFilmRepository filmRepository})
      : _talker = talker,
        _filmRepository = filmRepository,
        super(const FilmsState.initial()) {
    on<_LoadTopRatedEvent>(_onLoadTopRated);
    on<_LoadUpcomingEvent>(_onLoadUpcoming);
    on<_LoadPopularEvent>(_onLoadPopular);
  }

  _onLoadTopRated(_LoadTopRatedEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      final newTopRated = await _filmRepository.fetchTopRated();
      emit(FilmsState.loaded(
          topRated: newTopRated, upcoming: upcoming, popular: popular));
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }

  _onLoadPopular(_LoadPopularEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      final newPopular = await _filmRepository.fetchPopular();
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: newPopular));
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }

  _onLoadUpcoming(_LoadUpcomingEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      final newUpcoming = await _filmRepository.fetchUpcoming();
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: newUpcoming, popular: popular));
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }
}
