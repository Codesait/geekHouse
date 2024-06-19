import 'package:flutter/material.dart';
import 'package:projects/presentations/components/avatar.dart';

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
            backgroundColor: color.withOpacity(0.3),
            child: Image.asset(
              'assets/images/$avatar',
              height: 80,
              width: 80,
            ),
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
        SizedBox(
          width: 85,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Avatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Text(
                  reaction,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Visibility(
                visible: !(speaking == 'true'),
                child: const Avatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.mic_off,
                    color: Colors.black87,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Avatar(
              radius: 10,
              padding: 3,
              backgroundColor: Colors.deepPurple.shade300,
              child: Image.asset('assets/images/frost.png'),
            ),
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
