import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mirar/src/features/films/view/search_screen.dart';
import 'package:mirar/src/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
  }

  final List<Widget> _screens = [
    const Text(
      'Лента',
      style: TextStyle(color: AppColors.text),
    ),
    const SearchScreen(),
    const Text(
      'Профиль',
      style: TextStyle(color: AppColors.text),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: GNav(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          backgroundColor: AppColors.background,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabBackgroundColor: AppColors.activeIconBackground,
          selectedIndex: _selectedIndex,
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
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
      body: SafeArea(
        child: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}
