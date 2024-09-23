import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:projects/src/data.dart';
import 'package:projects/src/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'profile_viewmodel.g.dart';

@riverpod
class ProfileViewmodel extends _$ProfileViewmodel {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  final supabaseClient = AuthService().supabase;

  Profile? userProfile;

  Future<void> getUserProfile() async {
    final user = supabaseClient.auth.currentSession?.user;

  

    state = const AsyncLoading();
    try {
      // Start loader
      BotToast.showLoading();

      state = await AsyncValue.guard(() async {
        final data = await supabaseClient
            .from('profile')
            .select()
            .eq('id', user!.id)
            .maybeSingle(); // Use maybeSingle to avoid exception if no data

        if (data != null) {
          // Map the response data to your Profile model
          userProfile = Profile(
            username: data['display_name'] as String? ?? 'No username',
            emailAddress: data['email'] as String? ?? 'No email',
            phoneNumber: data['phone'] as String? ?? 'No phone',
            photoUrl: data['image_url'] as String? ?? 'No image',
            followersCount: data['follower_count'] as int? ?? 0,
            followingsCount: data['following_count'] as int? ?? 0,
          );
        } else {
          debugPrint('No profile found for user.');
          // You can also create a new profile here if needed
          return;
        }
      });
    } on PostgrestException catch (e) {
      // Catch and handle the specific Postgrest error
      debugPrint('Postgrest Error: ${e.message}, Code: ${e.code}');
    } catch (e, s) {
      // General error handling
      debugPrintStack(stackTrace: s, label: e.toString());
    } finally {
      // Close the loader in both success and error cases
      BotToast.closeAllLoading();
    }
  }

  Future<void> updateUserProfile({String? userName}) async {
    final user = supabaseClient.auth.currentSession!.user;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      /**
       * *START LOADER
      */
      BotToast.showLoading();

      final updates = {
        'id': user.id,
        'username': userName,
        'website': 'website',
        'updated_at': DateTime.now().toIso8601String(),
        // Include followers and following counts if needed
      };

      await supabaseClient
          .from('profile')
          .upsert(updates)
          .whenComplete(BotToast.closeAllLoading);
    }).onError<PostgrestException>((e, s) {
      throw PostgrestException(message: e.message, code: e.code);
    });
  }

  Future<void> logOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      BotToast.showLoading();
      await supabaseClient.auth
          .signOut()
          .whenComplete(BotToast.closeAllLoading);
    });
  }
}
