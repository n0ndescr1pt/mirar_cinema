import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/films/bloc/search/search_bloc.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:mirar/src/features/films/view/film_screen.dart';
import 'package:mirar/src/features/films/view/widgets/search_widget.dart';
import 'package:mirar/src/injectable/init_injectable.dart';
import 'package:mirar/src/theme/app_colors.dart';
import 'package:searchfield/searchfield.dart';

class MovieSearchField extends StatefulWidget {
  const MovieSearchField({super.key});

  @override
  State<MovieSearchField> createState() => _MovieSearchFieldState();
}

class _MovieSearchFieldState extends State<MovieSearchField> {
  final FocusNode _focusNode = FocusNode();
  SearchController searchController = SearchController();
  List<SearchFieldListItem<PreviewModel>> suggestions = [];
  List<SearchFieldListItem<PreviewModel>> result = [];
  Suggestion currentSuggestionState = Suggestion.expand;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      bloc: getIt<SearchBloc>(),
      listener: (context, state) {
        state.whenOrNull(
          loaded: (films) {
            suggestions = films.map((film) {
              return SearchFieldListItem<PreviewModel>(
                film.nameRu,
                item: film,
                child: SearchWidget(film: film),
              );
            }).toList();
            setState(() {
              result = suggestions;
            });
          },
        );
      },
      child: SearchField(
        suggestionState: currentSuggestionState,
        focusNode: _focusNode,
        controller: searchController,
        itemHeight: 100,
        onSearchTextChanged: (searchText) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 400), () {
            if (searchText.isNotEmpty) {
              getIt<SearchBloc>().add(SearchEvent.search(title: searchText));
            }
          });

          return result;
        },
        searchInputDecoration: SearchInputDecoration(
          hintStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.inactiveIcon),
          suffix: const Icon(
            Icons.search,
            color: AppColors.inactiveIcon,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: InputBorder.none,
          hintText: "Поиск",
          labelStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.text,
              ),
          searchStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.inactiveIcon),
        ),
        suggestions: result,
        onSuggestionTap: (SearchFieldListItem<PreviewModel> suggestion) {
          _focusNode.unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilmScreen(
                      kinoposikId: suggestion.item!.filmId.toString())));
        },
      ),
    );
  }
}
