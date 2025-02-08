import 'package:flutter/material.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/common/src/utils.dart';

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({this.onRetryPress, super.key});
  final void Function()? onRetryPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight(context),
      width: fullHeight(context),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 70,
            child: Icon(
              Icons.refresh_rounded,
              size: 80,
              color: AppColors.kPrimary,
            ),
          ),
          const Gap(20),
          const TextView(
            text: 'An Error occurd, please try again',
          ),
          const Gap(10),
          DefaultButton(
            width: 150,
            text: 'try again',
            onPressed: onRetryPress,
          ),
        ],
      ),
    );
  }
}
