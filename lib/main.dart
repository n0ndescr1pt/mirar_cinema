import 'dart:async';
import 'dart:developer';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/src/app.dart';
import 'package:mirar/src/features/films/bloc/films/films_bloc.dart';
import 'package:mirar/src/features/films/bloc/search/search_bloc.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/profile/data/auth_repository.dart';
import 'package:mirar/src/features/profile/data/data_sources/auth_data_sources.dart';
import 'package:mirar/src/features/profile/data/sign_in_services.dart';
import 'package:mirar/src/resources/constants.dart';
import 'package:mirar/src/resources/key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/bloc/film/film_bloc.dart';
import 'package:mirar/src/features/films/data/data_source/tmdb_data_source.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppMetrica.activate(
        AppMetricaConfig("01383fd2-f522-49bf-8e3f-2262d64b5b59", logs: true));
    await AppMetrica.reportEvent('AppOpen');
    await Parse().initialize(
      applicationIdKey,
      "https://parseapi.back4app.com",
      clientKey: "14LMQ9tjgJirudi2h5dwyxY3ZTS0E52kAIl5kRdN",
      autoSendSessionId: true,
    );
    final prefs = await SharedPreferences.getInstance();

    runApp(
      Provider<SharedPreferences>(
          create: (context) => prefs, child: const MainApp()),
    );
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
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
              tmdbDataSource: KinopoiskDataSource(apiProvider: apiProvider)),
        ),
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
