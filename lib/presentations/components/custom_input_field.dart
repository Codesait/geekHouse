import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/presentations/components/obscure_btn.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    this.fieldLabel,
    this.toolTipMessage,
    this.hint,
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(10),
    this.prefixIcon,
    this.password = false,
    this.trailing,
    this.onTap,
    this.textCapitalization = TextCapitalization.sentences,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.maxLines,
    this.isFilled = true,
    this.fillColor,
    this.borderColor,
    this.validator,
    this.onChanged,
    this.obscureInput = false,
    this.borderRadius = 30,
    this.maxLength,
    this.enabled = true,
    this.useForgotPass = false,
    this.onForgotPassTap,
    this.visibleField = true,
    this.enableInteractiveSelection,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    super.key,
  });

  final String? fieldLabel;
  final String? hint;
  final String? toolTipMessage;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool readOnly;
  final EdgeInsetsGeometry padding;
  final String? prefixIcon;
  final bool password;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool isFilled;
  final Color? fillColor;
  final Color? borderColor;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureInput;
  final double borderRadius;
  final int? maxLength;
  final bool useForgotPass;
  final bool enabled;
  final void Function()? onForgotPassTap;
  final bool visibleField;
  final bool? enableInteractiveSelection;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;

  @override
  State<CustomInputField> createState() => _PwsTextFieldState();
}

class _PwsTextFieldState extends State<CustomInputField> {
  bool inputObscured = false;
  @override
  void initState() {
    /// The code `if (widget.password) { inputObscured = true; } else { inputObscured = false; }` is
    /// checking the value of the `password` property of the `KoobikTextField` widget.
    if (widget.password) {
      inputObscured = true;
    } else {
      inputObscured = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Visibility(
      visible: widget.visibleField,
      child: Container(
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.fieldLabel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextView(
                  text: widget.fieldLabel ?? '',
                  color: AppColors.kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            SizedBox(
              child: TextFormField(
                maxLength: widget.maxLength,
                controller: widget.controller,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                focusNode: widget.focusNode,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                cursorHeight: 10,
                cursorColor: AppColors.kBlack,
                keyboardType: widget.keyboardType,
                initialValue: widget.initialValue,
                textCapitalization: widget.textCapitalization,
                onTap: widget.onTap,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                textAlign: widget.textAlign,
                maxLines: widget.maxLines ?? 1,
                validator: widget.validator,
                onChanged: widget.onChanged,
                obscureText:
                    widget.password ? inputObscured : widget.obscureInput,
                inputFormatters: widget.inputFormatters,
                onFieldSubmitted: widget.onFieldSubmitted,
                onEditingComplete: widget.onEditingComplete,
                decoration: InputDecoration(
                  border: widget.readOnly ? InputBorder.none : null,
                  hintText: widget.hint,
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.kGrey.withOpacity(.6),
                    fontSize: 13,
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            widget.prefixIcon!,
                            width: 20,
                            height: 20,
                          ),
                        )
                      : null,
                  suffixIcon: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Visibility(
                        visible: widget.password,
                        child: ObscureBtn(
                          onTap: () {
                            /// This is used to toggle the value of the `inputObscured`
                            /// variable.
                            setState(() {
                              inputObscured = !inputObscured;
                            });
                          },
                          inputObscured: inputObscured,
                        ),
                      ),
                      Visibility(
                        visible: widget.trailing != null,
                        child: widget.trailing ?? const SizedBox(),
                      ),
                    ],
                  ),
                  filled: widget.isFilled,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  fillColor: widget.fillColor ??
                      const Color.fromARGB(255, 240, 239, 239),
                  enabledBorder: widget.isFilled
                      ? OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                            color: widget.borderColor ?? AppColors.kWhite,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  errorStyle: const TextStyle(color: AppColors.kBlack),
                  errorMaxLines: 4,
                ),
              ),
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(0),
                //? forgot passowrd link widget
                //? [useForgotPass] to enable widget
                Visibility(
                  visible: widget.useForgotPass,
                  child: InkWell(
                    onTap: widget.onForgotPassTap,
                    child: Text(
                      'Forgot password?',
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: AppColors.kPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
