import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/common/server_api.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/theme/theme.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';
import 'package:mirar/src/features/films/bloc/search/search_bloc.dart';
import 'package:mirar/src/features/profile/data/auth_repository.dart';
import 'package:mirar/src/features/profile/data/data_sources/auth_data_sources.dart';
import 'package:mirar/src/features/profile/data/sign_in_services.dart';
import 'package:mirar/src/features/review/bloc/review_bloc/review_bloc.dart';
import 'package:mirar/src/features/review/bloc/watch_history_bloc/watch_history_bloc.dart';
import 'package:mirar/src/features/review/data/data_source/review_data_source.dart';
import 'package:mirar/src/features/review/data/data_source/wat%D1%81h_history_data_source.dart';
import 'package:mirar/src/features/review/data/review_repository.dart';
import 'package:mirar/src/features/review/data/watch_history_repository.dart';
import 'package:mirar/src/resources/constants.dart';
import 'package:provider/provider.dart';
import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/bloc/film/film_bloc.dart';
import 'package:mirar/src/features/films/data/data_source/kinopoisk_data_source.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    startLocalServer().then((e) => print("server started"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReposProviders(
      child: BlocProviders(
        child: MaterialApp.router(
          //localizationsDelegates: AppLocalizations.localizationsDelegates,
          //supportedLocales: AppLocalizations.supportedLocales,
          theme: CustomTheme.darkTheme,
          //locale: locale,
          routerConfig: router,
        ),
      ),
    );
  }
}

class BlocProviders extends StatelessWidget {
  final Widget child;
  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read<IAuthRepository>(),
            talker: context.read<Talker>(),
          ),
        ),
        BlocProvider(
          create: (context) => FilmBloc(
            talker: context.read<Talker>(),
            filmRepository: context.read<IFilmRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => WatchHistoryBloc(
            talker: context.read<Talker>(),
            historyRepository: context.read<IWatchHistoryRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ReviewBloc(
            talker: context.read<Talker>(),
            reviewRepository: context.read<IReviewRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FilmsBloc(
            talker: context.read<Talker>(),
            filmRepository: context.read<IFilmRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            talker: context.read<Talker>(),
            filmRepository: context.read<IFilmRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}

class ReposProviders extends StatelessWidget {
  final Widget child;
  const ReposProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final talker = TalkerFlutter.init(
      filter: BaseTalkerFilter(types: []),
      settings: TalkerSettings(enabled: true),
    );

    final apiProvider = ApiProvider(
        talker: talker,
        baseUrl: baseUrl,
        prefs: context.read<SharedPreferences>());
    final apiProviderBack4App = ApiProvider(
        talker: talker,
        baseUrl: "https://parseapi.back4app.com",
        prefs: context.read<SharedPreferences>());
    return MultiRepositoryProvider(
      providers: [
        Provider(create: (context) => talker),
        RepositoryProvider<IFilmRepository>(
          create: (context) => FilmRepository(
            tmdbDataSource: KinopoiskDataSource(apiProvider: apiProvider),
          ),
        ),
        RepositoryProvider<IWatchHistoryRepository>(
            create: (context) => WatchHistoryRepository(
                watchHistoryDataSource:
                    WatchHistoryDataSource(apiProvider: apiProviderBack4App))),
        RepositoryProvider<IReviewRepository>(
            create: (context) => ReviewRepository(
                reviewDataSource:
                    ReviewDataSource(apiProvider: apiProviderBack4App))),
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(
            networkAuthDataSources: NetworkAuthDataSources(
                signInServices: SignInServices(),
                apiProvider: apiProviderBack4App,
                prefs: context.read<SharedPreferences>()),
          ),
        )
      ],
      child: child,
    );
  }
}
