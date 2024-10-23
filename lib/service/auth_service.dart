import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// The `signUp` function in Dart sends a sign-up request with email, password, and additional data to a
  /// Supabase authentication service and returns the authentication response.
  ///
  /// Args:
  ///   email (String): The `email` parameter in the `signUp` function is a string that represents the
  /// email address of the user who is signing up for an account.
  ///   password (String): The `password` parameter in the `signUp` function is a string that represents
  /// the password that the user wants to use for their account. It is a required field for creating a new
  /// account during the sign-up process.
  ///   moreData (Map<String, dynamic>): The `moreData` parameter in the `signUp` method is a `Map<String,
  /// dynamic>` that allows you to provide additional data during the user sign-up process. This data can
  /// include any extra information you want to associate with the user account being created, such as
  /// user preferences, profile information
  ///
  /// Returns:
  ///   The `signUp` function returns a `Future` object that resolves to an `AuthResponse` object.

  Future<AuthResponse?> signUp(
    String email,
    String password,
    Map<String, dynamic>? moreData,
  ) async {
    final res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: moreData,
    );

    return res;
  }

  Future<AuthResponse?> signIn(
    String email,
    String password,
  ) async {
    final res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res;
  }
}
