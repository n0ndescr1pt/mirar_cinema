import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/statistics/data/statistics_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../bloc/statistics_bloc.dart';
import '../model/rating_model.dart';
import '../model/watched_model.dart';

class StatisticsScreen extends StatelessWidget {
  final String userId;

  const StatisticsScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsBloc(
        dataSource: StatisticsDataSource(
          apiProvider: ApiProvider(
            talker: Talker(),
            baseUrl: dotenv.env["PARSE_API_BASE_URL"]!,
            prefs: context.read<SharedPreferences>(),
          ),
        ),
        talker: Talker(),
      )..add(LoadStatistics(userId: userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
        ),
        body: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is StatisticsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is StatisticsError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is StatisticsLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRatingsDistributionChart(state.ratings),
                    const SizedBox(height: 24),
                    _buildGenrePieChart(state.watchedMovies),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildRatingsDistributionChart(List<RatingModel> ratings) {
    // Подсчёт количества фильмов по каждой оценке (округлённой до целого)
    final Map<int, int> ratingCounts = {};
    for (var ratingModel in ratings) {
      final roundedRating = ratingModel.rating.round();
      ratingCounts[roundedRating] = (ratingCounts[roundedRating] ?? 0) + 1;
    }

    // Для графика нужно создать группы с X от 1 до 10 (или макс оценки)
    const minRating = 1;
    const maxRating = 10;

    final List<BarChartGroupData> barGroups = [];

    for (int ratingValue = minRating; ratingValue <= maxRating; ratingValue++) {
      final count = ratingCounts[ratingValue] ?? 0;
      barGroups.add(
        BarChartGroupData(
          x: ratingValue,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.blue,
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Распределение оценок',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final intRating = value.toInt();
                      if (intRating < minRating || intRating > maxRating) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          intRating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barGroups: barGroups,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildGenrePieChart(List<WatchedModel> watchedMovies) {
  final Map<String, int> genreCount = {};
  for (final movie in watchedMovies) {
    for (final genre in movie.genre) {
      genreCount[genre] = (genreCount[genre] ?? 0) + 1;
    }
  }

  // Список цветов для секторов
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.amber,
    Colors.pink,
    Colors.teal,
    Colors.lime,
  ];

  final sections = genreCount.entries.toList().asMap().entries.map((entry) {
    final index = entry.key;
    final genre = entry.value.key;
    final count = entry.value.value;
    final percentage = (count / watchedMovies.length) * 100;

    return PieChartSectionData(
      color: colors[index % colors.length], // Цвет по индексу с циклом
      value: percentage,
      title: '$genre (${count})',
      radius: 60,
      titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
    );
  }).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Watched Genres',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),
      AspectRatio(
        aspectRatio: 1.3,
        child: PieChart(
          PieChartData(
            sections: sections,
            sectionsSpace: 4,
            centerSpaceRadius: 32,
          ),
        ),
      ),
    ],
  );
}

}
