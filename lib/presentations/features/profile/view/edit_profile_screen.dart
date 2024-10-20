import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});
  static String editProfilePath = 'editProfileScreen';

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
            Avatar(
              url: user?.photoUrl,
              avatarDimension: 100,
              editorDimension: 35,
              editImage: true,
            ),
          ],
        ),
      ),
    );
  }
}
