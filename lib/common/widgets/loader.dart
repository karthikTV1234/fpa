import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class Loader {
  static Widget showLoader(String message) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.cgreenColor,
          ),
          TextWidgets.textWidget(message, AppColors.cwhiteColor,
              fontSize: 14, fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
