import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/main.dart';
import 'package:projects/presentations/components/custom_view.dart';
import 'package:projects/providers/auth/auth_provider.dart';
import 'package:projects/providers/profile/profile_viewmodel.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';
import 'package:projects/src/utils.dart';
import 'package:projects/utils/mediaquery.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends ConsumerState<UserProfile> {
  late User userData;

  @override
  void initState() {
    /**
     ** Retrieving the user data from the
     ** authentication provider using Riverpod's `ref.watch` method.
     */
    Future.microtask(() {
      ref.read(profileViewmodelProvider.notifier).getUserProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(profileViewmodelProvider.notifier);

    return ContentView(
      key: UniqueKey(),
      pageTitle: 'Profile',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _AboutUser(
              key: ValueKey('about-user'),
              userName: '',
              email: '',
              photo: '',
            ),
            const Gap(25),
            const Divider(),
            _ActionWidgets(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            _ActionWidgets(
              icon: Icons.question_mark_rounded,
              title: 'How it works',
              onTap: () {},
            ),
            const Divider(),
            _ActionWidgets(
              icon: Icons.report,
              title: 'Report',
              onTap: () {},
            ),
            _ActionWidgets(
              icon: Icons.exit_to_app,
              title: 'Log Out',
              logout: true,
              onTap: () {
                logOutAlertDialog(
                  context,
                  title: 'Log Out',
                  content: 'Are you sure you want to log out ?',
                  onAccept: provider.logOut,
                );
              },
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
  const _AboutUser({
    required this.userName,
    required this.email,
    required this.photo,
    super.key,
  });
  final String userName;
  final String email;
  final String photo;

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
    required this.onTap,
    this.logout = false,
  });
  final IconData icon;
  final String title;
  final bool logout;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: fullWidth(context),
      child: InkWell(
        onTap: onTap,
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
      ),
    );
  }
}
