import 'package:flutter/material.dart';
import 'package:projects/config/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Geek House',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerConfig: AppRouterConfig.router,
    );
  }
}
