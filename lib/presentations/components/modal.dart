import 'package:flutter/material.dart';
import 'package:projects/utils/size.dart';

class Modal {
  void modalSheet(BuildContext context, {Widget? child}) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: fullHeigth(context),
          width: fullWidth(context),
          padding: const EdgeInsets.only(top: 50),
          child: child,
        );
      },
    );
  }
}
