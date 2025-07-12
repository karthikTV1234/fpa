import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ListviewCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String? subTitle;
  final bool hasDivider;
  final double? titlefontSize;
  final FontWeight? titlefontWeight;
  final double? subtitlefontSize;
  final FontWeight? subtitlefontWeight;
  const ListviewCard(
      {super.key,
      required this.icon,
      required this.title,
      this.subTitle,
      this.titlefontSize,
      this.titlefontWeight,
      this.subtitlefontSize,
      this.subtitlefontWeight,
      this.hasDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SingleChildScrollView(
          child: Row(
            spacing: 20,
            children: [
              icon,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textWidget(title, AppColors.cblackColor,
                        fontWeight: titlefontWeight ?? FontWeight.w700,
                        fontSize: titlefontSize ?? 19.0,
                        textAlign: TextAlign.start),
                    TextWidgets.textWidget(subTitle!, AppColors.cblackColor,
                        fontWeight: subtitlefontWeight ?? FontWeight.w400,
                        fontSize: subtitlefontSize ?? 16.0,
                        textAlign: TextAlign.start)
                  ],
                ),
              )
            ],
          ),
        ),
        hasDivider ? Divider() : SizedBox.shrink()
      ],
    );
  }
}
