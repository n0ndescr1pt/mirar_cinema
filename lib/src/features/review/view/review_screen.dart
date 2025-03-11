import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            login: (loginModel) {
              return ListView(
                children: [],
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
