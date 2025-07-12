import 'dart:io';

import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/custom_circular_avatar.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Function(File, String) callback;
  final bool showCamera;
  final File? imageFile;
  final String? wallpaperImage;

  const ProfileImage(
      {super.key,
      required this.callback,
      this.showCamera = false,
      this.imageFile,
      this.wallpaperImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            color: AppColors.circleBorderColor,
            child: wallpaperImage != null
                ? Image(fit: BoxFit.cover, image: NetworkImage(wallpaperImage!))
                : null),
        Positioned(
          bottom: -70,
          child: CustomCircleAvatar(
            mainContext: context,
            showCamera: showCamera,
            callback: (imagePath, imageName) {
              callback(imagePath, imageName);
            },
            imageFile: null,
          ),
        ),
      ],
    );
  }
}
