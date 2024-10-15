import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mirar/src/app.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MainApp());
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}

