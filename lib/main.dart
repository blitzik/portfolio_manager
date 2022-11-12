import 'package:flutter/material.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/router/router.gr.dart' as r;

void main() async{
  final _appRouter = r.Router();

  configureDependencies();

  runApp(
    MaterialApp.router(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            counterStyle: TextStyle(fontSize: 15)
        ),
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    ),
  );
}