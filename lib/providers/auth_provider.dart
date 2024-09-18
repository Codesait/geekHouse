import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/main.dart';
import 'package:projects/src/services.dart';
import 'package:projects/src/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_provider.g.dart';

@riverpod
class AuthViemodel extends _$AuthViemodel {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<void> signUp(
    BuildContext context, {
    required String email,
    required String password,
    Map<String, dynamic>? moreData,
  }) async {
    final provider = ref.read(authRepo);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      /**
       * *START LOADER
       */
      BotToast.showLoading();

      await provider
          .registerNewUser(email: email, password: password)
          .then((value) {
        /**
         * ? go to login after user sign up
         */
        if (value != null) {
          showToast(msg: 'Please Sign in');

          /**
           ** GO TO LOGIN AFTER SIGNUP
          */
          Future.delayed(
            const Duration(milliseconds: 1500),
            () => context.pushReplacementNamed(Constants.loginPath),
          );
        }
      }).whenComplete(BotToast.closeAllLoading);
    });
  }

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
    Map<String, dynamic>? moreData,
  }) async {
    final provider = ref.read(authRepo);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      /**
       ** START LOADER
       */
      BotToast.showLoading();

      await provider.userSignIn(email: email, password: password).then((value) {
        if (value != null) {
          showToast(msg: 'Please login');

          /**
           ** GO TO HOME AFTER LOGIN
          */
          Future.delayed(
            const Duration(milliseconds: 1500),
            () => context.pushReplacementNamed(Constants.homePath),
          );
        }
      }).whenComplete(BotToast.closeAllLoading);
    });
  }

  /**
 * ? 
 */
  late StreamSubscription<AuthState> authSubscription;
  void listenToAuthStateChange() {
    authSubscription =
        AuthService().supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      log('event: $event, session: $session');

      switch (event) {
        case AuthChangeEvent.initialSession:

          /**
           *? This code block is checking if the `session` object is not null. If the `session` is not
           *? null, it means that the user is authenticated and has an active session. In this case, it
           *? will navigate the user to the home screen by pushing the replacement route named
           *? `Constants.homePath`.
           */
          if (session != null) {
            appNavigatorKey.currentContext!
                .pushReplacementNamed(Constants.homePath);
          } else {
            appNavigatorKey.currentContext!
                .pushReplacementNamed(Constants.authPath);
          }

          log('INITIAL SESSION');

        case AuthChangeEvent.signedIn:
          showToast(msg: 'Signed In Successfully');
          debugPrint('USER: ${session!.user}');

        case AuthChangeEvent.signedOut:
          showToast(msg: 'Signed out Successfully');

        case AuthChangeEvent.passwordRecovery:
        // handle password recovery

        case AuthChangeEvent.tokenRefreshed:
          showToast(msg: 'Token refreshed Successfully');

          debugPrint('TOKEN: ${session!.accessToken}');

        case AuthChangeEvent.userUpdated:
          showToast(msg: 'User updated Successfully');
          debugPrint('USER: ${session!.user}');

        case AuthChangeEvent.userDeleted:
          showToast(msg: 'User deleted Successfully');

        case AuthChangeEvent.mfaChallengeVerified:
        // handle mfa challenge verified
      }
    });
  }

  ///* This Dart function cancels a subscription to authentication changes.
  void cancelAuthChangeSub() {
    authSubscription.cancel();
  }
}

final authRepo = ChangeNotifierProvider((_) => AuthRepo());

class AuthRepo extends ChangeNotifier {
  final authService = AuthService();

  Future<AuthResponse?> registerNewUser({
    required String email,
    required String password,
    Map<String, dynamic>? moreData,
  }) async {
    return authService.signUp(email, password, moreData);
  }

  Future<AuthResponse?> userSignIn({
    required String email,
    required String password,
  }) async {
    return authService.signIn(email, password);
  }
}
