import 'package:flutter/material.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/config.dart';

class SaveBtn extends StatefulWidget {
  const SaveBtn({
    required this.onSave,
    required this.canSave,
    this.isSaving = false,
    super.key,
  });
  final void Function() onSave;
  final bool canSave;
  final bool isSaving;

  @override
  State<SaveBtn> createState() => _SaveBtnState();
}

class _SaveBtnState extends State<SaveBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: widget.isSaving
          ? const CircularProgressIndicator.adaptive()
          : TextButton(
              onPressed: widget.canSave ? widget.onSave : null,
              child: Opacity(
                opacity: widget.canSave ? 1 : .3,
                child: TextView( 
                  text: 'Save',
                  fontSize: 16,
                  color: AppColors.kPrimary,
                ),
              ),
            ),
    );
  }
}
