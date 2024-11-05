import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/common/src/config.dart';

class TextView extends StatelessWidget {
  const TextView({
    required this.text,
    super.key,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.textStyle,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.maxLines,
    this.decoration,
  });

  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final int? maxLines;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        key: key,
        style: textStyle ??
            GoogleFonts.outfit(
              fontSize: fontSize != null ? fontSize! : 14,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: color ?? AppColors.kBlack,
              decoration: decoration,
            ),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
