import 'dart:convert';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UtilFunctions {
  static String generateSignature(String apiSecret, int timestamp) {
    final signatureData = 'timestamp=$timestamp$apiSecret';
    final bytes = utf8.encode(signatureData);
    return base64.encode(bytes);
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
