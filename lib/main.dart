import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_manager/di.dart';
import 'package:portfolio_manager/router/router.gr.dart' as r;
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() async{
  final _appRouter = r.Router();

  configureDependencies();

  runApp(
    MaterialApp.router(
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          textButtonRadius: 5.0,
          elevatedButtonRadius: 6.0,
          outlinedButtonRadius: 6.0,
          toggleButtonsRadius: 6.0,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorRadius: 0.0,
          cardRadius: 10.0,
          dialogRadius: 10.0,
          timePickerDialogRadius: 10.0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          textButtonRadius: 5.0,
          elevatedButtonRadius: 6.0,
          outlinedButtonRadius: 6.0,
          toggleButtonsRadius: 6.0,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorRadius: 0.0,
          cardRadius: 10.0,
          dialogRadius: 10.0,
          timePickerDialogRadius: 10.0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      themeMode: ThemeMode.system,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    )
  );

  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.title = "Portfolio Manager";
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}