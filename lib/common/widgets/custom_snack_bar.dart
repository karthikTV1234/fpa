import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  BuildContext context;
  String message;
  String messageType;

  CustomSnackBar({
    required this.context,
    required this.message,
    required this.messageType,
  });

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: AppUtils.getSnackBarColor(messageType),
        duration: Duration(seconds: 2),
        content: TextWidgets.textWidget(message, AppColors.cwhiteColor,
            fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
