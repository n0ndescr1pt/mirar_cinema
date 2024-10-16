import 'package:flutter/material.dart';
import 'package:mirar/src/features/films/view/widgets/search.dart';
import 'package:mirar/src/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              floating: true,
              pinned: true,
              flexibleSpace: Search(),
            ),
            SliverToBoxAdapter(
              child: Text(
                'ПОПУЛЯРНО',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColors.text),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index',
                          textScaler: const TextScaler.linear(5)),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
