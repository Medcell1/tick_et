import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/core/config/router.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      title: 'Tickets App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
