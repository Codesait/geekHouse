// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/services.dart';
import 'package:projects/config/router.dart';
import 'package:projects/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'edit_profile_viewmodel.g.dart';

@riverpod
class EditProfileViewmodel extends _$EditProfileViewmodel {
  @override
  FutureOr<dynamic> build() {
    return state;
  }

  final supabaseClient = AuthService().supabase;

  Future<void> updateUserData(
   {
    required void Function() getUserCallback,
    String? userName,
    String? bio,
  }) async {
    final user = supabaseClient.auth.currentSession!.user;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      late Map<String, String?> updates;

      if (userName != null) {
        updates = {
          'display_name': userName,
          'updated_at': DateTime.now().toIso8601String(),
        };
      } else if (bio != null) {
        updates = {
          'bio': bio,
          'updated_at': DateTime.now().toIso8601String(),
        };
      }

      await supabaseClient
          .from('profile')
          .update(updates)
          .eq('id', user.id)
          .maybeSingle()
          .then((v) {
        /// The code `log('UPDATE PROFILE COMPLETE');` is logging a message indicating that the profile
        /// update operation has been completed. This log message can be helpful for debugging and
        /// tracking the flow of the application.
        log('UPDATE PROFILE COMPLETE');

        /**
         *? FETCH UPDATED PROFILE
         */
        getUserCallback();
      });
    }).whenComplete(() {
      profileShellKey.currentContext!.pop();
    }).onError<PostgrestException>((e, s) {
      throw PostgrestException(message: e.message, code: e.code);
    });
  }
}
