import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CustomSeparatedListView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>)? onItemTap;
  final EdgeInsetsGeometry? padding;

  const CustomSeparatedListView({
    super.key,
    required this.items,
    this.onItemTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      itemCount: items.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: AppColors.cmediumGrayColor,
      ),
      itemBuilder: (context, index) {
        final record = items[index];
        return InkWell(
          onTap: () => onItemTap?.call(record),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 54,
            color: AppColors.cwhiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      record["icon"],
                      color: AppColors.cblackColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    TextWidgets.textWidget(
                      record["title"],
                      AppColors.cblackColor,
                      fontSize: 16,
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
