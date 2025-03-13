import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/review/bloc/review_bloc/review_bloc.dart';
import 'package:mirar/src/features/review/bloc/watch_history_bloc/watch_history_bloc.dart';
import 'package:mirar/src/features/profile/view/unauthenticated_screen.dart';
import 'package:mirar/src/features/review/view/widget/review_list.dart';
import 'package:mirar/src/features/review/view/widget/watch_history_list.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    if (context.read<AuthBloc>().loginModel != null) {
      context.read<WatchHistoryBloc>().add(WatchHistoryEvent.getWatchHistory(
          userId: context.read<AuthBloc>().loginModel!.objectID));
      context.read<ReviewBloc>().add(ReviewEvent.getReviewMovie(
          userId: context.read<AuthBloc>().loginModel!.objectID));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            login: (loginModel) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    BlocBuilder<WatchHistoryBloc, WatchHistoryState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (films) => WatchHistoryList(
                              title: "История просмотра",
                              films: films,
                              scrollController: ScrollController()),
                          orElse: () {
                            return WatchHistoryList(
                                title: "История просмотра",
                                films: [],
                                scrollController: ScrollController());
                          },
                        );
                      },
                    ),
                    BlocBuilder<ReviewBloc, ReviewState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (reviews) {
                            return ReviewList(
                              title: 'Ваши оценки',
                              scrollController: ScrollController(),
                              films: reviews,
                            );
                          },
                          orElse: () {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            orElse: () {
              return UnauthenticatedScreen();
            },
          );
        },
        listener: (BuildContext context, AuthState state) {
          state.whenOrNull(login: (loginModel) {
            context.read<WatchHistoryBloc>().add(
                WatchHistoryEvent.getWatchHistory(userId: loginModel.objectID));
            context.read<ReviewBloc>().add(ReviewEvent.getReviewMovie(
                userId: context.read<AuthBloc>().loginModel!.objectID));
          });
        },
      ),
    );
  }
}
