import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';

class ScrollManager {
  final ScrollController scrollController;
  final VoidCallback onLoadMore;
  final BuildContext context;

  ScrollManager({
    required this.context,
    required this.scrollController,
    required this.onLoadMore,
  }) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<FilmsBloc>();
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 50 &&
        !bloc.isLoading) {
      onLoadMore();
    }
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }
}
