import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/shared/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ParentWidget extends StatelessWidget {
  final BuildContext context;
  final Widget childWidget;
  final bool hasHeader;
  final Color appbarColor;
  final Color appbarTitleColor;
  final String appbarTitle;
  final VoidCallback? onSubTitlePressed;
  final List<Widget>? actionItems;
  final Widget? floatingActionButton;
  final double? appbarHeight;
  final String? appbarSubtitle;
  final void Function()? onRightWidgetTap;
  final String? rightLabel;
  final Widget? rightWidget;
  final Widget? leadingWidget;
  final Widget? subtitleTrailingWidget;
  final Widget? bottomNavigationBar;
  const ParentWidget(
      {super.key,
      required this.context,
      required this.childWidget,
      this.appbarHeight,
      this.appbarTitle = '',
      this.appbarSubtitle,
      this.onRightWidgetTap,
      this.rightLabel,
      this.subtitleTrailingWidget,
      this.rightWidget,
      this.leadingWidget,
      this.appbarColor = AppColors.lightBackgroundColor,
      this.appbarTitleColor = AppColors.darkBackgroundColor,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.onSubTitlePressed,
      this.actionItems = const [],
      required this.hasHeader});

  @override
  Widget build(BuildContext context) {
    double padding = AppUtils.getScreenWidth(context) * 0.3;
    return kIsWeb
        ? Scaffold(
            appBar: hasHeader
                ? CustomAppbar(
                    subtitleTrailingWidget: subtitleTrailingWidget,
                    leadingWidget: leadingWidget,
                    appbarSubtitle: appbarSubtitle,
                    appbarHeight: appbarHeight ?? 70.0,
                    appbarBgColor: appbarColor,
                    appbarTitle: appbarTitle,
                    titleColor: appbarTitleColor,
                    onSubTitlePressed: onSubTitlePressed,
                    onRightWidgetTap: onRightWidgetTap,
                    rightWidget: rightWidget,
                  )
                : null,
            body: Stack(
              children: [
                Container(
                  width: AppUtils.getScreenWidth(context),
                  height: AppUtils.getScreenHeight(context),
                  color: AppColors.appBackGroundColor,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: childWidget,
                  ),
                )
              ],
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: hasHeader
                  ? CustomAppbar(
                      subtitleTrailingWidget: subtitleTrailingWidget,
                      leadingWidget: leadingWidget,
                      appbarSubtitle: appbarSubtitle,
                      appbarHeight: appbarHeight ?? 70.0,
                      appbarBgColor: appbarColor,
                      appbarTitle: appbarTitle,
                      titleColor: appbarTitleColor,
                      onSubTitlePressed: onSubTitlePressed,
                      onRightWidgetTap: onRightWidgetTap,
                      rightLabel: rightLabel,
                      rightWidget: rightWidget,
                    )
                  : null,
              backgroundColor: AppColors.appBackGroundColor,
              body: childWidget,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          );
  }
}
