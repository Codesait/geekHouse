import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/commons/src/screens.dart';
import 'package:projects/presentations/features/auth/viewmodel/auth_provider.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/config.dart';
import 'package:projects/commons/src/utils.dart';
import 'package:projects/utils/mediaquery.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String regPath = 'regScreen';

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
          height: fullHeight(context),
          width: fullWidth(context),
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              const Positioned(
                top: 20,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: AuthTitlebar(
                    title: 'Signup\n',
                    subTitle: 'Best way to discuss smart\nideas',
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: fullHeight(context) / 1.4,
                  width: fullWidth(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
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
  final regFormKey = GlobalKey<FormState>();

  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: fullHeight(context) / 1.9,
            child: Form(
              key: regFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    CustomInputField(
                      fieldLabel: 'Email address',
                      hint: 'enter email',
                      prefixIcon: AppAsset.mailIcon,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => Validators().validateEmail(v),
                    ),
                    CustomInputField(
                      fieldLabel: 'Phone number',
                      hint: '123-456-344',
                      prefixIcon: AppAsset.dialpadIcon,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (v) => Validators().validatePhoneNumber(v),
                    ),
                    CustomInputField(
                      fieldLabel: 'Password',
                      hint: 'enter password',
                      prefixIcon: AppAsset.lockIcon,
                      controller: passwordController,
                      password: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (v) => Validators().validatePassword(v),
                    ),
                    CustomInputField(
                      fieldLabel: 'Confirm password',
                      hint: 'enter password again',
                      prefixIcon: AppAsset.lockIcon,
                      controller: confirmPasswordController,
                      password: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (v) => Validators()
                          .validateConfirmPassword(v, passwordController!.text),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(10),
          SizedBox(
            child: Consumer(
              builder: (context, ref, _) {
                //? acessing auth provider
                final provider = ref.read(authViemodelProvider.notifier);

                return Column(
                  children: [
                    DefaultButton(
                      text: 'Sign Up',
                      borderRadius: 100,
                      color: AppColors.kBlack,
                      onPressed: () {
                        if (regFormKey.currentState!.validate()) {
                          provider.signUp(
                            context,
                            email: emailController!.text.trim(),
                            password: passwordController!.text.trim(),
                          
                          );
                        }
                      },
                    ),
                    const Gap(10),
                    const _RegisteredWidget(),
                    const Gap(10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
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
              onTap: () => context.pushNamed(LoginScreen.loginPath),
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
