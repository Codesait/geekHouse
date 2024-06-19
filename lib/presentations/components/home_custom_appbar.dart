import 'package:flutter/material.dart';
import 'package:projects/presentations/components/avatar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Good Morning,\nBernice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Galano',
          ),
        ),
        Row(
          children: [
            IconButton(
              splashRadius: 23,
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            Avatar(
              radius: 20,
              backgroundColor: Colors.deepPurple.shade300,
              child: Image.asset('assets/images/yello.png'),
            ),
          ],
        ),
      ],
    );
  }
}
