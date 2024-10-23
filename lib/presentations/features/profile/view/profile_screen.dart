import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/config.dart';
import 'package:projects/commons/src/data.dart';
import 'package:projects/commons/src/providers.dart';
import 'package:projects/commons/src/screens.dart';
import 'package:projects/commons/src/utils.dart';
import 'package:projects/main.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  static String profilePath = 'profileScreen';

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends ConsumerState<UserProfile> {
  Profile? user;

  @override
  void initState() {
    /**
     ** Retrieving the user data from the
     ** authentication provider using Riverpod's `ref.watch` method.
     */
    Future.microtask(() {
      if (user == null) {
        ref.read(profileViewmodelProvider.notifier).getUserProfile();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(profileViewmodelProvider.notifier);
    user = provider.userProfile;

    return ContentView(
      key: UniqueKey(),
      pageTitle: 'Profile',
      onRefresh: () => provider.getUserProfile(reloading: true),
      body: ListView(
        children: [
          _AboutUser(
            key: const ValueKey('about-user'),
            user: user!,
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
          Align(
            child: TextView(
              text:
                  'Version: ${packageInfo.version}+${packageInfo.buildNumber}',
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutUser extends StatelessWidget {
  const _AboutUser({
    required this.user,
    super.key,
  });
  final Profile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Avatar(
          url: user.photoUrl,
          avatarDimension: 100,
        ),
        const Gap(10),
        Hero(
          tag: 'user-name',
          child: TextView(
            text: '@${user.username}',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        TextView(
          text: user.emailAddress ?? 'null',
          fontWeight: FontWeight.normal,
        ),
        const Gap(20),
        _Followings(
          followingCount: user.followingsCount,
          followersCount: user.followersCount,
        ),
        const Gap(10),
        TextView(
          text: user.bio ?? '',
          fontWeight: FontWeight.w500,
        ),
        const Gap(10),
        DefaultButton(
          text: 'Edit Profile',
          width: 150,
          height: 45,
          borderRadius: 100,
          onPressed: () {
            context.pushNamed(EditProfileScreen.editProfilePath);
          },
        ),
      ],
    );
  }
}

class _Followings extends StatelessWidget {
  const _Followings({this.followingCount, this.followersCount});
  final int? followingCount;
  final int? followersCount;

  @override
  Widget build(BuildContext context) {
    /**
     ** following/followers count widget
    */
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
          dataHolder('$followingCount', 'Following'),
          const VerticalDivider(
            indent: 15,
          ),
          dataHolder('$followersCount', 'Followers'),
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
