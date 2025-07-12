import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Color getSnackBarColor(messageType) {
    var selectedColor = AppColors.cSkyBlueColor;
    switch (messageType) {
      case AppStrings.warning:
        return selectedColor = AppColors.cLightOrangeColor;
      case AppStrings.success:
        return selectedColor = AppColors.cgreenColor;
      case AppStrings.failure:
        return selectedColor = AppColors.cRedColor;
    }
    return selectedColor;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
