import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/config/app_assets.dart';
import 'package:projects/presentations/components/auth_titlebar.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        child: Container(
          height: fullHeigth(context),
          width: fullWidth(context),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AuthTitlebar(
                title: 'Get Started!\n',
                subTitle: 'Best way to discuss smart\nideas',
              ),
              Image.asset(
                AppAsset.authBg,
                width: fullWidth(context),
                scale: 2,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultButton(
                      borderRadius: 40,
                      width: fullWidth(context) * .4,
                      borderColor: AppColors.kWhite,
                      text: 'Login',
                    ),
                    DefaultButton(
                      borderRadius: 40,
                      width: fullWidth(context) * .4,
                      color: AppColors.kWhite,
                      textColor: AppColors.kBlack,
                      text: 'Signup',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
