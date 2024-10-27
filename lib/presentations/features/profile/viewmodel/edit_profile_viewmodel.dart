import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/services.dart';
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

  Future<void> updateUserData({
    required void Function() getUserCallback,
    bool disablePop = false,
    String? userName,
    String? bio,
    String? profilePhoto,
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
      } else if (profilePhoto != null) {
        updates = {
          'image_url': profilePhoto,
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
      if (disablePop) return;
      profileShellKey.currentContext!.pop();
    }).onError<PostgrestException>((e, s) {
      throw PostgrestException(message: e.message, code: e.code);
    });
  }
}
