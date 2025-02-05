import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app_flutter/core/config/router.dart';

import 'core/utils/globals.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Globals.providers,
      child: MaterialApp.router(

        title: 'Tickets App',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
