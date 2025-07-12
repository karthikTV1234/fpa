import 'package:flutter/material.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';

class CommonCardItem extends StatelessWidget {
  final String category;
  final String status;
  final Color statusColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CommonCardItem({
    super.key,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.cwhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          TextWidgets.textWidget(
                            textAlign: TextAlign.left,
                            category,
                            AppColors.cblackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: statusColor,
                            ),
                            child: TextWidgets.textWidget(
                              status,
                              AppColors.cblackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      TextWidgets.textWidget(
                        textAlign: TextAlign.left,
                        title,
                        AppColors.cblackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidgets.textWidget(
                        textAlign: TextAlign.left,
                        subtitle,
                        AppColors.cblackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                   Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16,
                    color: AppColors.cblackColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
