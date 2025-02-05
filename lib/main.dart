import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/app.dart';
import 'package:logger/logger.dart';
var logger = Logger(
  printer: PrettyPrinter(),
);
void main() {
  runApp(
    const App(),
  );
}
