import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/app.dart';
import 'package:logger/logger.dart';

import 'core/config/locator.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
void main() {
  setUp();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const App(),
  );
}
