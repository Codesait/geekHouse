import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projects/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

import '../presentations/components/gap.dart';



void showToast({
  required String msg,
  bool isError = false,
  String? title,
  bool isNeutralMessage = false,
}) {
  const second = 4;
  const preferDirection = PreferDirection.topRight;
  const onlyOne = true;
  const animationMilliseconds = 200;
  const animationReverseMilliseconds = 200;

  if (kIsWeb) {
    BotToast.showAttachedWidget(
      target: const Offset(-16, -16),
      verticalOffset: 10,
      horizontalOffset: 4,
      duration: const Duration(seconds: second),
      animationDuration: const Duration(milliseconds: animationMilliseconds),
      animationReverseDuration:
          const Duration(milliseconds: animationReverseMilliseconds),
      preferDirection: preferDirection,
      onlyOne: onlyOne,
      attachedBuilder: (cancel) => Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: const EdgeInsets.only(right: 8),
          height: 100,
          width: 330,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 8,
                color: isError ? Colors.red : Colors.green,
              ),
              const Gap(7),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title ?? 'Alert',
                    style: const TextStyle(
                      color: AppColors.kBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(7),
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            msg,
                            style: const TextStyle(
                              color: AppColors.kBlack,
                              fontSize: 13,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 30,
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: cancel,
                  splashRadius: 5,
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.kBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    BotToast.showSimpleNotification(
      title: msg,
      borderRadius: 10.2,
      duration: const Duration(seconds: 3),
      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
      align: Alignment.topRight,
      crossPage: false,
      backgroundColor: isNeutralMessage
          ? Colors.grey
          : isError
              ? Colors.red
              : Colors.green,
    );
  }
}

void showAttachedToast({
  required Offset target,
}) {
  const second = 4;
  const preferDirection = PreferDirection.topCenter;
  const onlyOne = true;
  const animationMilliseconds = 200;
  const animationReverseMilliseconds = 200;

  BotToast.showAttachedWidget(
    target: target,
    duration: const Duration(seconds: second),
    animationDuration: const Duration(milliseconds: animationMilliseconds),
    animationReverseDuration:
        const Duration(milliseconds: animationReverseMilliseconds),
    preferDirection: preferDirection,
    verticalOffset: 20,
    onlyOne: onlyOne,
    attachedBuilder: (cancel) => Card(
      color: AppColors.kPrimary,
      child: GestureDetector(
        onTap: cancel,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          width: 150,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox.square(
                dimension: 20,
                child: Icon(
                  Icons.link,
                  size: 15,
                  color: AppColors.kWhite,
                ),
              ),
              Gap(10),
              Center(
                child: Text(
                  'Invite Copied',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.kWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void transferBottomSheet(
  BuildContext context, {
  required Widget child,
}) {
  showModalBottomSheet<dynamic>(
    context: context,
    builder: (ctx) => Container(
      height: fullHeigth(context) * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: child,
    ),
    backgroundColor: AppColors.kWhite,
    elevation: 8,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    constraints: const BoxConstraints(
      maxHeight: 500,
      minHeight: 500,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}

void authAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function() onAccept,
}) {
  showAdaptiveDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog.adaptive(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onAccept,
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}

void alertSheet(
    BuildContext context, {
      required Widget child,
    }) {
  showModalBottomSheet<dynamic>(
    context: context,
    builder: (ctx) => SizedBox(
      height: fullHeigth(context),
      width: fullWidth(context),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Center(child: child);
        },
      ),
    ),

    backgroundColor: AppColors.kBlack.withOpacity(0.01),
    elevation: 8,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
  );
}
