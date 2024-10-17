import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/providers.dart';
import 'package:projects/commons/src/screens.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(profileViewmodelProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: 'user-name',
          child: TextView(
            text: 'Hey ${provider.userProfile?.username},',
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
              url: provider.userProfile?.photoUrl,
              avatarDimension: 40,
              backgroundColor: Colors.deepPurple.shade300,
              onTap: () => context.pushNamed(UserProfile.profilePath),
            )
          ],
        ),
      ],
    );
  }
}
