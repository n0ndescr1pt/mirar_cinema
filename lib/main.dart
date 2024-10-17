import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mirar/src/app.dart';
import 'package:mirar/src/injectable/init_injectable.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependency(Environment.prod);

    runApp(const MainApp());
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}
