import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Hero(
          tag: 'user-name',
          child: TextView(
            text: 'Hey Greg,',
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
              avatarDimension: 40,
              backgroundColor: Colors.deepPurple.shade300,
              onTap: () => context.pushNamed(Constants.profilePath),
            ),
          ],
        ),
      ],
    );
  }
}
