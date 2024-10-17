import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/data.dart';
import 'package:projects/commons/src/screens.dart';
import 'package:projects/commons/src/services.dart';
import 'package:projects/commons/src/utils.dart';
import 'package:projects/main.dart';
import 'package:projects/service/profile_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_viewmodel.g.dart';

@riverpod
class ProfileViewmodel extends _$ProfileViewmodel {
  @override
  FutureOr<dynamic> build() {
    return state;
  }

  final supabaseClient = AuthService().supabase;

/**
 * * FETCH/UPDATE USER PROFILE DATA
 */
  Profile? userProfile;
  Future<void> getUserProfile({bool reloading = false}) async {
    final user = supabaseClient.auth.currentSession?.user;

    state = const AsyncLoading();
    try {
      if (reloading) {
        //* Start loader
        BotToast.showLoading();
      }

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
            photoUrl: data['image_url'] as String? ?? 'No image',
            followersCount: data['follower_count'] as int? ?? 0,
            followingsCount: data['following_count'] as int? ?? 0,
          );

          log('PROFILE $userProfile');
        } else {
          debugPrint('No profile found for user.');

          //* We can create a new profile here
          Modal().modalSheet(
            appNavigatorKey.currentContext!,
            padTop: false,
            child: const UserOnboarding(),
          );

          return;
        }
      });
    } on PostgrestException catch (e) {
      //! Catch and handle the specific Postgrest error
      debugPrint('Postgrest Error: ${e.message}, Code: ${e.code}');
    } catch (e, s) {
      //! General error handling
      debugPrintStack(stackTrace: s, label: e.toString());
    } finally {
      if (reloading) {
        //* Close the loader in both success and error cases
        BotToast.closeAllLoading();
      }
    }
  }

  Future<void> onboardUser(
    BuildContext context, {
    String? userName,
    String? imageUrl,
  }) async {
    if (userName != null && imageUrl != null) {
      final user = supabaseClient.auth.currentSession!.user;

      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        /**
       * *START LOADER
      */
        BotToast.showLoading();

        final updates = {
          'id': user.id,
          'display_name': userName,
          'email': user.email,
          'image_url': imageUrl,
          'following_count': 0,
          'follower_count': 0,
          'updated_at': DateTime.now().toIso8601String(),
        };

        await supabaseClient.from('profile').insert(updates).then((v) {
          if (v != null) {
            log('Update data: $v');
          }
        }).whenComplete(() {
          /**
            *! stop loader
          */
          BotToast.closeAllLoading();

          /**
           *? Navigate use to entry
          */
          appNavigatorKey.currentContext!.pushReplacementNamed(
            Constants.homePath,
          );
          context.pop();
        });
      }).onError<PostgrestException>((e, s) {
        throw PostgrestException(message: e.message, code: e.code);
      });
    } else if (imageUrl == null) {
      showToast(
        title: 'Missing Params',
        msg: 'To proceed, please select \na profile photo ',
        isWarningMessage: true,
      );
    } else {
      showToast(
        title: 'Missing Params',
        msg: 'Unexpected Error',
        isError: true,
      );
    }
  }

/**
 * * PROFILE IMAGE UPLOAD
 */

  int _totalUploadProgress = 0;
  int get totalUploadProgress => _totalUploadProgress;

  Future<String?> uploadProfileImageAndGetUrl() async {
    String? url;

    /**
     *? Responsible for allowing the user to pick an image from their device, either from
     *? the gallery or by taking a new photo using the camera.
     */
    final pickedImage = await UtilFunctions.pickImage();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      /**
       *?  UPLOAD AUTH CREDENTIALS
       */
      final cloudName = dotenv.get('CLOUD_NAME');
      final apiKey = dotenv.get('CLOUDINARY_API_KEY');
      final apiSecret = dotenv.get('CLOUDINARY_API_SECRET');
      final uploadPreset = dotenv.get('CLOUDINARY_PRESET');

      /**
       *? upload a profile photo to Cloudinary and return a [secure_url] for
       *? user onboarding
       */
      url = await ProfileService().uploadProfilePhotoToCloudinary(
        imageFile: pickedImage!,
        cloudName: cloudName,
        apiKey: apiKey,
        apiSecret: apiSecret,
        uploadPreset: uploadPreset,
        uploadProgress: (sent, total) {
          _totalUploadProgress = total;
        },
      ) as String;
    });
    return url;
  }

/**
 * * USER LOG OUT FUNCTION
 */
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
