import 'dart:async';
import 'dart:developer';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:mirar/src/app.dart';
import 'package:mirar/src/resources/key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('ru', null);
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
