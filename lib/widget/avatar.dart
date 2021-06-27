import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.radius,
    required this.backgroundColor,
    required this.child
  }) : super(key: key);
  final double radius;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: child,
      ),
    );
  }
}
