import 'package:flutter/material.dart';
import 'package:projects/utils/mediaquery.dart';

class Modal {
  void modalSheet(
    BuildContext context, {
    Widget? child,
    bool isDismissible = true,
    bool enableDrag = false,
    bool padTop = true,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: fullHeigth(context),
          width: fullWidth(context),
          padding: padTop ? const EdgeInsets.only(top: 50) : null,
          child: child,
        );
      },
    );
  }
}
