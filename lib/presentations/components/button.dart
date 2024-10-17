import 'package:flutter/material.dart';
import 'package:projects/commons/src/config.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
    this.textColor,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.borderColor,
    this.loading = false,
    this.iconsAsset,
  });
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final bool loading;
  final String? iconsAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        /// This line of code is setting the background color of the button. It checks the value of the
        /// `buttonstate` parameter and if it is equal to `Buttonstate.disabled`, it sets the color to
        /// `AppColors.kDarkGrey`. Otherwise, it sets the color to the value of the `color` parameter,
        /// which is passed in when the function is called. If `color` is null, it sets the color to a
        /// default value of `const Color(0xFF09132D)`.
        color:  color ?? AppColors.kPrimary,
        border: Border.all(color: borderColor ?? Colors.transparent,width: .5),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
      ),
      child: ButtonTheme(
        child: TextButton(
          onPressed: onPressed,
          child: Center(
            /// This code is setting the child of the `TextButton` widget. It checks the value of the
            /// `buttonstate` parameter and if it is equal to `Buttonstate.loading`, it sets the child to
            /// a `SizedBox` widget with a `CircularProgressIndicator` inside it. This is used to indicate
            /// that the button is in a loading state and the user should wait for the action to complete.
            /// If `buttonstate` is not equal to `Buttonstate.loading`, it sets the child to a `Text`
            /// widget with the `text` parameter passed in when the function is called. The `textColor`,
            /// `fontSize`, and `fontWeight` parameters are also used to style the text.
            child: loading
                ? const SizedBox.square(
                    dimension: 30,
                    child: CircularProgressIndicator(color: AppColors.kWhite),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? 17.0,
                          fontWeight: fontWeight ?? FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      // if (iconsAsset != null)
                      //   Row(
                      //     children: [
                      //       const Gap(10),
                      //       SvgPicture.asset(
                      //         iconsAsset!,
                      //         height: 20,
                      //         width: 20,
                      //       ),
                      //     ],
                      //   ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
