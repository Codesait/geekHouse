import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/common/src/data.dart';
import 'package:projects/common/src/providers.dart';
import 'package:projects/common/src/screens.dart';
import 'package:projects/presentation/features/profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  static String editProfilePath = 'editProfileScreen';

  static void navToEdit(
    BuildContext ctxt, {
    required String title,
    String? value,
    String? charSize,
  }) {
    ctxt.pushNamed(
      EditUserData.editUserDataPath,
      queryParameters: {
        'title': title,
        'value': value,
        'charSize': charSize,
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
    final providerState = ref.watch(profileViewmodelProvider);
    final user = provider.userProfile;

    return ContentView(
      pageTitle: 'Edit Profile',
      body: Skeletonizer(
        enabled: providerState.isLoading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EditPhotoSection(
                user: user,
              ),
              _AboutYouSection(user: user),
              const Divider(),
              const _EditSocialSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditPhotoSection extends ConsumerWidget {
  const _EditPhotoSection({
    this.user,
  });
  final Profile? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileViewmodelProvider.notifier);
    final editProfilePRovider =
        ref.watch(editProfileViewmodelProvider.notifier);
    final state = ref.watch(profileViewmodelProvider);

    return Column(
      children: [
        Avatar(
          url: user?.photoUrl,
          avatarDimension: 100,
          editorDimension: 35,
          editImage: true,
          canDelete: false,
          imageUploadInProgress: state.isLoading,
          onEditImageTap: () async {
            await profileProvider.uploadProfileImageAndGetUrl().then((v) {
              if (v != null) {
                /**
                 *? Push new image to db
                 */
                editProfilePRovider.updateUserData(
                  disablePop: true,
                  getUserCallback: () {
                    //* then fetch updated user data
                    profileProvider.getUserProfile(reloading: true);
                  },
                  profilePhoto: v,
                );
              }
            });
          },
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
            value: user?.username,
            onEditTap: () {
              EditProfileScreen.navToEdit(
                context,
                title: 'Username',
                value: user?.username,
                charSize: '25',
              );
            },
          ),
          EditProfileTile(
            title: 'Bio',
            value: user?.bio,
            onEditTap: () {
              EditProfileScreen.navToEdit(
                context,
                title: 'Bio',
                value: user?.bio,
                charSize: '50',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EditSocialSection extends StatelessWidget {
  const _EditSocialSection({
    // ignore: unused_element
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
