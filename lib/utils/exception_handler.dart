import 'dart:async';
import 'dart:io';
import 'package:projects/common/src/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseExceptionHandlerService {
  static Future<T> handleExceptions<T>(Future<T> Function() action) async {
    final log = getLogger('Exception');

    try {
      return await action();
    } on SocketException catch (_) {
      showToast(msg: 'No Internet Connection', isWarningMessage: true);
      log.e('No Internet Connection');

      throw Exception('No Internet connection. Please check and try again.');
    } on AuthException catch (e) {
      if (e.statusCode != null && e.statusCode == '500') {
        showToast(msg: 'Server Error', isError: true);
      } else {
        showToast(msg: e.message, isError: true);
      }
      log.e('AuthException mpi: ${e.message}');

      throw Exception('Authentication error: ${e.message}');
    } on PostgrestException catch (e) {
      showToast(msg: 'An unexpected error occurred', isError: true);
      log.i('PostgrestException: ${e.message}');

      throw Exception('Database error: ${e.message}');
    } on TimeoutException catch (_) {
      showToast(msg: 'Network Request Timeout', isWarningMessage: true);
      log.e('Request Timeout');

      throw Exception('Request timed out. Try again later.');
    } on FormatException catch (e) {
      log.e('FormatException: ${e.message}');

      throw Exception('Data formatting error.');
    } catch (e) {
      log.e('Unexpected error: $e');

      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}
