import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/main.dart';
import 'package:projects/presentation/components/shared/custom_text.dart';
import 'package:projects/presentation/components/shared/gap.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required String msg,
  bool isError = false,
  String title = 'Alert',
  bool isWarningMessage = false,
}) {
final theme = Theme.of(rootNavigatorKey.currentContext!);

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

  toastification.show(
    context: rootNavigatorKey.currentContext,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    title: TextView(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      decoration: TextDecoration.underline,
    ),
    description: RichText(
      text: TextSpan(
        text: msg,
        style: theme.textTheme.titleSmall!.copyWith(
          color: Colors.white,
        ),
      ),
    ),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: Icon(
      isError
          ? Icons.error_rounded
          : isWarningMessage
              ? Icons.warning_rounded
              : Icons.check,
    ),
    showIcon: true, // show or hide the icon
    primaryColor: Colors.white,
    backgroundColor: getStatusColor(),
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
      ),
    ],
    showProgressBar: true,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
      buttonBuilder: (context, onClose) {
        return OutlinedButton.icon(
          onPressed: onClose,
          icon: const Icon(Icons.close, size: 20),
          label: const Text('Close'),
        );
      },
    ),
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
    // callbacks: ToastificationCallbacks(
    //   onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    //   onCloseButtonTap: (toastItem) =>
    //       print('Toast ${toastItem.id} close button tapped'),
    //   onAutoCompleteCompleted: (toastItem) =>
    //       print('Toast ${toastItem.id} auto complete completed'),
    //   onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    // ),
  );
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

void showAlertDialog(
  BuildContext context, {
  required Widget child,
}) {
  showAdaptiveDialog<dynamic>(
    context: context,
    builder: (ctx) => AlertDialog.adaptive(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: Material(
        color: Colors.transparent,
        child: child,
      ),
    ),
  );
}
