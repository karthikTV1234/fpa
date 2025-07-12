// ignore_for_file: deprecated_member_use

import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? appbarBgColor;
  final double appbarHeight;
  final String? appbarTitle;
  final String? appbarSubtitle;
  final Color? titleColor;

  final Widget? leadingWidget;

  final Widget? rightWidget;

  final String? rightLabel;

  final VoidCallback? onSubTitlePressed;

  final VoidCallback? onRightWidgetTap;
  final Widget? subtitleTrailingWidget;
  const CustomAppbar({
    super.key,
    this.appbarBgColor,
    this.appbarHeight = 70.0,
    this.appbarTitle,
    this.appbarSubtitle,
    this.titleColor,
    this.subtitleTrailingWidget,
    this.leadingWidget,
    this.rightWidget,
    this.rightLabel,
    this.onSubTitlePressed,
    this.onRightWidgetTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appbarBgColor ?? Colors.grey[300],
      child: SafeArea(
        bottom: false,
        child: Container(
          height: appbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget ?? SizedBox.shrink(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textWidget(
                      appbarTitle ?? '',
                      titleColor ?? Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    if (appbarSubtitle != null)
                      GestureDetector(
                        onTap: onSubTitlePressed,
                        child: Row(
                          spacing: 4,
                          children: [
                            TextWidgets.textWidget(
                              appbarSubtitle!,
                              titleColor ?? AppColors.cblackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            if (subtitleTrailingWidget != null) ...[
                              subtitleTrailingWidget!,
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (rightWidget != null)
                InkWell(
                  onTap: onRightWidgetTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rightWidget!,
                      if (rightLabel != null && rightLabel!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        TextWidgets.textWidget(
                          rightLabel!,
                          AppColors.cblackColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);
}
