import 'package:flutter/material.dart';
import 'package:projects/presentations/components/custom_view.dart';
import 'package:projects/src/components.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ContentView(
      key: UniqueKey(),
      pageTitle: 'Profile',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Avatar(
              avatarDimension: 100,
              child: Image.asset('assets/images/yello.png'),
            ),
            const Gap(10),
            const Hero(
              tag: 'user-name',
              child: TextView(
                text: 'Greg Mali',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const TextView(
              text: '@gregali123',
              fontWeight: FontWeight.normal,
            ),
            const Gap(25),
            DefaultButton(
              text: 'Edit Profile',
              width: 150,
              height: 45,
              borderRadius: 100,
              onPressed: () {},
            ),

            const Gap(25),
            const Divider(),



          ],
        ),
      ),
    );
  }
}

class _ActionWidgets extends StatelessWidget {
  const _ActionWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      child: Row(
        children: [
          
        ],
      ),
    );
  }
}
