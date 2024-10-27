import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mirar/src/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      backgroundColor: AppColors.background,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: GNav(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          backgroundColor: AppColors.background,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabBackgroundColor: AppColors.activeIconBackground,
          color: AppColors.inactiveIcon,
          activeColor: AppColors.activeIcon,
          textSize: 10,
          gap: 12,
          tabs: const [
            GButton(
              text: "Лента",
              icon: LineIcons.newspaper,
            ),
            GButton(
              text: "Фильмы",
              icon: LineIcons.film,
            ),
            GButton(
              text: "Профиль",
              icon: LineIcons.user,
            ),
          ],
          onTabChange: _onTap,
        ),
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
