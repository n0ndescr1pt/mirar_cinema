import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'film_event.dart';
part 'film_state.dart';
part 'film_bloc.freezed.dart';

@singleton
class FilmBloc extends Bloc<FilmEvent, FilmState> {
  FilmBloc() : super(const FilmState.initial()) {
    on<FilmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
