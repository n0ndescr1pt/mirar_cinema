import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirar/main.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/common/server_api.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/theme/theme.dart';

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
