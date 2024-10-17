import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
}
