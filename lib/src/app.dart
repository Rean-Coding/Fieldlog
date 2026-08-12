import 'package:flutter/material.dart';

import 'router/app_router.dart';

/// The root widget of FieldLog.
///
/// Week 2 update: switched to [MaterialApp.router] so all navigation flows
/// through our declarative [AppRouter]. Theme is centralised here using
/// Material 3 with the AEU teal seed colour, in both light and dark variants.
class FieldLogApp extends StatelessWidget {
  const FieldLogApp({super.key});

  static const _seed = Color(0xFF0F766E); // AEU teal seed

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FieldLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
