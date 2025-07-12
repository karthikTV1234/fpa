import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/features/child_profile/bloc/child_bloc.dart';
import 'package:child_health_story/shared/widgets/profile_image.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/strings/app_data.dart';

class ChildProfileBar extends StatefulWidget {
  const ChildProfileBar({super.key});

  @override
  State<ChildProfileBar> createState() => _ChildProfileBarState();
}

class _ChildProfileBarState extends State<ChildProfileBar> {
  late ChildBloc childBloc;

  @override
  void initState() {
    childBloc = BlocProvider.of<ChildBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          callback: (imageFile, imagePath) {
            childBloc.add(UploadProfilePicEvent(imageFile));
          },
          wallpaperImage: AppData.childDetails["wallpaper"],
        ),
        SizedBox(
          height: 90,
        ),
        TextWidgets.textWidget(
            AppData.childDetails["child_name"], AppColors.cblackColor,
            fontSize: 18.0, fontWeight: FontWeight.w700),
        TextWidgets.textWidget(
            AppData.childDetails["age"], AppColors.cblackColor,
            fontSize: 16.0, fontWeight: FontWeight.w400),
      ],
    );
  }
}
