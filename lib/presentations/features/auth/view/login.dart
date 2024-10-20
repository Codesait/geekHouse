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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String loginPath = 'loginScreen';

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: AuthTitlebar(
                  title: 'Login\n',
                  subTitle: 'Best way to discuss smart\nideas',
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: fullHeight(context) / 1.4,
                  width: fullWidth(context),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  decoration: const BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                  ),
                  child: const _LoginForm(
                    key: Key('login_form'),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Form(
            key: loginFormKey,
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
                  fieldLabel: 'Password',
                  hint: 'enter password',
                  prefixIcon: AppAsset.lockIcon,
                  controller: passwordController,
                  password: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) => Validators().validatePassword(v),
                  useForgotPass: true,
                ),
              ],
            ),
          ),
        ),
        const Gap(25),
        SizedBox(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer(
                  builder: (context, ref, _) {
                    final provider = ref.read(authViewmodelProvider.notifier);
                    return DefaultButton(
                      text: 'Login',
                      borderRadius: 100,
                      color: AppColors.kBlack,
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {
                          provider.login(
                            context,
                            email: emailController!.text.trim(),
                            password: passwordController!.text.trim(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const Gap(10),
              const _NotRegisteredWidget(),
              const Gap(10),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotRegisteredWidget extends StatelessWidget {
  const _NotRegisteredWidget();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'New user?',
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: () => context.pushNamed(RegistrationScreen.regPath),
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Signup',
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
