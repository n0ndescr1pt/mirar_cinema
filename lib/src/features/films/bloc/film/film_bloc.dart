import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_event.dart';
part 'film_state.dart';
part 'film_bloc.freezed.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  FilmBloc() : super(_Initial()) {
    on<FilmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
