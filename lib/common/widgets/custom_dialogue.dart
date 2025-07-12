import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogue {
  static void show(
    BuildContext context, {
    required String titleText,
    required String contentText,
    required String noButtonText,
    required String yesButtonText,
    required VoidCallback onNoPressed,
    required VoidCallback onYesPressed,
    TextStyle? titleTextStyle,
    TextStyle? buttonTextStyle,
    TextDecoration? yesButtonDecoration,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titlePadding: EdgeInsets.all(20.0),
          title: TextWidgets.textWidget(titleText, AppColors.cblackColor,
              fontSize: titleTextStyle?.fontSize ?? 18,
              fontWeight: titleTextStyle?.fontWeight ?? FontWeight.bold,
              textAlign: TextAlign.start),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          content: TextWidgets.textWidget(titleText, AppColors.cblackColor,
              fontSize: titleTextStyle?.fontSize ?? 18,
              fontWeight: titleTextStyle?.fontWeight ?? FontWeight.bold,
              textAlign: TextAlign.start),
          actionsPadding: EdgeInsets.all(20.0),
          actions: <Widget>[
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ButtonWidgets.elevatedButton(noButtonText,
                        AppColors.cRedColor, AppColors.cwhiteColor, onNoPressed,
                        radius: 6,
                        width: 80,
                        height: 40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                Expanded(
                    child: ButtonWidgets.elevatedButton(
                        yesButtonText,
                        AppColors.cgreenColor,
                        AppColors.cwhiteColor,
                        onYesPressed,
                        radius: 6,
                        width: 105,
                        height: 40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        );
      },
    );
  }
}
