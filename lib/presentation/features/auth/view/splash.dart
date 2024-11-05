import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/presentation/features/auth/viewmodel/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static String splashPath = 'splashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 4),
      () => ref.read(authViewmodelProvider.notifier).listenToAuthStateChange(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(
          TextSpan(
            text: 'Geek',
            children: [
              TextSpan(
                text: ' !Chatt',
                style: GoogleFonts.outfit(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlack,
                ),
              ),
              TextSpan(
                text: '\nnerdy....',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kBlack,
                ),
              ),
            ],
            style: GoogleFonts.outfit(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
