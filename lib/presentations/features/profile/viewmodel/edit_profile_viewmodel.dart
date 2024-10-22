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

  Future<void> onboardUser({
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
          'id': user.id,
          'display_name': userName,
          'updated_at': DateTime.now().toIso8601String(),
        };
      } else if (bio != null) {
        updates = {
          'id': user.id,
          'bio': bio,
          'updated_at': DateTime.now().toIso8601String(),
        };
      }

      await supabaseClient.from('profile').insert(updates).then((v) {
        if (v != null) {
          log('Update data: $v');
          getUserCallback();
        }
      }).whenComplete(() {
        /**
         *? close editor
        */
        appNavigatorKey.currentContext!.pop();
      });
    }).onError<PostgrestException>((e, s) {
      throw PostgrestException(message: e.message, code: e.code);
    });
  }
}
