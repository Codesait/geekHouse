import 'package:flutter/material.dart';
import 'package:projects/main.dart';
import 'package:projects/presentations/components/custom_view.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

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
            const _AboutUser(key: ValueKey('about-user')),
            const Gap(25),
            const Divider(),
            const _ActionWidgets(
              icon: Icons.settings,
              title: 'Settings',
            ),
            const _ActionWidgets(
              icon: Icons.question_mark_rounded,
              title: 'How it works',
            ),
            const Divider(),
            const _ActionWidgets(
              icon: Icons.report,
              title: 'Report',
            ),
            const _ActionWidgets(
              icon: Icons.exit_to_app,
              title: 'Log Out',
              logout: true,
            ),
            const Gap(40),
            TextView(
              text:
                  'Version: ${packageInfo.version}+${packageInfo.buildNumber}',
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutUser extends StatelessWidget {
  const _AboutUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Gap(20),
        const _Followings(),
        const Gap(20),
        DefaultButton(
          text: 'Edit Profile',
          width: 150,
          height: 45,
          borderRadius: 100,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _Followings extends StatelessWidget {
  const _Followings({super.key});

  @override
  Widget build(BuildContext context) {
    Widget dataHolder(String count, String desc) => Column(
          children: [
            TextView(
              text: count,
              fontWeight: FontWeight.bold,
            ),
            TextView(
              text: desc,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ],
        );

    return SizedBox(
      height: 40,
      width: fullWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dataHolder('300', 'Following'),
          const VerticalDivider(
            indent: 15,
          ),
          dataHolder('3,100', 'Followers'),
        ],
      ),
    );
  }
}

class _ActionWidgets extends StatelessWidget {
  const _ActionWidgets({
    required this.icon,
    required this.title,
    this.logout = false,
  });
  final IconData icon;
  final String title;
  final bool logout;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: fullWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.kPrimary.withOpacity(.4),
                ),
                child: Icon(
                  icon,
                  size: 16,
                ),
              ),
              const Gap(10),
              TextView(
                text: title,
                color: logout ? Colors.red : null,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: logout ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }
}
