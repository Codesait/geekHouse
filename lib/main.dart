import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projects/app/app.dart';
import 'package:projects/commons/src/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final authShellKey = GlobalKey<NavigatorState>();
final profileShellKey = GlobalKey<NavigatorState>();

late PackageInfo packageInfo;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();

  await dotenv.load(fileName: 'auth_secrets.env');

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.anonKey,
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}
