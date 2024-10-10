import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/src/utils.dart';

class ProfileService extends ApiHelper {
  Future<dynamic> uploadProfilePhotoToCloudinary({
    required XFile imageFile,
    required String cloudName,
    required String apiKey,
    required String apiSecret,
    required String uploadPreset,
    required void Function(int sent, int total) uploadProgress,
  }) async {
    /**
     ** CLOUDINARY UPLOAD URL
     */
    final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    /**
     ** GENERATE TIMESTAMP FOR SIGNING
     */
    final timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    /**
     ** GENERATE SIGNATURE FOR UPLOAD 
     */
    // final signature = UtilFunctions.generateSignature(
    //   apiSecret,
    //   timestamp,
    //   'profile_image',
    // );

    /** 
     *? SET UP UPLOAD MAP
     */
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        await imageFile.readAsBytes() as List<int>,
        filename: imageFile.name,
        contentType: MediaType('image', 'png'),
      ),
      'api_key': apiKey,
      'timestamp': timestamp,
      'folder': 'profile_photo',
      'upload_preset': uploadPreset,
      'api_secret': apiSecret,
    });

    //* RESPONSE
    final response = await uploadMth(
      Uri.parse(url),
      data: form,
      headers: apiHeader,
      uploadProgress: uploadProgress,
    );

    final decodeRes = jsonDecode(response.toString()) as Map<String, dynamic>?;

    if (decodeRes != null) {
      final secureImageUrl = decodeRes['secure_url'] as String;

      log('SECURE URL: $secureImageUrl');

      return secureImageUrl;
    } else {
      return null;
    }
  }

  Map<String, String> apiHeader = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
}
