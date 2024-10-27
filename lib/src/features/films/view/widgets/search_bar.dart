import 'package:flutter/material.dart';
import 'package:mirar/src/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearchChanged;
  final TextEditingController controller;

  const SearchBarWidget(
      {super.key, required this.onSearchChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: AppColors.text),
        onChanged: onSearchChanged,
        decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
