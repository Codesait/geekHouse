import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/common/src/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interest_viewmodel.g.dart';

@riverpod
class InterestViewmodel extends _$InterestViewmodel {
  final interestRepo = InterestsRepo();

  @override
  FutureOr<dynamic> build() {
    return state;
  }

  List<dynamic>? _interestList = [];
  List<dynamic>? get interestList => _interestList;

  Future<void> getInterests({void Function()? callback}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => interestRepo.fetchInterestsData().then((data) async {
        if (data != null) {

          //? 
          if(callback != null) {
            callback();
          }

          /**
            ** Map the response data to list
          */
          _interestList = data;
          log('INTEREST DATA $data');
        } else {
          debugPrint('No interest data found.');

          return;
        }
      }),
    );
  }

  Future<void> saveUserInterests({required List<int> userInterest}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => interestRepo.insertUserInterests(userInterest).then((data) {
        if (data != null) {
          log(data.toString());

          // rootNavigatorKey.currentContext!
          //     .pushReplacementNamed(JoinCommunities.joinCommunityPath);
        }
      }),
    );
  }
}

final interestRepo = ChangeNotifierProvider((_) => InterestsRepo());

class InterestsRepo extends ChangeNotifier {
  final service = InterestServices();

  Future<List<dynamic>?> fetchInterestsData() async {
    return service.fetchInterests();
  }

  Future<dynamic> insertUserInterests(List<int> userInterest) async {
    return service.saveInterests(userInterest: userInterest);
  }
}
