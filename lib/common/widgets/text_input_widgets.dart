// ignore_for_file: deprecated_member_use

import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidgets {
  static Widget getTextField(
      {String? labelText,
      String? hintText,
      TextEditingController? controller,
      final ValueChanged<String>? onChanged,
      double fontSize = 10.0,
      Color textColor = AppColors.darkBackgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      TextInputType? keyboardType,
      String fontFamily = "Roboto",
      bool obscureText = false,
      List<TextInputFormatter>? inputFormatters,
      Color? fillColor,
      double borderRadius = 8.0,
      Widget? prefixIcon
      }) {
    return TextField(
      inputFormatters: inputFormatters,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged(value);
        }
      },
      controller: controller,
      cursorColor: AppColors.cblackColor,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyleWidget.textStyleWidget(
          textColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
        border: InputBorder.none,
        filled: true,
        contentPadding: EdgeInsets.only(left: 10),
        fillColor: fillColor ?? AppColors.cwhiteColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)),
        prefixIcon: prefixIcon,
      ),
    );
  }

  static Widget textFormField(
    String? labelText,
    TextInputType textInputType,
    TextInputAction textInputAction,
    TextEditingController controller,
    bool obscureText, {
    String? hintText,
    bool readOnly = false,
    Color? fillColor,
    ValueChanged<String>? onChanged,
    int? maxLines = 1,
    bool? enabled,
    TextStyle? labelStyle,
    VoidCallback? customTap,
    double? labelFontSize,
    double? hintFontSize,
    String? Function(String?)? validator,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? focusederrorBorderColor,
    Widget? trailingIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      enabled: enabled,
      onTap: customTap,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      cursorColor: AppColors.cblackColor,
      keyboardType: textInputType,
      validator: validator,
      maxLines: maxLines,
      style: TextStyleWidget.textStyleWidget(AppColors.cblackColor,
          fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle ??
              TextStyleWidget.textStyleWidget(
                AppColors.cblackColor,
                fontSize: labelFontSize ?? 14,
                fontWeight: FontWeight.w500,
              ),
          hintText: hintText,
          hintStyle: TextStyleWidget.textStyleWidget(
            AppColors.cblackColor.withOpacity(0.5),
            fontSize: hintFontSize ?? 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: fillColor ?? AppColors.cwhiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: enabledBorderColor ?? AppColors.cwhiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: focusedBorderColor ?? AppColors.cwhiteColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: errorBorderColor ?? AppColors.cRedColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: focusederrorBorderColor ?? AppColors.cRedColor),
          ),
          suffixIcon: trailingIcon),
    );
  }
}
