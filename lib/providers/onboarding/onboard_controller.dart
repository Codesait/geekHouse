import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingController = ChangeNotifierProvider((_) => OnboardController());

class OnboardController extends ChangeNotifier {
  int _page = 0;
  int get page => _page;
  void setPage(int i) {
    _page = i;
    notifyListeners();
  }

  String? _userName;
  String? get userName => _userName;
  set userName(String? username) {
    _userName = username;
    notifyListeners();
  }

  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? url) => _imageUrl;
}
