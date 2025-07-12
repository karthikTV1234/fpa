import 'package:flutter/material.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';

class CustomRadioListTile extends StatelessWidget {
  final String title;
  final int value;
  final int? groupValue;
  final Function(int?) onChanged;

  const CustomRadioListTile({
    super.key,
    required this.title,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      contentPadding: EdgeInsets.zero,
      title: TextWidgets.textWidget(
        title,
        AppColors.cblackColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.left,
      ),
      value: value,
      splashRadius: 0.0,
      groupValue: groupValue,
      onChanged: onChanged,
      dense: true,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: AppColors.cprimaryColor,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
