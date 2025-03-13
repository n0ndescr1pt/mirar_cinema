import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/profile/view/widget/list_element_widget.dart';
import 'package:mirar/src/features/profile/view/unauthenticated_screen.dart';
import 'package:mirar/src/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            login: (loginModel) {
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF000000),
                          Color(0xFF0D0D0D),
                          Color(0xFF1A1A1A),
                          Color(
                              0xFF262626),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(height: 16),
                              Text(loginModel.username),
                              const SizedBox(height: 2),
                              Text(
                                loginModel.email,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.activeIconBackground,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                MenuItemWidget(
                                  title: 'Друзья',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 0,
                                  color: Colors.grey[900],
                                ),
                                MenuItemWidget(
                                  title: 'Статистика',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 0,
                                  color: Colors.grey[900],
                                ),
                                MenuItemWidget(
                                  title: 'Настройки',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 0,
                                  color: Colors.grey[900],
                                ),
                                MenuItemWidget(
                                  title: 'Поддержка',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEvent.logout());
                              },
                              child: Text(
                                "Выйти из аккаунта",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            orElse: () {
              return UnauthenticatedScreen();
            },
          );
        },
      ),
    );
  }
}
