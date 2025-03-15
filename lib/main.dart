import 'dart:async';
import 'dart:developer';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:mirar/src/app.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('ru', null);

    await dotenv.load(fileName: '.env');

    await AppMetrica.activate(
        AppMetricaConfig(dotenv.env["APPMETRICA_API_KEY"]!));
    await AppMetrica.reportEvent('AppOpen');
    await Parse().initialize(
      dotenv.env["APP_ID"]!,
      dotenv.env["PARSE_API_BASE_URL"]!,
      clientKey: dotenv.env["CLIENT_API_KEY"]!,
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
