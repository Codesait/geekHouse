import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/src/config.dart';
import 'package:projects/src/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => context.pushReplacementNamed(Constants.authPath),
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
