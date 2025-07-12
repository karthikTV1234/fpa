import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color/app_colors.dart';

class CustomCardView extends StatelessWidget {
  final Color cardColor;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final String title;
  final String? badge;
  final Color? badgeColor;
  final String title2;
  final String subtitle1;
  final String subtitle2;

  const CustomCardView({
    super.key,
    required this.cardColor,
    required this.margin,
    required this.borderRadius,
    required this.title,
    this.badge,
    this.badgeColor,
    required this.title2,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidgets.textWidget(
                  title,
                  AppColors.cblackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                if (badge != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor ?? Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextWidgets.textWidget(
                      badge!,
                      AppColors.cwhiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextWidgets.textWidget(
                    textAlign: TextAlign.left,
                    title2,
                    AppColors.cblackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
            TextWidgets.textWidget(
              subtitle1,
              AppColors.cblackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            subtitle2.isNotEmpty
                ? TextWidgets.textWidget(
                    subtitle2,
                    AppColors.cblackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
