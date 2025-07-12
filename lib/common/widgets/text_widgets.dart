import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/text_style_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextWidgets {
  static Widget textWidget(String title, Color color,
      {double fontSize = 10.0,
      FontWeight fontWeight = FontWeight.normal,
      String fontFamily = 'Roboto',
      TextDecoration decoration = TextDecoration.none,
      Color decorationColor = AppColors.darkBackgroundColor,
      hasOverflow = false,
      TextAlign? textAlign}) {
    return Text(title,
        overflow: hasOverflow ? TextOverflow.ellipsis : null,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyleWidget.textStyleWidget(color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            decoration: decoration,
            decorationColor: decorationColor));
  }

  static Widget richText(
    lTextTitle,
    lTextColor,
    lTextFontsize,
    rTextTitle,
    rTextColor,
    rTextFontsize, {
    lTextFontWeigt,
    rTextFontWeight,
    lDecoration,
    rDecoration,
    lDecorationColor,
    rDecorationColor,
    bool isRTextClickable = false,
    VoidCallback? onRTextTap,
  }) {
    return Text.rich(
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: [
          textSpanWidget(lTextTitle, lTextColor, lTextFontsize,
              fontWeight: lTextFontWeigt,
              decoration: lDecoration,
              decorationColor: lDecorationColor),
          textSpanWidget(rTextTitle, rTextColor, rTextFontsize,
              fontWeight: rTextFontWeight,
              decoration: rDecoration,
              decorationColor: rDecorationColor,
              isClickable: isRTextClickable,
              onTap: onRTextTap!),
        ],
      ),
    );
  }

  static TextSpan textSpanWidget(
    String title,
    Color textColor,
    double fontSize, {
    fontWeight,
    decoration,
    decorationColor,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return TextSpan(
        text: title,
        recognizer:
            isClickable ? (TapGestureRecognizer()..onTap = onTap) : null,
        style: TextStyleWidget.textStyleWidget(
          textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: decorationColor,
        ));
  }

  static Widget termsAndPrivacyRichText({
    required String firstText,
    required Color firstTextColor,
    required double firstTextFontSize,
    required String secondText,
    required Color secondTextColor,
    required double secondTextFontSize,
    required String thirdText,
    required Color thirdTextColor,
    required double thirdTextFontSize,
    required String fourthText,
    required Color fourthTextColor,
    required double fourthTextFontSize,
    required VoidCallback onSecondTextTap,
    required VoidCallback onFourthTextTap,
    FontWeight? firstTextFontWeight,
    FontWeight? secondTextFontWeight,
    FontWeight? thirdTextFontWeight,
    FontWeight? fourthTextFontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
            color: firstTextColor,
            fontSize: firstTextFontSize,
            fontWeight: firstTextFontWeight ?? FontWeight.normal,
          ),
          textAlign: textAlign,
        ),
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            children: [
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontSize: secondTextFontSize,
                  fontWeight: secondTextFontWeight ?? FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onSecondTextTap,
              ),
              TextSpan(
                text: thirdText,
                style: TextStyle(
                  color: thirdTextColor,
                  fontSize: thirdTextFontSize,
                  fontWeight: thirdTextFontWeight ?? FontWeight.normal,
                ),
              ),
              TextSpan(
                text: fourthText,
                style: TextStyle(
                  color: fourthTextColor,
                  fontSize: fourthTextFontSize,
                  fontWeight: fourthTextFontWeight ?? FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onFourthTextTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
