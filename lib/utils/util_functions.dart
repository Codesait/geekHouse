import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/common/src/screens.dart';
import 'package:projects/common/src/utils.dart';
import 'package:projects/main.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class UtilFunctions {
  static String generateSignature(
    String apiSecret,
    int timestamp,
    String publicId,
  ) {
    final signatureString = '$timestamp:$apiSecret:$publicId';
    final bytes = utf8.encode(signatureString);
    final digest = sha1.convert(bytes);
    final signature =
        digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '$timestamp:$signature';
  }

  /// Allows the user to pick an image from the gallery using the `ImagePicker`
  /// plugin. The method takes three optional parameters:
  static Future<XFile?> pickImage({
    int imageQuality = 80,
    double maxH = 600,
    double maxW = 600,
  }) async {
    final status = await Permission.mediaLibrary.status;
    XFile? pickedFile;

    if (!status.isGranted) {
      try {
        pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: imageQuality,
          maxHeight: maxH,
          maxWidth: maxW,
        );
      } catch (e) {
        log('Error on opening media lib: $e');
      }
    }
    return pickedFile;
  }

  static void showVerifyEmailDialog() {
    final cntx = rootNavigatorKey.currentContext!;

    showAlertDialog(
      cntx,
      child: SizedBox(
        width: fullWidth(cntx),
        height: 250,
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: RiveAnimatedIcon(
                height: 100,
                width: 100,
                loopAnimation: true,
                riveIcon: RiveIcon.mail,
                color: Colors.green,
                strokeWidth: 3,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'A link was sent to you via email, please verify and login',
                  textAlign: TextAlign.center,
                  style: Theme.of(cntx)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                width: 150,
                child: DefaultButton(
                  text: 'Ok',
                  onPressed: () {
                    cntx
                      ..pop()
                      ..pushReplacementNamed(LoginScreen.loginPath);
                  },
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  static void showChooseInterestDialog() {
    final cntx = rootNavigatorKey.currentContext!;

    showAlertDialog(
      cntx,
      child: SizedBox(
        width: fullWidth(cntx),
        height: 250,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: RiveAnimatedIcon(
                height: 100,
                width: 100,
                loopAnimation: true,
                riveIcon: RiveIcon.like,
                color: AppColors.kPrimary,
                strokeWidth: 3,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Tell Us what you want to see more as a !Geek member',
                  textAlign: TextAlign.center,
                  style: Theme.of(cntx)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                width: 150,
                child: DefaultButton(
                  text: 'Ok',
                  onPressed: cntx.pop,
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
