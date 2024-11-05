import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'film_event.dart';
part 'film_state.dart';
part 'film_bloc.freezed.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final Talker _talker;
  final IFilmRepository _filmRepository;

  FilmBloc({required Talker talker, required IFilmRepository filmRepository})
      : _filmRepository = filmRepository,
        _talker = talker,
        super(const FilmState.initial()) {
    on<_LoadDetailsEvent>(_loadDetails);
  }

  _loadDetails(_LoadDetailsEvent event, Emitter<FilmState> emit) async {
    try {
      final filmDetails = await _filmRepository.fetchDetailFilm(event.filmId);
      emit(FilmState.loaded(film: filmDetails));
    } catch (e, st) {
      _talker.error(e, st);
    }
  }
}
