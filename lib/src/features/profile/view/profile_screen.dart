import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/profile/view/widget/list_element_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            login: (loginModel) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          MenuItemWidget(
                            title: 'Друзья',
                            onTap: () {},
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey[700],
                          ),
                          MenuItemWidget(
                            title: 'Статистика',
                            onTap: () {},
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey[700],
                          ),
                          MenuItemWidget(
                            title: 'Настройки',
                            onTap: () {},
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey[700],
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
                          context.read<AuthBloc>().add(AuthEvent.logout());
                        },
                        child: Text(
                          "Выйти из аккаунта",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))
                  ],
                ),
              );
            },
            orElse: () {
              return Center(
                child: TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.login.name);
                    },
                    child: Text(
                        "Чтобы открыть все функции зарегистрируйтесь или войдите в аккаунт")),
              );
            },
          );
        },
      ),
    );
  }
}
