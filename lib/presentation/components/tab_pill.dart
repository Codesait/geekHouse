import 'package:flutter/material.dart';

class TabPill extends StatelessWidget {
  const TabPill({
    required this.backgroundColor,
    required this.title,
    required this.icon,
    super.key,
  });
  final Color backgroundColor;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              title,
              style: const TextStyle(fontFamily: 'Galano', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
