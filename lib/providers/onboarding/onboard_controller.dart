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

  
}
