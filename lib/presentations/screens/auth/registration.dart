import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/src/utils.dart';
import 'package:projects/utils/mediaquery.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: SafeArea(
        bottom: false,
        child: Container(
          height: fullHeigth(context),
          width: fullWidth(context),
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: AuthTitlebar(
                  title: 'Signup\n',
                  subTitle: 'Best way to discuss smart\nideas',
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: fullHeigth(context) / 1.4,
                  width: fullWidth(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  decoration: const BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                  ),
                  child: const _SignUpForm(
                    key: Key('signup_form'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({super.key});

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: fullHeigth(context) / 2,
          child: Form(
            //key: loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomInputField(
                    fieldLabel: 'Full name',
                    hint: 'John Deo',
                    prefixIcon: AppAsset.personIcon,
                    // controller: emailController,
                    // readOnly: stateLoading,
                    keyboardType: TextInputType.name,
                    // validator: (v) => Validators().validateEmail(v),
                  ),
                  CustomInputField(
                    fieldLabel: 'Email address',
                    hint: 'enter email',
                    prefixIcon: AppAsset.mailIcon,
                    // controller: emailController,
                    // readOnly: stateLoading,
                    keyboardType: TextInputType.emailAddress,
                    // validator: (v) => Validators().validateEmail(v),
                  ),
                  CustomInputField(
                    fieldLabel: 'Phone number',
                    hint: '123-456-344',
                    prefixIcon: AppAsset.dialpadIcon,
                    // controller: emailController,
                    // readOnly: stateLoading,
                    keyboardType: TextInputType.phone,
                    // validator: (v) => Validators().validateEmail(v),
                  ),
                  CustomInputField(
                    fieldLabel: 'Password',
                    hint: 'enter password',
                    prefixIcon: AppAsset.lockIcon,
                    // controller: passwordController,
                    // readOnly: stateLoading,
                    password: true,
                    keyboardType: TextInputType.visiblePassword,
                    // validator: (v) => Validators().validatePassword(v),
                  ),
                  CustomInputField(
                    fieldLabel: 'Confirm password',
                    hint: 'enter password again',
                    prefixIcon: AppAsset.lockIcon,
                    // controller: passwordController,
                    // readOnly: stateLoading,
                    password: true,
                    keyboardType: TextInputType.visiblePassword,
                    // validator: (v) => Validators().validatePassword(v),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(25),
        const SizedBox(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  text: 'Login',
                  borderRadius: 100,
                  color: AppColors.kBlack,
                ),
              ),
              Gap(10),
              _RegisteredWidget(),
              Gap(10),
            ],
          ),
        ),
      ],
    );
  }
}

class _RegisteredWidget extends StatelessWidget {
  const _RegisteredWidget();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Already have an account?',
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: () => context.pushNamed(Constants.loginPath),
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    color: AppColors.kPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        letterSpacing: 1.5,
        color: AppColors.kGrey,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }
}
