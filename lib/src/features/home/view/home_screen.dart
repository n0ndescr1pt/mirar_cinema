import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mirar/src/features/home/view/loading_screen.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/theme/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const AuthEvent.checkSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () {
            context.pushReplacementNamed("login");
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => const LoadingScreen(),
            login: (loginModel) {
              return Provider(
                create: (BuildContext context) => loginModel,
                child: Scaffold(
                  body: widget.navigationShell,
                  backgroundColor: AppColors.background,
                  bottomNavigationBar: SizedBox(
                    height: 60,
                    child: GNav(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
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
                ),
              );
            });
      },
    );
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
