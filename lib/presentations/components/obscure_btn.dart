import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/src/config.dart';


class ObscureBtn extends StatefulWidget {
  const ObscureBtn({
    required this.onTap,
    this.inputObscured = false,
    this.height,
    this.width,
    this.iconColor = AppColors.kGrey,
    super.key,
  });
  final bool inputObscured;
  final void Function() onTap;
  final double? height;
  final double? width;
  final Color iconColor;

  @override
  State<ObscureBtn> createState() => _ObscureBtnState();
}

class _ObscureBtnState extends State<ObscureBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onTap,
        child: SvgPicture.asset(
          widget.inputObscured ? AppAsset.unhidePassIcon : AppAsset.hidePassIcon,
          colorFilter: ColorFilter.mode(
            widget.iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
