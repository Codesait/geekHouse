import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.radius,
    required this.backgroundColor,
    required this.child,
    this.padding
  }) : super(key: key);
  final double radius;
  final Color backgroundColor;
  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Padding(
        padding:  EdgeInsets.all(padding ?? 5.0),
        child: child,
      ),
    );
  }
}
