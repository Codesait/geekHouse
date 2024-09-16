import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.child,
    this.backgroundColor,
    this.radius = 100,
    this.heroAnimationTag = 'profile-photo',
    this.onTap,
    this.padding,
    this.avatarDimension,
    super.key,
  });
  final double radius;
  final Color? backgroundColor;
  final Widget child;
  final double? padding;
  final String heroAnimationTag;
  final void Function()? onTap;
  final double? avatarDimension;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroAnimationTag,
      child: SizedBox.square(
        dimension: avatarDimension,
        child: GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            child: Padding(
              padding: EdgeInsets.all(padding ?? 5.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
