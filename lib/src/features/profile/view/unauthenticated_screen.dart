import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';

class UnauthenticatedScreen extends StatelessWidget {
  const UnauthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Фон с градиентом
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF000000), // глубокий черный
                  Color(0xFF0D0D0D), // почти черный с легкой подсветкой
                  Color(0xFF1A1A1A), // мягкий темно-серый
                  Color(0xFF262626), // ещё светлее, для плавного перехода
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.4, 0.7, 1.0], // растягиваем переходы
              ),
            ),
          ),
          // Содержание
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Заголовок
                  const Text(
                    "Добро пожаловать в Mirar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Описание
                  const Text(
                    "Оцените фильмы, ведите свою историю просмотров.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Кнопка Войти
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.login.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Войти",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Кнопка Регистрация
                  OutlinedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.register.name);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Регистрация",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
