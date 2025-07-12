import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_style_widget.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> dropdownMenuItems;
  final String? labelText;
  final Widget? hint;
  final Function(String)? onChanged;
  final String? value;
  final double? labelFont;
  final double? textFont;
  final FontWeight? fontWeight;
  final String? Function(String?)? validator;

  const CustomDropDown({
    super.key,
    this.validator,
    required this.dropdownMenuItems,
    this.labelText,
    this.hint,
    this.onChanged,
    this.value,
    this.labelFont,
    this.textFont,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      hint: hint,
      value: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.cmediumGrayColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.cmediumGrayColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.cRedColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.cRedColor),
        ),
        labelText: labelText,
        labelStyle: TextStyleWidget.textStyleWidget(AppColors.cblackColor,
            fontSize: labelFont),
        filled: true,
        fillColor: AppColors.appBackGroundColor,
      ),
      items: dropdownMenuItems.map((String item) {
        return DropdownMenuItem(
            value: item,
            child: TextWidgets.textWidget(item, AppColors.cblackColor,
                fontSize: 14, fontWeight: FontWeight.normal));
      }).toList(),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value ?? "");
        }
      },
    );
  }
}
