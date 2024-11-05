// ignore_for_file: prefer_typing_uninitialized_variables

class CustomException implements Exception {

  CustomException([this._message, this._prefix]);
  final String? _message;
  final String? _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

class ForbiddenRequestException extends CustomException {
  ForbiddenRequestException([String? message]) : super(message, 'Forbidden: ');
}

class RequestTimeoutException extends CustomException {
  RequestTimeoutException([String? message]) : super(message, 'Timeout: ');
}

class InternetException extends CustomException {
  InternetException([String? message]) : super(message, 'Internet is unstable:');
}
