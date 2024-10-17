import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:projects/service/exceptions/custom_exception.dart';
import 'package:projects/commons/src/utils.dart';

class ApiHelper {
  final dio = Dio();
  Future<dynamic> uploadMth(
    Uri uri, {
    required FormData data,
    required Map<String, dynamic> headers,
    required void Function(int, int) uploadProgress,
  }) async {
    log('Making request to $uri');
    final options = Options(headers: headers, responseType: ResponseType.plain);
    try {
      // ignore: inference_failure_on_function_invocation
      final response = await dio.post(
        uri.toString(),
        data: data,
        options: options,
        onSendProgress: (int sent, int total) {
          uploadProgress(sent, total);
          log(
            'sent$sent total$total',
          );
        },
      );

      return _dioResponse(response);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic _dioResponse(
    Response<dynamic> response,
  ) async {
    switch (response.statusCode) {
      case 200:

        ///* This is a catch block for when the server returns a 200 ok status.
        log('${response.statusCode}\n${response.data}');

        return response.data;
      case 201:

        ///* This is a catch block for when the server returns a 201 created status.
        log('${response.statusCode}\n${response.data}');
        return response.data;
      case 400:

        ///* This is a catch block for when the server returns a 400 bad request status.
        log('${response.statusCode}\n${response.data}');

        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorisedException(response.data.toString());
      case 403:

        ///* This is a catch block for when the server returns a 403 access unauthorised error.
        log('${response.statusCode}\n${response.data}');

        throw ForbiddenRequestException(response.data.toString());

      case 408:

        ///* This is a catch block for when the server returns a 408 timeout error.
        log('${response.statusCode}\n${response.data}');
        throw Exception(response.data);

      case 409:

        ///* This is a catch block for when the server returns a 409.
        log('${response.statusCode}\n${response.data}');
        throw Exception(response.data);

      case 500:

        ///* This is a catch block for when the server returns a 500 error.
        showToast(
          msg: 'Uh oh... Server Error',
          isError: true,
        );
        log('${response.statusCode}\n${response.data}');
        throw Exception(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}',
        );
      default:
        log('${response.statusCode}\n${response.data}');
        throw Exception(
          'Something went wrong: ${response.statusCode}',
        );
    }
  }
}
