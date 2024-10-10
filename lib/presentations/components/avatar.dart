import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:projects/src/components.dart';
import 'package:projects/src/config.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    this.url,
    this.backgroundColor,
    this.radius = 100,
    this.heroAnimationTag = 'profile-photo',
    this.onTap,
    this.padding,
    this.avatarDimension,
    this.editorDimension = 30,
    this.editImage = false,
    this.canDelete = true,
    this.imageUploadInProgress = false,
    this.onEditImageTap,
    super.key,
  });
  final double radius;
  final Color? backgroundColor;
  final String? url;
  final double? padding;
  final String heroAnimationTag;
  final void Function()? onTap;
  final double? avatarDimension;
  final double editorDimension;
  final bool editImage;
  final bool canDelete;
  final bool imageUploadInProgress;
  final void Function()? onEditImageTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroAnimationTag,
      child: Stack(
        children: [
          _ImageHolder(
            avatarDimension: avatarDimension,
            onTap: onTap,
            imageUrl: url,
            backgroundColor: AppColors.kPrimary.withOpacity(.4),
            radius: radius,
            padding: padding,
            uploading: imageUploadInProgress,
          ),
          _EditWidget(
            canDelete: canDelete,
            editImage: editImage,
            editorDimension: editorDimension,
            onEditImageTap: onEditImageTap,
          ),
        ],
      ),
    );
  }
}

class _ImageHolder extends StatelessWidget {
  const _ImageHolder({
    required this.radius,
    required this.uploading,
    this.avatarDimension,
    this.onTap,
    this.imageUrl,
    this.backgroundColor,
    this.padding,
  });
  final void Function()? onTap;
  final double? avatarDimension;
  final double radius;
  final String? imageUrl;
  final Color? backgroundColor;
  final double? padding;
  final bool uploading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: uploading
              ? SizedBox.square(
                  dimension: avatarDimension,
                  child: Lottie.asset(
                    'assets/animations/upload_animation.json',
                    repeat: true,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl ?? '',
                  fit: BoxFit.fill,
                  height: avatarDimension,
                  width: avatarDimension,
                  progressIndicatorBuilder:
                      (context, url, DownloadProgress progress) {
                    return SizedBox.fromSize(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                        color: AppColors.kPrimary,
                        backgroundColor: AppColors.kWhite,
                      ),
                    );
                  },
                  errorWidget: (context, url, __) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppAsset.personIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.kPrimary.withOpacity(.6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _EditWidget extends StatelessWidget {
  const _EditWidget({
    required this.canDelete,
    required this.editImage,
    required this.editorDimension,
    this.onEditImageTap,
  });
  final bool editImage;
  final bool canDelete;
  final double editorDimension;
  final void Function()? onEditImageTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
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
                    onTap: onEditImageTap,
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
    );
  }
}
