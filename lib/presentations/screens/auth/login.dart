import 'package:flutter/material.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  title: 'Login\n',
                  subTitle: 'Best way to discuss smart\nideas',
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: fullHeigth(context) / 1.4,
                  width: fullWidth(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                  ),
                  child: const _LoginForm(),
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
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          child: Form(
            //key: loginFormKey,
            child: Column(
              children: [
                CustomInputField(
                  fieldLabel: 'Email address',
                  hint: 'enter email',
                  // controller: emailController,
                  // readOnly: stateLoading,
                  keyboardType: TextInputType.emailAddress,
                  // validator: (v) => Validators().validateEmail(v),
                ),
                CustomInputField(
                  fieldLabel: 'Password',
                  hint: 'enter password',
                  // controller: passwordController,
                  // readOnly: stateLoading,
                  password: true,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: (v) => Validators().validatePassword(v),
                  useForgotPass: true,
                ),
              ],
            ),
          ),
        ),
        Gap(25),
      ],
    );
  }
}
