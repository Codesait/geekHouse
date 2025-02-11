// ignore_for_file: avoid_dynamic_calls, avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/common/src/providers.dart';
import 'package:projects/common/src/utils.dart';
import 'package:projects/presentation/features/userInterests/widget/interest_chip.dart';

class InterestsScreen extends ConsumerStatefulWidget {
  const InterestsScreen({super.key});

  static String interestPath = 'interestScreen';

  @override
  InterestsScreenState createState() => InterestsScreenState();
}

class InterestsScreenState extends ConsumerState<InterestsScreen> {
  List<int> selectedInterest = [];

  @override
  void initState() {
    Future.microtask(() {
      ref.read(interestViewmodelProvider.notifier).getInterests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateProvider = ref.watch(interestViewmodelProvider);
    final provider = ref.watch(interestViewmodelProvider.notifier);

    if (stateProvider.isLoading) {
      return Scaffold(
        body: Container(
          height: fullHeight(context),
          width: fullWidth(context),
          alignment: Alignment.center,
          child: SizedBox.square(
            dimension: 40,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.kPrimary,
            ),
          ),
        ),
      );
    } else {
      // Perform a switch-case on the result to handle loading/error states
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: provider.interestList == null
            ? ErrorPlaceholder(
                onRetryPress: provider.getInterests,
              )
            : SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: RefreshIndicator.adaptive(
                            onRefresh: provider.getInterests,
                            child: Column(
                              children: [
                                /**
                                 *? list
                                */
                                Container(
                                  constraints: BoxConstraints.expand(
                                    height: 600,
                                    width: fullWidth(context),
                                  ),
                                  child: ListView(
                                    padding: const EdgeInsets.only(bottom: 200),
                                    children: provider.interestList!.map((e) {
                                      final groupName =
                                          e['category']! as String;
                                      final groupList =
                                          e['interests']! as List<dynamic>;

                                      return _InterestGroup(
                                        key: Key(groupName),
                                        category: groupName,
                                        interestList: groupList,
                                        selectedInterest: selectedInterest,
                                        onSelected: (isSelected, id) {
                                          setState(() {
                                            if (isSelected) {
                                              selectedInterest.add(id);
                                              debugPrint(
                                                selectedInterest.toString(),
                                              );
                                            } else {
                                              selectedInterest.remove(id);
                                              debugPrint(
                                                selectedInterest.toString(),
                                              );
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /**
                     ** Save user interest
                    */
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: DefaultButton(
                          text: 'Continue',
                          height: 50,
                          width: fullWidth(context),
                          buttonstate: selectedInterest.isEmpty
                              ? Buttonstate.disabled
                              : Buttonstate.idle,
                          onPressed: () async {
                            await provider.saveUserInterests(
                              userInterest: selectedInterest,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    }
  }
}

class _InterestGroup extends StatelessWidget {
  const _InterestGroup({
    required this.category,
    required this.interestList,
    required this.selectedInterest,
    required this.onSelected,
    super.key,
  });

  final String category;
  final List<dynamic> interestList;
  final List<int> selectedInterest;
  final void Function(bool v, int id) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: category,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          const Gap(10),
          Wrap(
            spacing: 8,
            children: interestList.map((dynamic interest) {
              final name = interest['name'] as String;
              final id = interest['id'] as int;
              final isSelected = selectedInterest.contains(id);

              return InterestChip(
                interestName: name,
                isSelected: isSelected,
                onSelected: ({required bool isChecked}) =>
                    onSelected(isChecked, id),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
