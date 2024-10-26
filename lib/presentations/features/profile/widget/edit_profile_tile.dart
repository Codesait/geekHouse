import 'package:flutter/material.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/utils.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({
    required this.title,
    required this.onEditTap,
    this.value,
    super.key,
  });
  final String title;
  final String? value;
  final void Function() onEditTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEditTap,
      child: Container(
        height: 60,
        width: fullWidth(context),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: title,
              fontWeight: FontWeight.w600,
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: TextView(
                    text: value ?? 'Add ${title.toLowerCase()}',
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
                const Gap(3),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
