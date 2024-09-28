import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.child,
    this.backgroundColor,
    this.radius = 100,
    this.heroAnimationTag = 'profile-photo',
    this.onTap,
    this.padding,
    this.avatarDimension,
    this.editorDimension = 30,
    this.editImage = false,
    this.canDelete = true,
    super.key,
  });
  final double radius;
  final Color? backgroundColor;
  final Widget child;
  final double? padding;
  final String heroAnimationTag;
  final void Function()? onTap;
  final double? avatarDimension;
  final double editorDimension;
  final bool editImage;
  final bool canDelete;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroAnimationTag,
      child: Stack(
        children: [
          SizedBox.square(
            dimension: avatarDimension,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.all(padding ?? 5.0),
                  child: child,
                ),
              ),
            ),
          ),
          Visibility(
            visible: editImage,
            child: Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: editorDimension,
                width: editorDimension,
                decoration: BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.kWhite),
                ),
                alignment: Alignment.center,
                child: PopupMenuButton(
                  tooltip: 'Edit Image',
                  child: SvgPicture.asset(
                    AppAsset.addIcon,
                    height: editorDimension / 2,
                    width: editorDimension / 2,
                  ),
                  itemBuilder: (context) {
                    if (!canDelete) {
                      return <PopupMenuEntry<dynamic>>[
                        PopupMenuItem(
                          onTap: () {},
                          child: const TextView(
                            text: 'Change profile picture',
                          ),
                        ),
                      ];
                    } else {
                      return <PopupMenuEntry<dynamic>>[
                        PopupMenuItem(
                          onTap: () {},
                          child: const TextView(
                            text: 'Change profile picture',
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          onTap: () {},
                          child: canDelete
                              ? const TextView(
                                  text: 'Delete profile picture',
                                  color: Colors.red,
                                )
                              : const SizedBox(),
                        ),
                      ];
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
