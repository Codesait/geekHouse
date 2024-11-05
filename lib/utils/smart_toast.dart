import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/main.dart';
import 'package:projects/presentation/components/custom_text.dart';
import 'package:projects/presentation/components/gap.dart';
import 'package:projects/utils/mediaquery.dart';

void showToast({
  required String msg,
  bool isError = false,
  String? title,
  bool isWarningMessage = false,
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
    BotToast.showCustomNotification(
      // title: msg,
      // borderRadius: 10.2,
      duration: const Duration(seconds: 5),
      // titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
      align: Alignment.topRight,
      crossPage: false,
      toastBuilder: (cancelFunc) {
        /**
         ** Status colors based on message type
         */
        Color getStatusColor() {
          return isWarningMessage
              ? Colors.orangeAccent.shade700
              : isError
                  ? Colors.redAccent.shade700
                  : Colors.greenAccent.shade700;
        }

        /**
         ** Icon status data based on message type
         */
        IconData getStatusIcon() {
          return isWarningMessage
              ? Icons.warning_rounded
              : isError
                  ? Icons.error
                  : Icons.check_circle;
        }

        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: fullWidth(rootNavigatorKey.currentContext!),
          constraints: const BoxConstraints(
            maxHeight: 90,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.kWhite, width: 1.5),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                getStatusColor().withOpacity(.5),
                getStatusColor().withOpacity(.4),
                AppColors.kWhite,
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 239, 233, 233),
                child: Icon(
                  getStatusIcon(),
                  color: getStatusColor(),
                ),
              ),
              const Gap(10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: title ?? 'Alert',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    Flexible(
                      child: TextView(
                        text: msg,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

void authAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function() onAccept,
}) {
  showAdaptiveDialog<dynamic>(
    context: context,
    barrierDismissible: true,
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

void logOutAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function() onAccept,
}) {
  showAdaptiveDialog<dynamic>(
    context: context,
    barrierDismissible: true,
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
          onPressed: () => context.pop(),
          child: const TextView(text: 'Cancel'),
        ),
        TextButton(
          onPressed: onAccept,
          child: const TextView(text: 'Continue'),
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
      height: fullHeight(context),
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
