import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';
import 'package:mirar/src/features/films/bloc/search/search_bloc.dart';
import 'package:mirar/src/features/films/model/search_model.dart';
import 'package:mirar/src/features/films/utils/scroll_manager.dart';
import 'package:mirar/src/features/films/view/widgets/films_category.dart';
import 'package:mirar/src/features/films/view/widgets/search_bar.dart';
import 'package:mirar/src/features/films/view/widgets/search_item.dart';
import 'package:mirar/src/features/films/view/widgets/shimmer_widget.dart';
import 'package:mirar/src/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  bool _showResults = false;
  List<SearchModel> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  late ScrollManager scrollControllerPopular;
  late ScrollManager scrollControllerTopRated;
  @override
  void initState() {
    _loadFeed();
    _loadScrollController();
    super.initState();
  }

  void _loadScrollController() {
    scrollControllerPopular = ScrollManager(
        context: context,
        scrollController: ScrollController(),
        onLoadMore: () {
          context.read<FilmsBloc>().add(const FilmsEvent.loadPopular());
        });
    scrollControllerTopRated = ScrollManager(
        context: context,
        scrollController: ScrollController(),
        onLoadMore: () {
          context.read<FilmsBloc>().add(const FilmsEvent.loadTopRated());
        });
  }

  void _loadFeed() {
    context.read<FilmsBloc>().add(const FilmsEvent.loadPopular());
    context.read<FilmsBloc>().add(const FilmsEvent.loadTopRated());
    context.read<FilmsBloc>().add(const FilmsEvent.loadUpcoming());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    scrollControllerPopular.dispose();
    scrollControllerTopRated.dispose();
    super.dispose();
  }

  void _updateSearchResults(String query) {
    if (query.isNotEmpty) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        context.read<SearchBloc>().add(SearchEvent.search(title: query));
      });
    } else {
      setState(() {
        _searchResults = [];
        _showResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        state.whenOrNull(loaded: (films) {
          if (_searchController.text.isNotEmpty) {
            setState(() {
              _searchResults = films;
              _showResults = true;
            });
          }
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    sliver: SliverAppBar(
                      toolbarHeight: 55,
                      backgroundColor: Colors.grey[900],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      flexibleSpace: SearchBarWidget(
                          onSearchChanged: _updateSearchResults,
                          controller: _searchController),
                    ),
                  ),
                  BlocBuilder<FilmsBloc, FilmsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (topRated, upcoming, popular) {
                          return SliverPadding(
                            padding: const EdgeInsets.only(left: 12, top: 12),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  FilmsCategory(
                                    scrollController: scrollControllerPopular
                                        .scrollController,
                                    title: 'Популярные',
                                    films: popular,
                                  ),
                                  FilmsCategory(
                                    scrollController: scrollControllerTopRated
                                        .scrollController,
                                    title: 'Лучшие оценки',
                                    films: topRated,
                                  ),
                                  FilmsCategory(
                                    scrollController: ScrollController(),
                                    title: 'Выходящие',
                                    films: upcoming,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        orElse: () => const ShimmerWidget(),
                      );
                    },
                  ),
                ],
              ),
              Positioned.fill(
                top: 64,
                child: IgnorePointer(
                  ignoring: !_showResults,
                  child: AnimatedOpacity(
                    opacity: _showResults ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      color: Colors.black,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: ListView.builder(
                            key: ValueKey(_searchResults),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              return SearchItemWidget(
                                film: _searchResults[index],
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
