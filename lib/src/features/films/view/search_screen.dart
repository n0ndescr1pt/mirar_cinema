import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';
import 'package:mirar/src/features/films/view/widgets/films_category.dart';
import 'package:mirar/src/features/films/view/widgets/search.dart';
import 'package:mirar/src/injectable/init_injectable.dart';
import 'package:mirar/src/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

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
    //getIt<FilmsBloc>().add(const FilmsEvent.loadPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 55,
            backgroundColor: Colors.grey[900],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
            floating: true,
            pinned: true,
            flexibleSpace: MovieSearchField(),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<FilmsBloc, FilmsState>(
              bloc: getIt<FilmsBloc>(),
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (topRated, upcoming, popular) {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          FilmsCategory(
                            title: 'Top Rated',
                            films: [],
                          ),
                          FilmsCategory(
                            title: 'Popular',
                            films: [],
                          ),
                          FilmsCategory(
                            title: 'Upcoming',
                            films: [],
                          ),
                        ],
                      ),
                    );
                  },
                  orElse: () {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[900]!,
                      highlightColor: Colors.grey[600]!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            "Top Rated",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.text),
                          ),
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis
                                .horizontal, // Горизонтальное скроллирование
                            child: Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Popular",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.text),
                          ),
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis
                                .horizontal, // Горизонтальное скроллирование
                            child: Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Upcoming",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.text),
                          ),
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis
                                .horizontal, // Горизонтальное скроллирование
                            child: Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
