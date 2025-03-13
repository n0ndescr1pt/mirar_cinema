import 'package:flutter/material.dart';
import 'package:mirar/src/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
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
            _buildShimmerRow(),
            const SizedBox(height: 12),
            Text(
              "Popular",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            _buildShimmerRow(),
            const SizedBox(height: 12),
            Text(
              "Upcoming",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            _buildShimmerRow(),
          ],
        ),
      ),
    );
  }
}

Widget _buildShimmerRow() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
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
  );
}
