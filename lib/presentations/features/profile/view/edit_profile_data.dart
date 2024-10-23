import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/providers.dart';
import 'package:projects/presentations/features/profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:projects/presentations/features/profile/widget/save_btn.dart';

class EditUserData extends ConsumerStatefulWidget {
  const EditUserData({
    required this.title,
    this.value,
    this.editableCharSize,
    super.key,
  });
  final String title;
  final String? value;
  final int? editableCharSize;

  static String editUserDataPath = 'editUserData';

  @override
  EditUserDataState createState() => EditUserDataState();
}

class EditUserDataState extends ConsumerState<EditUserData> {
  TextEditingController? editingController;

  @override
  void initState() {
    editingController = TextEditingController(text: widget.value);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    /**
     ** determining whether the current text in
     ** the editing controller is different from the initial value (`widget.value`) and is not empty.
     */
    final canSaveEdit = editingController!.text.trim() != widget.value &&
        editingController!.text.trim().isNotEmpty;

    final profileProv = ref.watch(profileViewmodelProvider.notifier);
    final provider = ref.watch(editProfileViewmodelProvider.notifier);
    final state = ref.watch(editProfileViewmodelProvider);

    return ContentView(
      pageTitle: widget.title,
      appBarTrailing: [
        SaveBtn(
          isSaving: state.isLoading,
          canSave: canSaveEdit,
          onSave: () {
            switch (widget.title.toUpperCase()) {
              case 'USERNAME':
                provider.updateUserData(
                  getUserCallback: profileProv.getUserProfile,
                  userName: editingController!.text,
                );
              case 'BIO':
                provider.updateUserData(
                  getUserCallback: profileProv.getUserProfile,
                  bio: editingController!.text,
                );
            }
            if (widget.title.toUpperCase() == 'USERNAME') {
              provider.updateUserData(
                getUserCallback: () {},
                userName: editingController!.text,
              );
            }
          },
        ),
      ],
      body: Column(
        children: [
          CustomInputField(
            controller: editingController,
            autofocus: true,
            maxLength: widget.editableCharSize,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
