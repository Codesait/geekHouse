import 'package:flutter/material.dart';
import 'package:projects/presentation/components/avatar.dart';

class ListenerAvatar extends StatelessWidget {
  const ListenerAvatar({
    required this.avatar,
    required this.name,
    required this.color,
    required this.reaction,
    required this.verified,
    required this.speaking,
    super.key,
  });
  final Color color;
  final String avatar;
  final String name;
  final String reaction;
  final String verified;
  final String speaking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 90,
      child: Stack(
        children: [
          Avatar(
            radius: 50,
            backgroundColor: color.withValues(alpha: 0.3),
            avatarDimension: 60,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: desc(),
          ),
        ],
      ),
    );
  }

  Widget desc() {
    return Column(
      children: [
        const SizedBox(
          width: 85,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Avatar(
                radius: 14,
                backgroundColor: Colors.white,
                avatarDimension: 60,
              ),
              // Visibility(
              //   visible: !(speaking == 'true'),
              //   child: const Avatar(
              //     radius: 14,
              //     backgroundColor: Colors.white,
              //     url: Icon(
              //       Icons.mic_off,
              //       color: Colors.black87,
              //       size: 15,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            // Avatar(
            //   radius: 10,
            //   padding: 3,
            //   backgroundColor: Colors.deepPurple.shade300,
            //   url: Image.asset('assets/images/frost.png'),
            // ),
            const SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Galano',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
