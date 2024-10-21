import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/config.dart';
import 'package:projects/commons/src/data.dart';
import 'package:projects/commons/src/providers.dart';
import 'package:projects/commons/src/screens.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  static String editProfilePath = 'editProfileScreen';

  static void navToEdit(BuildContext ctxt, {required String title, required String value}) {
    ctxt.pushNamed(
      EditUserData.editUserDataPath,
      queryParameters: {
        'title': title,
        'value': value,
      },
    );
  }

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(profileViewmodelProvider.notifier);
    final user = provider.userProfile;

    return ContentView(
      pageTitle: 'Edit Profile',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EditPhotoSection(user: user),
            _AboutYouSection(user: user),
            const Divider(),
            const _EditSocialSection(),
          ],
        ),
      ),
    );
  }
}

class _EditPhotoSection extends StatelessWidget {
  const _EditPhotoSection({this.user});
  final Profile? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Avatar(
          url: user?.photoUrl,
          avatarDimension: 100,
          editorDimension: 35,
          editImage: true,
        ),
        const Gap(5),
        InkWell(
          onTap: () {},
          child: const TextView(
            text: 'Change photo',
          ),
        ),
      ],
    );
  }
}

class _AboutYouSection extends StatelessWidget {
  const _AboutYouSection({
    this.user,
  });
  final Profile? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: TextView(
              text: 'About you',
              color: AppColors.kGrey,
            ),
          ),
          EditProfileTile(
            title: 'Username',
            value: user?.username ?? 'null',
            onEditTap: () {
              EditProfileScreen.navToEdit(context, title: 'Username', value: user!.username!);
            },
          ),
          EditProfileTile(
            title: 'Bio',
            value: 'Add bio',
            onEditTap: () {},
          ),
        ],
      ),
    );
  }
}

class _EditSocialSection extends StatelessWidget {
  const _EditSocialSection({
    this.user,
  });
  final Profile? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: TextView(
              text: 'Social',
              color: AppColors.kGrey,
            ),
          ),
          Opacity(
            opacity: .2,
            child: EditProfileTile(
              title: 'Instagram',
              value: 'Melasin.dev',
              onEditTap: () {},
            ),
          ),
          Opacity(
            opacity: .2,
            child: EditProfileTile(
              title: 'YouTube',
              value: 'Mela Wick',
              onEditTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
