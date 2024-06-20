import 'package:flutter/material.dart';
import 'package:projects/app/app.dart';

final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

void main() {
  runApp(const MyApp());
}
