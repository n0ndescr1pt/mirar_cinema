import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';
import 'package:mirar/src/features/films/view/widgets/films_category.dart';
import 'package:mirar/src/features/films/view/widgets/search.dart';
import 'package:mirar/src/injectable/init_injectable.dart';
import 'package:mirar/src/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    loadFeed();
    super.initState();
  }

  void loadFeed() {
    getIt<FilmsBloc>().add(const FilmsEvent.loadTopRated());
    getIt<FilmsBloc>().add(const FilmsEvent.loadPopular());
    getIt<FilmsBloc>().add(const FilmsEvent.loadUpcoming());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<FilmsBloc, FilmsState>(
          bloc: getIt<FilmsBloc>(),
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (topRated, popular, upcoming) {
                return CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      toolbarHeight: 70,
                      backgroundColor: Colors.transparent,
                      floating: true,
                      pinned: true,
                      flexibleSpace: Search(),
                    ),
                    SliverToBoxAdapter(
                      child: FilmsCategory(
                        title: 'Top Rated',
                        films: topRated,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FilmsCategory(
                        title: 'Popular',
                        films: popular,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FilmsCategory(
                        title: 'Upcoming',
                        films: upcoming,
                      ),
                    ),
                  ],
                );
              },
              orElse: () {
                return const Text("loading...");
              },
            );
          },
        ),
      ),
    );
  }
}
