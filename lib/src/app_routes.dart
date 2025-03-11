import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/features/films/view/film_screen.dart';
import 'package:mirar/src/features/films/view/search_screen.dart';
import 'package:mirar/src/features/home/view/home_screen.dart';
import 'package:mirar/src/features/profile/view/login_screen.dart';
import 'package:mirar/src/features/profile/view/profile_screen.dart';
import 'package:mirar/src/features/profile/view/register_screen.dart';
import 'package:mirar/src/features/review/view/review_screen.dart';

enum AppRoute { search, profile, review, film, login, register }

final rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/search',
  routes: [
    GoRoute(
      name: AppRoute.login.name,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          name: AppRoute.register.name,
          path: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                name: AppRoute.search.name,
                path: '/search',
                builder: (context, state) => const SearchScreen(),
                routes: [
                  GoRoute(
                    name: AppRoute.film.name,
                    path: 'film/:kinoposikId',
                    builder: (context, state) {
                      return FilmScreen(
                          kinoposikId: state.pathParameters['kinoposikId']!);
                    },
                  )
                ])
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: AppRoute.review.name,
              path: '/review',
              builder: (context, state) => const ReviewScreen(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: AppRoute.profile.name,
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            )
          ],
        ),
      ],
    ),
  ],
);
