import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/src/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = ChangeNotifierProvider((_) => AuthProvider());

class AuthProvider extends ChangeNotifier {
  final authService = AuthService();

  late StreamSubscription<AuthState> authSubscription;

  Future<void> registerNewUser({
    required String email,
    required String password,
    Map<String, dynamic>? moreData,
  }) async {
    listToAuthStateChange();
    try {
      //* start loader
      BotToast.showLoading();

      await authService.signUp(email, password, moreData).then((value) {
        if (value != null) {
          debugPrint('SIGN UP RESPONSE ${value.user!.email}');
        }
      }).whenComplete(BotToast.closeAllLoading);
    } catch (e) {
      debugPrint('REGISTRATION ERROR: $e');
    }
  }

  void listToAuthStateChange() {
    authSubscription =
        authService.supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      log('event: $event, session: $session');

      switch (event) {
        case AuthChangeEvent.initialSession:
          log('INITIAL SESSION');
        case AuthChangeEvent.signedIn:
          log('USER SIGNED IN');
        case AuthChangeEvent.signedOut:
          log('USER SIGNED OUT');
        case AuthChangeEvent.passwordRecovery:
        // handle password recovery
        case AuthChangeEvent.tokenRefreshed:
        // handle token refreshed
        case AuthChangeEvent.userUpdated:
        // handle user updated
        case AuthChangeEvent.userDeleted:
        // handle user deleted
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
