import 'package:flutter/material.dart';
import 'package:mirar/src/theme/app_colors.dart';
import 'package:searchfield/searchfield.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.activeIconBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SearchField(
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
            suggestions: [
              'Cf',
              'Cf1',
            ].map(SearchFieldListItem<String>.new).toList(),
          ),
        ),
      ),
    );
  }
}
