import 'package:flutter/material.dart';
import 'package:projects/commons/src/components.dart';

class EditUserData extends StatefulWidget {
  const EditUserData({required this.title, required this.value, super.key});
  final String title;
  final String value;

  static String editUserDataPath = 'editUserData';

  @override
  State<EditUserData> createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  TextEditingController? editingController;

  @override
  void initState() {
    editingController = TextEditingController(text: widget.value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ContentView(
      pageTitle: widget.title,
      appBarTrailing: [],
      body: Column(
        children: [
          CustomInputField(
            controller: editingController,
            autofocus: true,
            maxLength: 25,
          ),
        ],
      ),
    );
  }
}
