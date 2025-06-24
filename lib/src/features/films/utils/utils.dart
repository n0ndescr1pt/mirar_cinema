import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/review/bloc/review_bloc/review_bloc.dart';
import 'package:mirar/src/features/review/bloc/watch_history_bloc/watch_history_bloc.dart';

void updateLists(BuildContext context) {
  if (context.read<AuthBloc>().loginModel != null) {
    context.read<WatchHistoryBloc>().add(WatchHistoryEvent.getWatchHistory(
        userId: context.read<AuthBloc>().loginModel!.objectID));
    context.read<ReviewBloc>().add(ReviewEvent.getReviewMovie(
        userId: context.read<AuthBloc>().loginModel!.objectID));
  }
}

Color getColorByIndex(int index) {
  if (index == 5) {
    return Colors.grey;
  } else if (index < 5) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}
