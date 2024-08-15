import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projects/app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

const anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx6d29md3Z6bG1zeWFqbml3eGNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM3NDU4MzQsImV4cCI6MjAzOTMyMTgzNH0.2ckGkkjEVfm3mbYsmIzuPfFKYmrCm9tuJY8rwQV5rgQ';

Future<void> main() async {
  await dotenv.load(fileName: 'auth_secrets.env');

  final supabaseUrl = dotenv.get('AUTH_URL');
  final anonKey = dotenv.get('ANON_KEY');


  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  runApp(const MyApp());
}
